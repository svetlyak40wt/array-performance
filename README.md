# Common Lisp Array Performance Benchmark

This benchmark compares performance of lists and arrays access.

It calculates a sqrt of squars across random single or double float values for:

* list
* simple-vector
* adjustable-vector

Number crunching done in two ways:

- by iteration across a list or a vector;
- by accessing list items using `elt` and vector items using `aref`.

Also comparison is made in two modes, when an iteration function
know nothing about list or vector elements type and when it is aware
and optimized to work with this type.

Test measures an average time of one element access with consequent multiplication.

## How to run this benchmark

1. Checkout the repository.
2. Do `(push "/path/to/array-performance/ asdf:*central-registry*)`.
3. Do `(ql:quickload :array-performance)`.
4. Run the benchmark `(array-perfomance:run-benchmark)`.

## Here are results from Macbook i5 laptop

This machine has 8G of 1600 MHz DDR3 RAM and 2.6 GHz Intel Core i5 4 CPU chip.
Lisp implementation is SBCL 1.5.5.

My first attempt was to run test on 10 million items. But it was running few hours and
I wasn't able to wait while it finish.

which takes few hours because
This is because access time for `elt` grown exponentially.

Here are results for 10, 100 and 1000 elements in the list/array:

### SBCL 1.5.5

```
ARRAY-PERFORMANCE> (run-benchmark 10)
.------------------------------------------------------------------------.
|                           Generic functions                            |
+--------------------------------+-------------------+-------------------+
| Test                           | Time              | Elt/Aref Time     |
+--------------------------------+-------------------+-------------------+
| Single-float list              | 14.42 nanoseconds | 19.66 nanoseconds |
| Double-float list              | 19.98 nanoseconds | 26.46 nanoseconds |
| Single-float simple vector     | 16.96 nanoseconds | 17.81 nanoseconds |
| Double-float simple vector     | 25.26 nanoseconds | 25.54 nanoseconds |
| Single-float adjustable vector | 19.45 nanoseconds | 19.87 nanoseconds |
| Double-float adjustable vector | 26.40 nanoseconds | 27.23 nanoseconds |
+--------------------------------+-------------------+-------------------+

.-------------------------------------------------------------------------.
|                          Specialized functions                          |
+--------------------------------+--------------------+-------------------+
| Test                           | Time               | Elt/Aref Time     |
+--------------------------------+--------------------+-------------------+
| Single-float list              | 1.47 nanoseconds   | 8.37 nanoseconds  |
| Double-float list              | 2.18 nanoseconds   | 8.69 nanoseconds  |
| Single-float simple vector     | 902.63 picoseconds | 1.22 nanoseconds  |
| Double-float simple vector     | 995.63 picoseconds | 1.29 nanoseconds  |
| Single-float adjustable vector | 8.11 nanoseconds   | 8.98 nanoseconds  |
| Double-float adjustable vector | 9.70 nanoseconds   | 10.02 nanoseconds |
+--------------------------------+--------------------+-------------------+

ARRAY-PERFORMANCE> (run-benchmark 100)
.------------------------------------------------------------------------.
|                           Generic functions                            |
+--------------------------------+-------------------+-------------------+
| Test                           | Time              | Elt/Aref Time     |
+--------------------------------+-------------------+-------------------+
| Single-float list              | 13.08 nanoseconds | 72.92 nanoseconds |
| Double-float list              | 17.66 nanoseconds | 81.90 nanoseconds |
| Single-float simple vector     | 15.97 nanoseconds | 16.59 nanoseconds |
| Double-float simple vector     | 23.23 nanoseconds | 23.51 nanoseconds |
| Single-float adjustable vector | 17.84 nanoseconds | 18.71 nanoseconds |
| Double-float adjustable vector | 25.05 nanoseconds | 25.83 nanoseconds |
+--------------------------------+-------------------+-------------------+

.--------------------------------------------------------------------------.
|                          Specialized functions                           |
+--------------------------------+--------------------+--------------------+
| Test                           | Time               | Elt/Aref Time      |
+--------------------------------+--------------------+--------------------+
| Single-float list              | 1.42 nanoseconds   | 73.39 nanoseconds  |
| Double-float list              | 1.99 nanoseconds   | 59.68 nanoseconds  |
| Single-float simple vector     | 902.43 picoseconds | 943.01 picoseconds |
| Double-float simple vector     | 905.80 picoseconds | 938.78 picoseconds |
| Single-float adjustable vector | 6.86 nanoseconds   | 7.44 nanoseconds   |
| Double-float adjustable vector | 9.53 nanoseconds   | 10.05 nanoseconds  |
+--------------------------------+--------------------+--------------------+

ARRAY-PERFORMANCE> (run-benchmark 1000)
.-------------------------------------------------------------------------.
|                            Generic functions                            |
+--------------------------------+-------------------+--------------------+
| Test                           | Time              | Elt/Aref Time      |
+--------------------------------+-------------------+--------------------+
| Single-float list              | 13.05 nanoseconds | 662.11 nanoseconds |
| Double-float list              | 17.43 nanoseconds | 667.29 nanoseconds |
| Single-float simple vector     | 15.81 nanoseconds | 16.87 nanoseconds  |
| Double-float simple vector     | 24.15 nanoseconds | 24.12 nanoseconds  |
| Single-float adjustable vector | 17.79 nanoseconds | 18.37 nanoseconds  |
| Double-float adjustable vector | 25.40 nanoseconds | 25.27 nanoseconds  |
+--------------------------------+-------------------+--------------------+

.--------------------------------------------------------------------------.
|                          Specialized functions                           |
+--------------------------------+--------------------+--------------------+
| Test                           | Time               | Elt/Aref Time      |
+--------------------------------+--------------------+--------------------+
| Single-float list              | 1.31 nanoseconds   | 644.82 nanoseconds |
| Double-float list              | 1.63 nanoseconds   | 641.62 nanoseconds |
| Single-float simple vector     | 964.36 picoseconds | 967.30 picoseconds |
| Double-float simple vector     | 963.64 picoseconds | 979.60 picoseconds |
| Single-float adjustable vector | 6.77 nanoseconds   | 7.35 nanoseconds   |
| Double-float adjustable vector | 9.44 nanoseconds   | 9.18 nanoseconds   |
+--------------------------------+--------------------+--------------------+
```

