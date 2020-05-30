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

### ClozureCL 1.12

```
CL-USER> (array-performance:run-benchmark 10)
.------------------------------------------------------------------------.
|                           Generic functions                            |
+--------------------------------+-------------------+-------------------+
| Test                           | Time              | Elt/Aref Time     |
+--------------------------------+-------------------+-------------------+
| Single-float list              | 24.36 nanoseconds | 56.29 nanoseconds |
| Double-float list              | 53.81 nanoseconds | 82.57 nanoseconds |
| Single-float simple vector     | 27.63 nanoseconds | 28.71 nanoseconds |
| Double-float simple vector     | 71.84 nanoseconds | 73.67 nanoseconds |
| Single-float adjustable vector | 39.74 nanoseconds | 43.66 nanoseconds |
| Double-float adjustable vector | 82.45 nanoseconds | 87.29 nanoseconds |
+--------------------------------+-------------------+-------------------+

.------------------------------------------------------------------------.
|                         Specialized functions                          |
+--------------------------------+-------------------+-------------------+
| Test                           | Time              | Elt/Aref Time     |
+--------------------------------+-------------------+-------------------+
| Single-float list              | 8.62 nanoseconds  | 38.89 nanoseconds |
| Double-float list              | 13.52 nanoseconds | 42.88 nanoseconds |
| Single-float simple vector     | 11.36 nanoseconds | 11.19 nanoseconds |
| Double-float simple vector     | 30.06 nanoseconds | 31.08 nanoseconds |
| Single-float adjustable vector | 25.56 nanoseconds | 24.55 nanoseconds |
| Double-float adjustable vector | 41.31 nanoseconds | 41.39 nanoseconds |
+--------------------------------+-------------------+-------------------+

CL-USER> (array-performance:run-benchmark 100)
.-------------------------------------------------------------------------.
|                            Generic functions                            |
+--------------------------------+-------------------+--------------------+
| Test                           | Time              | Elt/Aref Time      |
+--------------------------------+-------------------+--------------------+
| Single-float list              | 18.32 nanoseconds | 247.95 nanoseconds |
| Double-float list              | 42.79 nanoseconds | 272.14 nanoseconds |
| Single-float simple vector     | 21.58 nanoseconds | 21.99 nanoseconds  |
| Double-float simple vector     | 63.22 nanoseconds | 66.11 nanoseconds  |
| Single-float adjustable vector | 34.14 nanoseconds | 34.26 nanoseconds  |
| Double-float adjustable vector | 70.51 nanoseconds | 68.50 nanoseconds  |
+--------------------------------+-------------------+--------------------+

.-------------------------------------------------------------------------.
|                          Specialized functions                          |
+--------------------------------+-------------------+--------------------+
| Test                           | Time              | Elt/Aref Time      |
+--------------------------------+-------------------+--------------------+
| Single-float list              | 4.92 nanoseconds  | 229.52 nanoseconds |
| Double-float list              | 5.06 nanoseconds  | 237.44 nanoseconds |
| Single-float simple vector     | 7.29 nanoseconds  | 7.42 nanoseconds   |
| Double-float simple vector     | 22.00 nanoseconds | 22.26 nanoseconds  |
| Single-float adjustable vector | 19.48 nanoseconds | 19.50 nanoseconds  |
| Double-float adjustable vector | 31.78 nanoseconds | 31.62 nanoseconds  |
+--------------------------------+-------------------+--------------------+

CL-USER> (array-performance:run-benchmark 1000)
.------------------------------------------------------------------------.
|                           Generic functions                            |
+--------------------------------+-------------------+-------------------+
| Test                           | Time              | Elt/Aref Time     |
+--------------------------------+-------------------+-------------------+
| Single-float list              | 17.48 nanoseconds | 2.18 microseconds |
| Double-float list              | 41.80 nanoseconds | 2.19 microseconds |
| Single-float simple vector     | 21.57 nanoseconds | 21.89 nanoseconds |
| Double-float simple vector     | 62.76 nanoseconds | 64.41 nanoseconds |
| Single-float adjustable vector | 33.96 nanoseconds | 33.97 nanoseconds |
| Double-float adjustable vector | 66.81 nanoseconds | 68.04 nanoseconds |
+--------------------------------+-------------------+-------------------+

.------------------------------------------------------------------------.
|                         Specialized functions                          |
+--------------------------------+-------------------+-------------------+
| Test                           | Time              | Elt/Aref Time     |
+--------------------------------+-------------------+-------------------+
| Single-float list              | 4.37 nanoseconds  | 2.14 microseconds |
| Double-float list              | 4.25 nanoseconds  | 2.13 microseconds |
| Single-float simple vector     | 6.64 nanoseconds  | 6.80 nanoseconds  |
| Double-float simple vector     | 21.19 nanoseconds | 21.20 nanoseconds |
| Single-float adjustable vector | 19.02 nanoseconds | 19.18 nanoseconds |
| Double-float adjustable vector | 30.04 nanoseconds | 30.81 nanoseconds |
+--------------------------------+-------------------+-------------------+
```

