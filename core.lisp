(defpackage #:array-performance
  (:use #:cl)
  (:nicknames #:array-performance/core)
  (:import-from #:the-cost-of-nothing
                #:print-time
                #:benchmark)
  (:import-from #:ascii-table)
  (:export #:run-benchmark))
(in-package array-performance)


(defun calc-on-generic-list (list)
  (declare (optimize (speed 3) (debug 1)))
  (loop for item in list
        summing (* item item) into summ
        finally (return (sqrt summ))))

(defun calc-on-generic-vector (vector)
  (declare (optimize (speed 3) (debug 1)))
  (loop for item across vector
        summing (* item item) into summ
        finally (return (sqrt summ))))

;; Specialized list functions

(defun calc-on-single-float-list (list)
  (declare (optimize (speed 3) (debug 1)))
  (loop for item single-float in list
        summing (* item item) into summ single-float
        finally (return (sqrt summ))))

(defun calc-on-double-float-list (list)
  (declare (optimize (speed 3) (debug 1)))
  (loop for item double-float in list
        summing (* item item) into summ double-float
        finally (return (sqrt summ))))

;; Specialized vector functions

(declaim (ftype (function ((simple-array single-float)) single-float)
                calc-on-single-float-vector))
(defun calc-on-single-float-vector (vector)
  (declare (optimize (speed 3) (debug 1)))
  (loop for item single-float across vector
        summing (* item item) into summ single-float
        finally (return (sqrt summ))))

(declaim (ftype (function ((simple-array double-float)) double-float)
                calc-on-double-float-vector))
(defun calc-on-double-float-vector (vector)
  (declare (optimize (speed 3) (debug 1)))
  (loop for item double-float across vector
        summing (* item item) into summ double-float
        finally (return (sqrt summ))))

;; Adjustable

(declaim (ftype (function ((array single-float)) single-float)
                calc-on-single-adjustable-float-vector))
(defun calc-on-single-float-adjustable-vector (vector)
  (declare (optimize (speed 3) (debug 1)))
  (loop for item single-float across vector
        summing (* item item) into summ single-float
        finally (return (sqrt summ))))

(declaim (ftype (function ((array double-float)) double-float)
                calc-on-double-float-adjustable-vector))
(defun calc-on-double-float-adjustable-vector (vector)
  (declare (optimize (speed 3) (debug 1)))
  (loop for item double-float across vector
        summing (* item item) into summ double-float
        finally (return (sqrt summ))))

;; Elt versions of list functions

(declaim (ftype (function (list) t)
                calc-on-generic-list-elt))
(defun calc-on-generic-list-elt (list)
  (declare (optimize (speed 3) (debug 1)))
  (loop for idx fixnum below (length list)
        for item = (elt list idx)
        summing (* item item) into summ
        finally (return (sqrt summ))))

(declaim (ftype (function (list) single-float)
                calc-on-single-float-list-elt))
(defun calc-on-single-float-list-elt (list)
  (declare (optimize (speed 3) (debug 1)))
  (loop for idx fixnum below (length list)
        for item single-float = (elt list idx)
        summing (* item item) into summ single-float
        finally (return (sqrt summ))))

(declaim (ftype (function (list) double-float)
                calc-on-double-float-list-elt))
(defun calc-on-double-float-list-elt (list)
  (declare (optimize (speed 3) (debug 1)))
  (loop for idx fixnum below (length list)
        for item double-float = (elt list idx)
        summing (* item item) into summ double-float
        finally (return (sqrt summ))))


;; Aref versions of vector functions

(defun calc-on-generic-vector-aref (vector)
  (declare (optimize (speed 3) (debug 1)))
  (loop for idx fixnum below (length vector)
        for item = (aref vector idx)
        summing (* item item) into summ
        finally (return (sqrt summ))))

(declaim (ftype (function ((simple-array single-float)) single-float)
                calc-on-single-float-vector-aref))
(defun calc-on-single-float-vector-aref (vector)
  (declare (optimize (speed 3) (debug 1)))
  (loop for idx fixnum below (length vector)
        for item single-float = (aref vector idx)
        summing (* item item) into summ single-float
        finally (return (sqrt summ))))

(declaim (ftype (function ((simple-array double-float)) double-float)
                calc-on-double-float-vector-aref))
(defun calc-on-double-float-vector-aref (vector)
  (declare (optimize (speed 3) (debug 1)))
  (loop for idx fixnum below (length vector)
        for item double-float = (aref vector idx)
        summing (* item item) into summ double-float
        finally (return (sqrt summ))))

;; Adjustable

(declaim (ftype (function ((array single-float)) single-float)
                calc-on-single-adjustable-float-vector-aref))
(defun calc-on-single-float-adjustable-vector-aref (vector)
  (declare (optimize (speed 3) (debug 1)))
  (loop for idx fixnum below (length vector)
        for item single-float = (aref vector idx)
        summing (* item item) into summ single-float
        finally (return (sqrt summ))))

(declaim (ftype (function ((array double-float)) double-float)
                calc-on-double-float-adjustable-vector-aref))
(defun calc-on-double-float-adjustable-vector-aref (vector)
  (declare (optimize (speed 3) (debug 1)))
  (loop for idx fixnum below (length vector)
        for item double-float = (aref vector idx)
        summing (* item item) into summ double-float
        finally (return (sqrt summ))))


;; The test itself

(defun run-benchmark (&optional (size 10))
  (let* ((single-float-list (loop repeat size
                                  collect (random 1.0)))
         (double-float-list (loop repeat size
                                  collect (random 1.0d0)))
         (single-float-simple-vector
           (make-array size
                       :element-type 'single-float
                       :initial-contents single-float-list
                       :adjustable nil))
         (single-float-adjustable-vector
           (make-array size
                       :element-type 'single-float
                       :initial-contents single-float-list
                       :adjustable t))
         (double-float-simple-vector
           (make-array size
                       :element-type 'double-float
                       :initial-contents double-float-list
                       :adjustable nil))
         (double-float-adjustable-vector
           (make-array size
                       :element-type 'double-float
                       :initial-contents double-float-list
                       :adjustable t))
         (generic-results (ascii-table:make-table '("Test" "Time" "Elt/Aref Time")
                                                  :header "Generic functions"))
         (specialized-results (ascii-table:make-table '("Test" "Time" "Elt/Aref Time")
                                                      :header "Specialized functions"))
         (current-table generic-results))
    (macrolet ((bench (title body &optional aref-body)
                 `(ascii-table:add-row
                   current-table
                   (list ,title
                         (with-output-to-string (s)
                           (print-time (/ (benchmark ,body)
                                          size)
                                       s))
                         ,(when aref-body
                            `(with-output-to-string (s)
                               (print-time (/ (benchmark ,aref-body)
                                              size)
                                           s)))))))
      
      (bench "Single-float list"
             (calc-on-generic-list single-float-list)
             (calc-on-generic-list-elt single-float-list))

      (bench "Double-float list"
             (calc-on-generic-list double-float-list)
             (calc-on-generic-list-elt double-float-list))

      (bench "Single-float simple vector"
             (calc-on-generic-vector single-float-simple-vector)
             (calc-on-generic-vector-aref single-float-simple-vector))

      (bench "Double-float simple vector"
             (calc-on-generic-vector double-float-simple-vector)
             (calc-on-generic-vector-aref double-float-simple-vector))

      (bench "Single-float adjustable vector"
             (calc-on-generic-vector single-float-adjustable-vector)
             (calc-on-generic-vector-aref single-float-adjustable-vector))

      (bench "Double-float adjustable vector"
             (calc-on-generic-vector double-float-adjustable-vector)
             (calc-on-generic-vector-aref double-float-adjustable-vector))

      
      (setf current-table specialized-results)
      
      (bench "Single-float list"
             (calc-on-single-float-list single-float-list)
             (calc-on-single-float-list-elt single-float-list))

      (bench "Double-float list"
             (calc-on-double-float-list double-float-list)
             (calc-on-double-float-list-elt double-float-list))

      (bench "Single-float simple vector"
             (calc-on-single-float-vector single-float-simple-vector)
             (calc-on-single-float-vector-aref single-float-simple-vector))

      (bench "Double-float simple vector"
             (calc-on-double-float-vector double-float-simple-vector)
             (calc-on-double-float-vector-aref double-float-simple-vector))

      (bench "Single-float adjustable vector"
             (calc-on-single-float-adjustable-vector single-float-adjustable-vector)
             (calc-on-single-float-adjustable-vector-aref single-float-adjustable-vector))

      (bench "Double-float adjustable vector"
             (calc-on-double-float-adjustable-vector double-float-adjustable-vector)
             (calc-on-double-float-adjustable-vector-aref double-float-adjustable-vector))

      (ascii-table:display generic-results)
      (terpri)
      (ascii-table:display specialized-results)
      (values))))
