(in-package :iisc.set-part)

(defun sort-bags (bags comparison)
  (sort bags (lambda (me her) (funcall comparison (weight me) (weight her)))))

(defun split-midway (bags)
  (let* ((sorted-bags (sort-bags bags #'<))
         (mid-point (ceiling ( / (length sorted-bags) 2)))
         (lowers (subseq sorted-bags 0 mid-point))
         (highers (subseq sorted-bags mid-point))
         (reversed-higher (sort-bags highers #'>)))
    (list lowers (if (oddp (length sorted-bags))
                     (append reversed-higher (list nil))
                     reversed-higher))))


(defun pair-bags (bags)
  (let* ((bag-groups (split-midway bags))
         (lowers (first bag-groups))
         (highers (second bag-groups)))
    (map 'cons #'cons lowers highers)))

(defun cross-over (parents &key chromosome-selector ideal-bag-weight)
  (let ((parent-a (car parents))
        (parent-b (cdr parents)))
    (if parent-b
        (let* ((chromosome-a (elements parent-a))
               (chromosome-b (elements parent-b))
               (crossover-range (funcall chromosome-selector parents ideal-bag-weight))
               (crossover-range-a (car crossover-range))
               (crossover-range-b (cdr crossover-range))
               (start-offset-a (car crossover-range-a))
               (end-offset-a (cdr crossover-range-a))
               (start-offset-b (car crossover-range-b))
               (end-offset-b (cdr crossover-range-b))
               (before-crossover-a (subseq chromosome-a 0 start-offset-a))
               (crossover-frag-a (subseq chromosome-a start-offset-a end-offset-a))
               (after-crossover-a (subseq chromosome-a end-offset-a))
               (before-crossover-b (subseq chromosome-b 0 start-offset-b))
               (crossover-frag-b (subseq chromosome-b start-offset-b end-offset-b))
               (after-crossover-b (subseq chromosome-b end-offset-b))
               (child-chromosome-a (append before-crossover-a crossover-frag-b after-crossover-a))
               (child-chromosome-b (append before-crossover-b crossover-frag-a after-crossover-b))
               (child-a (make-bag child-chromosome-a))
               (child-b (make-bag child-chromosome-b))
               (parent-sd (util:sd (list (weight parent-a) (weight parent-b)) ideal-bag-weight))
               (child-sd (util:sd (list (weight child-a) (weight child-b)) ideal-bag-weight)))
          (if (> parent-sd child-sd) (cons child-a child-b) parents))
        parents)))

(defun next-generation (current-generation &key chromosome-selector)
  (let* ((paired-bags (pair-bags current-generation))
         (ideal-weight (/ (reduce (lambda (sum bag) (+ sum (weight bag)))
                                  current-generation
                                  :initial-value 0) (length current-generation)))
         (offsprings (map 'cons
                          (lambda (parents)
                            (cross-over parents
                                        :chromosome-selector chromosome-selector
                                        :ideal-bag-weight ideal-weight))
                          paired-bags)))
    (reduce (lambda (list child-pair)
              (let* ((child-a (car child-pair))
                     (child-b (cdr child-pair))
                     (children (if child-b (list child-a child-b) (list child-a))))
                (append list children)))
            offsprings
            :initial-value nil)))

(defun random-chromosome-selector (parents ideal-weight)
  (let* ((parent-a (car parents))
         (parent-b (cdr parents))
         (length-of-a (length (elements parent-a)))
         (length-of-b (length (elements parent-b)))
         (offset-a (random length-of-a))
         (limit-a (+ 1 (random (- length-of-a offset-a))))
         (offset-b (random length-of-b))
         (limit-b (+ 1 (random (- length-of-b offset-b)))))
    (cons (cons offset-a (+ offset-a limit-a)) (cons offset-b (+ offset-b limit-b)))))