### ECL 20.4.24

```
CL-USER> (array-performance:run-benchmark 10)
.--------------------------------------------------------------------------.
|                            Generic functions                             |
+--------------------------------+--------------------+--------------------+
| Test                           | Time               | Elt/Aref Time      |
+--------------------------------+--------------------+--------------------+
| Single-float list              | 1.32 microseconds  | 481.96 nanoseconds |
| Double-float list              | 839.26 nanoseconds | 839.72 nanoseconds |
| Single-float simple vector     | 512.89 nanoseconds | 493.57 nanoseconds |
| Double-float simple vector     | 518.10 nanoseconds | 675.53 nanoseconds |
| Single-float adjustable vector | 489.82 nanoseconds | 34.50 microseconds |
| Double-float adjustable vector | 333.64 nanoseconds | 579.31 nanoseconds |
+--------------------------------+--------------------+--------------------+

.--------------------------------------------------------------------------.
|                          Specialized functions                           |
+--------------------------------+--------------------+--------------------+
| Test                           | Time               | Elt/Aref Time      |
+--------------------------------+--------------------+--------------------+
| Single-float list              | 633.78 nanoseconds | 456.12 nanoseconds |
| Double-float list              | 679.19 nanoseconds | 621.52 nanoseconds |
| Single-float simple vector     | 888.88 nanoseconds | 4.99 microseconds  |
| Double-float simple vector     | 541.58 nanoseconds | 950.34 nanoseconds |
| Single-float adjustable vector | 560.16 nanoseconds | 1.22 microseconds  |
| Double-float adjustable vector | 1.45 microseconds  | 607.32 nanoseconds |
+--------------------------------+--------------------+--------------------+

CL-USER> (array-performance:run-benchmark 100)
.--------------------------------------------------------------------------.
|                            Generic functions                             |
+--------------------------------+--------------------+--------------------+
| Test                           | Time               | Elt/Aref Time      |
+--------------------------------+--------------------+--------------------+
| Single-float list              | 500.74 nanoseconds | 858.29 nanoseconds |
| Double-float list              | 525.82 nanoseconds | 496.25 nanoseconds |
| Single-float simple vector     | 466.95 nanoseconds | 545.03 nanoseconds |
| Double-float simple vector     | 438.31 nanoseconds | 533.74 nanoseconds |
| Single-float adjustable vector | 348.43 nanoseconds | 372.53 nanoseconds |
| Double-float adjustable vector | 635.89 nanoseconds | 488.80 nanoseconds |
+--------------------------------+--------------------+--------------------+

.--------------------------------------------------------------------------.
|                          Specialized functions                           |
+--------------------------------+--------------------+--------------------+
| Test                           | Time               | Elt/Aref Time      |
+--------------------------------+--------------------+--------------------+
| Single-float list              | 393.02 nanoseconds | 769.26 nanoseconds |
| Double-float list              | 960.74 nanoseconds | 60.38 microseconds |
| Single-float simple vector     | 373.23 nanoseconds | 1.27 microseconds  |
| Double-float simple vector     | 698.77 nanoseconds | 552.28 nanoseconds |
| Single-float adjustable vector | 1.13 microseconds  | 494.56 nanoseconds |
| Double-float adjustable vector | 2.85 microseconds  | 922.60 nanoseconds |
+--------------------------------+--------------------+--------------------+

CL-USER> (array-performance:run-benchmark 1000)
.--------------------------------------------------------------------------.
|                            Generic functions                             |
+--------------------------------+--------------------+--------------------+
| Test                           | Time               | Elt/Aref Time      |
+--------------------------------+--------------------+--------------------+
| Single-float list              | 670.94 nanoseconds | 1.73 microseconds  |
| Double-float list              | 309.16 nanoseconds | 2.72 microseconds  |
| Single-float simple vector     | 431.84 nanoseconds | 374.52 nanoseconds |
| Double-float simple vector     | 409.87 nanoseconds | 511.94 nanoseconds |
| Single-float adjustable vector | 586.12 nanoseconds | 509.11 nanoseconds |
| Double-float adjustable vector | 1.09 microseconds  | 439.93 nanoseconds |
+--------------------------------+--------------------+--------------------+

.--------------------------------------------------------------------------.
|                          Specialized functions                           |
+--------------------------------+--------------------+--------------------+
| Test                           | Time               | Elt/Aref Time      |
+--------------------------------+--------------------+--------------------+
| Single-float list              | 11.74 microseconds | 9.43 microseconds  |
| Double-float list              | 602.17 nanoseconds | 1.34 microseconds  |
| Single-float simple vector     | 712.76 nanoseconds | 578.34 nanoseconds |
| Double-float simple vector     | 1.52 microseconds  | 664.11 nanoseconds |
| Single-float adjustable vector | 966.23 nanoseconds | 827.13 nanoseconds |
| Double-float adjustable vector | 344.31 nanoseconds | 722.10 nanoseconds |
+--------------------------------+--------------------+--------------------+
```

