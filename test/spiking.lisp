(in-package :tlb.set-part.spiking)

(defun ncalls (fn times)
  (let ((lst nil))
    (dotimes (i times)
         (setq lst (cons (funcall fn i) lst)))
    lst))

(defun bag-of-size (size-limit max-weight)
  (let ((elements (ncalls (lambda (idx) (make-instance 'prt::element :weight (random max-weight))) size-limit)))
    (prt::make-bag elements)))

(defun make-n-sets (n of-size max-weight)
  (let ((sets nil))
    (dotimes (i n sets)
      (setq sets (cons (bag-of-size of-size max-weight) sets)))))

(defun do-generations (generations &optional (verbose nil) (number-of-bags 10) (bags-of-size 1000) (max-weight 100))
  (let* ((bags (make-n-sets number-of-bags bags-of-size max-weight))
         (initial-weights (map 'cons #'prt::weight bags))
         (new-gen (prt:improve-partitions bags generations))
         (new-gen-weights (map 'cons #'prt::weight new-gen))
         (sum-of-all-bags (reduce #'+ initial-weights))
         (ideal-bag-size (/ sum-of-all-bags (length bags))))
    (when verbose
      (format t "~&old gen: ~a ~%new gen: ~a" bags new-gen))
    (format t "~&before: ~a(SD: ~a) ~%after: ~a(SD: ~a)" initial-weights (prt-util:sd initial-weights ideal-bag-size) new-gen-weights (prt-util:sd new-gen-weights ideal-bag-size))))