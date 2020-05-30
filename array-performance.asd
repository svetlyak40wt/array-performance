(defsystem "array-performance"
  :class :package-inferred-system
  :depends-on ("array-performance/core"))

(register-system-packages "cl-ascii-table" '(#:ascii-table))