### AllegroCL Express Edition 10.1

```
CL-USER> (array-performance:run-benchmark 10)
.------------------------------------------------------------------------.
|                           Generic functions                            |
+--------------------------------+-------------------+-------------------+
| Test                           | Time              | Elt/Aref Time     |
+--------------------------------+-------------------+-------------------+
| Single-float list              | 48.06 nanoseconds | 63.26 nanoseconds |
| Double-float list              | 56.08 nanoseconds | 71.33 nanoseconds |
| Single-float simple vector     | 67.43 nanoseconds | 67.67 nanoseconds |
| Double-float simple vector     | 79.15 nanoseconds | 78.74 nanoseconds |
| Single-float adjustable vector | 72.48 nanoseconds | 71.88 nanoseconds |
| Double-float adjustable vector | 82.86 nanoseconds | 84.86 nanoseconds |
+--------------------------------+-------------------+-------------------+

.------------------------------------------------------------------------.
|                         Specialized functions                          |
+--------------------------------+-------------------+-------------------+
| Test                           | Time              | Elt/Aref Time     |
+--------------------------------+-------------------+-------------------+
| Single-float list              | 6.71 nanoseconds  | 22.45 nanoseconds |
| Double-float list              | 8.65 nanoseconds  | 25.64 nanoseconds |
| Single-float simple vector     | 40.94 nanoseconds | 34.44 nanoseconds |
| Double-float simple vector     | 42.50 nanoseconds | 42.38 nanoseconds |
| Single-float adjustable vector | 33.99 nanoseconds | 32.26 nanoseconds |
| Double-float adjustable vector | 39.20 nanoseconds | 39.77 nanoseconds |
+--------------------------------+-------------------+-------------------+
; No values
CL-USER> (array-performance:run-benchmark 100)
.-------------------------------------------------------------------------.
|                            Generic functions                            |
+--------------------------------+-------------------+--------------------+
| Test                           | Time              | Elt/Aref Time      |
+--------------------------------+-------------------+--------------------+
| Single-float list              | 45.76 nanoseconds | 209.01 nanoseconds |
| Double-float list              | 57.49 nanoseconds | 226.99 nanoseconds |
| Single-float simple vector     | 65.18 nanoseconds | 63.27 nanoseconds  |
| Double-float simple vector     | 77.67 nanoseconds | 76.61 nanoseconds  |
| Single-float adjustable vector | 70.15 nanoseconds | 69.03 nanoseconds  |
| Double-float adjustable vector | 83.74 nanoseconds | 82.00 nanoseconds  |
+--------------------------------+-------------------+--------------------+

.-------------------------------------------------------------------------.
|                          Specialized functions                          |
+--------------------------------+-------------------+--------------------+
| Test                           | Time              | Elt/Aref Time      |
+--------------------------------+-------------------+--------------------+
| Single-float list              | 2.51 nanoseconds  | 154.98 nanoseconds |
| Double-float list              | 2.72 nanoseconds  | 155.08 nanoseconds |
| Single-float simple vector     | 20.70 nanoseconds | 21.47 nanoseconds  |
| Double-float simple vector     | 29.94 nanoseconds | 29.58 nanoseconds  |
| Single-float adjustable vector | 24.26 nanoseconds | 24.95 nanoseconds  |
| Double-float adjustable vector | 31.60 nanoseconds | 32.08 nanoseconds  |
+--------------------------------+-------------------+--------------------+
; No values
CL-USER> (array-performance:run-benchmark 1000)
.------------------------------------------------------------------------.
|                           Generic functions                            |
+--------------------------------+-------------------+-------------------+
| Test                           | Time              | Elt/Aref Time     |
+--------------------------------+-------------------+-------------------+
| Single-float list              | 45.66 nanoseconds | 1.69 microseconds |
| Double-float list              | 53.84 nanoseconds | 1.68 microseconds |
| Single-float simple vector     | 64.26 nanoseconds | 62.21 nanoseconds |
| Double-float simple vector     | 76.93 nanoseconds | 76.89 nanoseconds |
| Single-float adjustable vector | 68.76 nanoseconds | 68.10 nanoseconds |
| Double-float adjustable vector | 80.48 nanoseconds | 80.26 nanoseconds |
+--------------------------------+-------------------+-------------------+

.------------------------------------------------------------------------.
|                         Specialized functions                          |
+--------------------------------+-------------------+-------------------+
| Test                           | Time              | Elt/Aref Time     |
+--------------------------------+-------------------+-------------------+
| Single-float list              | 1.92 nanoseconds  | 1.61 microseconds |
| Double-float list              | 2.01 nanoseconds  | 1.61 microseconds |
| Single-float simple vector     | 20.00 nanoseconds | 21.08 nanoseconds |
| Double-float simple vector     | 29.47 nanoseconds | 28.84 nanoseconds |
| Single-float adjustable vector | 23.60 nanoseconds | 25.73 nanoseconds |
| Double-float adjustable vector | 31.00 nanoseconds | 31.25 nanoseconds |
+--------------------------------+-------------------+-------------------+
```

