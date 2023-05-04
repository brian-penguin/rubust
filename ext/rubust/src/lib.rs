use magnus::{define_module, function, prelude::*, Error, exception};
use csv;
use std::collections::HashMap;

fn hello(subject: String) -> String {
    format!("Hello from Rust, {}!", subject)
}

fn parse_csv_to_hash(file_path: String) -> Result<Vec<HashMap<String, String>>, Error> {
    let mut reader = match csv::Reader::from_path(file_path){
        Ok(rdr) => rdr,
        Err(e) => return Err(Error::new(exception::standard_error(), e.to_string()))
    };

    let mut data: Vec<HashMap<String,String>> = Vec::new();

    let header_records = match reader.headers() {
        Ok(h) => h,
        Err(e) => return Err(Error::new(exception::standard_error(), e.to_string()))
    };

    let header_strings: Vec<String> = header_records.iter().map(|header_record| header_record.to_string()).collect();

    for result in reader.records() {
        let mut record_values: HashMap<String,String> = HashMap::new();
        let record = match result {
            Ok(r) => r,
            Err(e) => return Err(Error::new(exception::standard_error(), e.to_string()))
        };

        for(index, value) in record.iter().enumerate() {
           record_values.insert(header_strings[index].clone(), value.to_string());
        };

        data.push(record_values);
    };

    Ok(data)
}

fn parse_csv(file_path: String, include_headers: bool) -> Result<Vec<Vec<String>>, Error > {
    let mut reader = match csv::Reader::from_path(file_path){
        Ok(rdr) => rdr,
        Err(e) => return Err(Error::new(exception::standard_error(), e.to_string()))
    };

    let mut data: Vec<Vec<String>> = Vec::new();

    if include_headers {
        let mut header_values = Vec::new();
        let headers = match reader.headers() {
            Ok(headers) => headers,
            Err(e) => return Err(Error::new(exception::standard_error(), e.to_string()))
        };
        for header_value in headers {
            header_values.push(header_value.to_string());
        };
        data.push(header_values);
    };

    for result in reader.records() {
        let record = match result {
            Ok(record) => record,
            Err(e) => return Err(Error::new(exception::standard_error(), e.to_string()))
        };

        let mut record_value_collection = Vec::new();

        for value in record.iter() {
            record_value_collection.push(value.to_string());
        };

        data.push(record_value_collection);
    };

    Ok(data)
}

#[magnus::init]
fn init() -> Result<(), Error> {
    let module = define_module("Rubust")?;
    module.define_singleton_method("hello", function!(hello, 1))?;
    module.define_singleton_method("parse_csv", function!(parse_csv, 2))?;
    module.define_singleton_method("parse_csv_to_hash", function!(parse_csv_to_hash, 1))?;
    Ok(())
}
