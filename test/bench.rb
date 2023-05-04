# frozen_string_literal: true

require "benchmark/ips"
require "csv"
require_relative "../lib/rubust"

n = 100

def ruby_parse_csv(file_name)
  CSV.read(file_name)
end

def ruby_parse_csv_to_hash(file_name)
  CSV.read(file_name, headers: true).map(&:to_h)
end

Benchmark.ips do |x|
  # x.report("rust small file to array") do
  #   n.times { |i| Rubust.parse_csv("./test/support/example.csv", true) }
  # end

  # x.report("rust small file to hash") do
  #   n.times { |i| Rubust.parse_csv_to_hash("./test/support/example.csv") }
  # end

  # x.report("ruby small file to array") do
  #   n.times { |i| ruby_parse_csv("./test/support/example.csv") }
  # end

  # x.report("ruby small file to hash") do
  #   n.times { |i| ruby_parse_csv_to_hash("./test/support/example.csv") }
  # end

  x.report("rust 6.4 MB file to array") do
    n.times { |i| Rubust.parse_csv("./test/support/mid-size.csv", true) }
  end

  x.report("rust 6.4 MB file to hash") do
    n.times { |i| Rubust.parse_csv_to_hash("./test/support/mid-size.csv") }
  end

  x.report("ruby 6.4 MB file to array") do
    n.times { |i| ruby_parse_csv("./test/support/mid-size.csv") }
  end

  x.report("ruby 6.4 MB file to hash") do
    n.times { |i| ruby_parse_csv_to_hash("./test/support/mid-size.csv") }
  end

  x.compare!
end