## LispWorks Personal Edition 7.1.2

```
CL-USER 10 > (array-performance:run-benchmark 10)
.------------------------------------------------------------------------.
|                           Generic functions                            |
+--------------------------------+-------------------+-------------------+
| Test                           | Time              | Elt/Aref Time     |
+--------------------------------+-------------------+-------------------+
| Single-float list              | 18.63 nanoseconds | 25.11 nanoseconds |
| Double-float list              | 35.13 nanoseconds | 43.14 nanoseconds |
| Single-float simple vector     | 25.35 nanoseconds | 27.73 nanoseconds |
| Double-float simple vector     | 48.03 nanoseconds | 47.52 nanoseconds |
| Single-float adjustable vector | 29.46 nanoseconds | 31.51 nanoseconds |
| Double-float adjustable vector | 50.44 nanoseconds | 51.64 nanoseconds |
+--------------------------------+-------------------+-------------------+

.------------------------------------------------------------------------.
|                         Specialized functions                          |
+--------------------------------+-------------------+-------------------+
| Test                           | Time              | Elt/Aref Time     |
+--------------------------------+-------------------+-------------------+
| Single-float list              | 7.06 nanoseconds  | 14.02 nanoseconds |
| Double-float list              | 16.52 nanoseconds | 22.79 nanoseconds |
| Single-float simple vector     | 11.64 nanoseconds | 11.83 nanoseconds |
| Double-float simple vector     | 26.74 nanoseconds | 26.99 nanoseconds |
| Single-float adjustable vector | 16.22 nanoseconds | 16.28 nanoseconds |
| Double-float adjustable vector | 29.97 nanoseconds | 30.13 nanoseconds |
+--------------------------------+-------------------+-------------------+

CL-USER 11 > (array-performance:run-benchmark 100)
.------------------------------------------------------------------------.
|                           Generic functions                            |
+--------------------------------+-------------------+-------------------+
| Test                           | Time              | Elt/Aref Time     |
+--------------------------------+-------------------+-------------------+
| Single-float list              | 16.96 nanoseconds | 78.85 nanoseconds |
| Double-float list              | 32.44 nanoseconds | 93.77 nanoseconds |
| Single-float simple vector     | 23.57 nanoseconds | 24.83 nanoseconds |
| Double-float simple vector     | 43.66 nanoseconds | 44.53 nanoseconds |
| Single-float adjustable vector | 26.92 nanoseconds | 28.70 nanoseconds |
| Double-float adjustable vector | 47.41 nanoseconds | 48.53 nanoseconds |
+--------------------------------+-------------------+-------------------+

.------------------------------------------------------------------------.
|                         Specialized functions                          |
+--------------------------------+-------------------+-------------------+
| Test                           | Time              | Elt/Aref Time     |
+--------------------------------+-------------------+-------------------+
| Single-float list              | 5.10 nanoseconds  | 67.95 nanoseconds |
| Double-float list              | 13.61 nanoseconds | 77.76 nanoseconds |
| Single-float simple vector     | 10.30 nanoseconds | 10.52 nanoseconds |
| Double-float simple vector     | 24.20 nanoseconds | 24.46 nanoseconds |
| Single-float adjustable vector | 13.57 nanoseconds | 13.52 nanoseconds |
| Double-float adjustable vector | 27.12 nanoseconds | 27.05 nanoseconds |
+--------------------------------+-------------------+-------------------+

CL-USER 12 > (array-performance:run-benchmark 1000)
.-------------------------------------------------------------------------.
|                            Generic functions                            |
+--------------------------------+-------------------+--------------------+
| Test                           | Time              | Elt/Aref Time      |
+--------------------------------+-------------------+--------------------+
| Single-float list              | 16.84 nanoseconds | 663.52 nanoseconds |
| Double-float list              | 31.97 nanoseconds | 683.18 nanoseconds |
| Single-float simple vector     | 23.21 nanoseconds | 24.63 nanoseconds  |
| Double-float simple vector     | 43.35 nanoseconds | 44.28 nanoseconds  |
| Single-float adjustable vector | 26.60 nanoseconds | 28.12 nanoseconds  |
| Double-float adjustable vector | 46.80 nanoseconds | 47.94 nanoseconds  |
+--------------------------------+-------------------+--------------------+

.-------------------------------------------------------------------------.
|                          Specialized functions                          |
+--------------------------------+-------------------+--------------------+
| Test                           | Time              | Elt/Aref Time      |
+--------------------------------+-------------------+--------------------+
| Single-float list              | 4.98 nanoseconds  | 685.60 nanoseconds |
| Double-float list              | 13.29 nanoseconds | 667.45 nanoseconds |
| Single-float simple vector     | 10.35 nanoseconds | 10.05 nanoseconds  |
| Double-float simple vector     | 23.86 nanoseconds | 23.74 nanoseconds  |
| Single-float adjustable vector | 13.54 nanoseconds | 13.41 nanoseconds  |
| Double-float adjustable vector | 26.57 nanoseconds | 26.83 nanoseconds  |
+--------------------------------+-------------------+--------------------+
```

## Conclusion

* SBCL 2.0.0 performs the same like 1.5.5
* Access to `simple-vector` is 7-9 times faster than access to `adjustable-vector`.