### SBCL 2.0.4

```
CL-USER> (array-performance:run-benchmark 10)
.------------------------------------------------------------------------.
|                           Generic functions                            |
+--------------------------------+-------------------+-------------------+
| Test                           | Time              | Elt/Aref Time     |
+--------------------------------+-------------------+-------------------+
| Single-float list              | 13.97 nanoseconds | 19.57 nanoseconds |
| Double-float list              | 24.29 nanoseconds | 24.64 nanoseconds |
| Single-float simple vector     | 24.18 nanoseconds | 30.86 nanoseconds |
| Double-float simple vector     | 31.48 nanoseconds | 25.36 nanoseconds |
| Single-float adjustable vector | 18.65 nanoseconds | 18.93 nanoseconds |
| Double-float adjustable vector | 27.22 nanoseconds | 27.09 nanoseconds |
+--------------------------------+-------------------+-------------------+

.------------------------------------------------------------------------.
|                         Specialized functions                          |
+--------------------------------+-------------------+-------------------+
| Test                           | Time              | Elt/Aref Time     |
+--------------------------------+-------------------+-------------------+
| Single-float list              | 1.60 nanoseconds  | 8.33 nanoseconds  |
| Double-float list              | 2.02 nanoseconds  | 8.65 nanoseconds  |
| Single-float simple vector     | 1.09 nanoseconds  | 1.42 nanoseconds  |
| Double-float simple vector     | 1.13 nanoseconds  | 1.51 nanoseconds  |
| Single-float adjustable vector | 7.89 nanoseconds  | 8.53 nanoseconds  |
| Double-float adjustable vector | 10.66 nanoseconds | 10.98 nanoseconds |
+--------------------------------+-------------------+-------------------+

CL-USER> (array-performance:run-benchmark 100)
.------------------------------------------------------------------------.
|                           Generic functions                            |
+--------------------------------+-------------------+-------------------+
| Test                           | Time              | Elt/Aref Time     |
+--------------------------------+-------------------+-------------------+
| Single-float list              | 12.74 nanoseconds | 72.62 nanoseconds |
| Double-float list              | 18.06 nanoseconds | 82.24 nanoseconds |
| Single-float simple vector     | 16.22 nanoseconds | 16.24 nanoseconds |
| Double-float simple vector     | 22.37 nanoseconds | 24.25 nanoseconds |
| Single-float adjustable vector | 18.80 nanoseconds | 18.54 nanoseconds |
| Double-float adjustable vector | 24.75 nanoseconds | 24.76 nanoseconds |
+--------------------------------+-------------------+-------------------+

.--------------------------------------------------------------------------.
|                          Specialized functions                           |
+--------------------------------+--------------------+--------------------+
| Test                           | Time               | Elt/Aref Time      |
+--------------------------------+--------------------+--------------------+
| Single-float list              | 1.40 nanoseconds   | 59.36 nanoseconds  |
| Double-float list              | 2.05 nanoseconds   | 59.88 nanoseconds  |
| Single-float simple vector     | 920.74 picoseconds | 968.34 picoseconds |
| Double-float simple vector     | 918.23 picoseconds | 981.91 picoseconds |
| Single-float adjustable vector | 8.68 nanoseconds   | 8.98 nanoseconds   |
| Double-float adjustable vector | 9.32 nanoseconds   | 9.45 nanoseconds   |
+--------------------------------+--------------------+--------------------+

CL-USER> (array-performance:run-benchmark 1000)
.-------------------------------------------------------------------------.
|                            Generic functions                            |
+--------------------------------+-------------------+--------------------+
| Test                           | Time              | Elt/Aref Time      |
+--------------------------------+-------------------+--------------------+
| Single-float list              | 12.92 nanoseconds | 657.57 nanoseconds |
| Double-float list              | 17.63 nanoseconds | 665.41 nanoseconds |
| Single-float simple vector     | 16.16 nanoseconds | 16.22 nanoseconds  |
| Double-float simple vector     | 22.79 nanoseconds | 24.71 nanoseconds  |
| Single-float adjustable vector | 18.05 nanoseconds | 17.96 nanoseconds  |
| Double-float adjustable vector | 24.84 nanoseconds | 24.79 nanoseconds  |
+--------------------------------+-------------------+--------------------+

.--------------------------------------------------------------------------.
|                          Specialized functions                           |
+--------------------------------+--------------------+--------------------+
| Test                           | Time               | Elt/Aref Time      |
+--------------------------------+--------------------+--------------------+
| Single-float list              | 1.31 nanoseconds   | 641.07 nanoseconds |
| Double-float list              | 1.53 nanoseconds   | 648.63 nanoseconds |
| Single-float simple vector     | 968.50 picoseconds | 970.55 picoseconds |
| Double-float simple vector     | 980.35 picoseconds | 982.20 picoseconds |
| Single-float adjustable vector | 7.40 nanoseconds   | 8.02 nanoseconds   |
| Double-float adjustable vector | 9.43 nanoseconds   | 9.32 nanoseconds   |
+--------------------------------+--------------------+--------------------+
```

## Conclusion

* SBCL 2.0.0 performs the same like 1.5.5
* Access to `simple-vector` is 7-9 times faster than access to `adjustable-vector`.
