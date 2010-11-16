(defun times (fn times)
  (let ((lst nil))
    (dotimes (i times)
         (setq lst (cons (funcall fn i) lst)))
    lst))

(defun bag-of-size (size-limit)
  (let ((elements (times (lambda (idx) (make-instance 'p::element :weight (random 100))) size-limit)))
    (p::make-bag elements)))

(defun make-sets (names)
  (dolist (set-name names)
    (let ((bag (bag-of-size 100))))
    (set set-name bag)
    (format t "~&Size of bag ~a is ~a" set-name (weight bag))))

(defun do-generations (generations &optional (verbose nil))
  (let* ((new-gen (p:improve-partitions (list a b c d e f) generations))
        (new-gen-weights (map 'cons #'p::weight new-gen)))
    (when verbose
      (print new-gen))
    (print new-gen-weights)))

(defun show-orig ()
  (print (map 'cons #'p::weight (list a b c d e f))))