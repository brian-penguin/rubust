# Benchmarks 

run using `bundle exec rake bench`

first pass results using the small file at `./test/support/example.csv` with two rows (plus headers) and two columns

```
Warming up --------------------------------------
rust small file to array
                         5.000  i/100ms
rust small file to hash
                         5.000  i/100ms
ruby small file to array
                         2.000  i/100ms
ruby small file to hash
                         1.000  i/100ms
Calculating -------------------------------------
rust small file to array
                         57.876  (± 1.7%) i/s -    290.000  in   5.013558s
rust small file to hash
                         53.075  (± 1.9%) i/s -    270.000  in   5.090430s
ruby small file to array
                         22.052  (± 4.5%) i/s -    112.000  in   5.085134s
ruby small file to hash
                         18.225  (± 5.5%) i/s -     92.000  in   5.053807s

Comparison:
rust small file to array:       57.9 i/s
rust small file to hash:       53.1 i/s - 1.09x  slower
ruby small file to array:       22.1 i/s - 2.62x  slower
ruby small file to hash:       18.2 i/s - 3.18x  slower

```


Second pass, few columns mid-sized file 

```
Warming up --------------------------------------
rust 6.4 MB file to array
                         1.000  i/100ms
rust 6.4 MB file to hash
                         1.000  i/100ms
ruby 6.4 MB file to array
                         1.000  i/100ms
ruby 6.4 MB file to hash
                         1.000  i/100ms
Calculating -------------------------------------
rust 6.4 MB file to array
                          0.057  (± 0.0%) i/s -      1.000  in  17.611532s
rust 6.4 MB file to hash
                          0.021  (± 0.0%) i/s -      1.000  in  47.859645s
ruby 6.4 MB file to array
                          0.021  (± 0.0%) i/s -      1.000  in  47.581674s
ruby 6.4 MB file to hash
                          0.009  (± 0.0%) i/s -      1.000  in 116.703598s

Comparison:
rust 6.4 MB file to array:        0.1 i/s
ruby 6.4 MB file to array:        0.0 i/s - 2.70x  slower
rust 6.4 MB file to hash:        0.0 i/s - 2.72x  slower
ruby 6.4 MB file to hash:        0.0 i/s - 6.63x  slower

```
