(in-package :iisc.set-part.util)

(defun sd (numbers ideal-value)
  (let ((sum-squares (reduce (lambda (sum number)
                               (+ sum (expt (- number ideal-value) 2))) numbers :initial-value 0)))
    (sqrt (/ sum-squares (length numbers)))))