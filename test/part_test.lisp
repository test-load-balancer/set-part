(in-package :iisc.set-part)

(in-suite :iisc.set-part)

(def-suite test-suite :description "partition logic test")

(defun make-bag-of (&rest weights)
  (make-bag (map 'cons #'make-element weights)))

(test should-sort-bags-on-weight
  (is (equiv:object= (list (make-bag-of 1 2 3)
                           (make-bag-of 13 5 4)
                           (make-bag-of 10 12 15)
                           (make-bag-of 15 9 35))
                     (sort-bags (list (make-bag-of 10 12 15)
                                      (make-bag-of 13 5 4)
                                      (make-bag-of 15 9 35)
                                      (make-bag-of 1 2 3)) #'<)))
  (is (equiv:object= (list (make-bag-of 15 9 35)
                           (make-bag-of 10 12 15)
                           (make-bag-of 13 5 4)
                           (make-bag-of 1 2 3))
                     (sort-bags (list (make-bag-of 10 12 15)
                                      (make-bag-of 13 5 4)
                                      (make-bag-of 15 9 35)
                                      (make-bag-of 1 2 3)) #'>))))

(test should-split-the-bags-midway
  (is (equiv:object= (list (list (make-bag-of 1 2 3)
                                 (make-bag-of 13 5 4))
                           (list (make-bag-of 15 9 35)
                                 (make-bag-of 10 12 15)))
                      (split-midway (list (make-bag-of 10 12 15)
                                          (make-bag-of 13 5 4)
                                          (make-bag-of 15 9 35)
                                          (make-bag-of 1 2 3))))))


(test should-split-the-bags-midway-for-odd-number-of-bags
  (is (equiv:object= (list (list (make-bag-of 1 2 3)
                                 (make-bag-of 13 5 4))
                           (list (make-bag-of 15 9 35)
                                 nil))
                     (split-midway (list (make-bag-of 13 5 4)
                                         (make-bag-of 15 9 35)
                                         (make-bag-of 1 2 3))))))

(test should-pair
  (is (equiv:object= (list (cons (make-bag-of 1 2 3)
                                 (make-bag-of 15 9 35))
                           (cons (make-bag-of 13 5 4)
                                 (make-bag-of 10 12 15)))
                     (pair-bags (list (make-bag-of 10 12 15)
                                      (make-bag-of 13 5 4)
                                      (make-bag-of 15 9 35)
                                      (make-bag-of 1 2 3))))))

(test should-pair-odd-number-of-elements
  (is (equiv:object= (list (cons (make-bag-of 1 2 3)
                                 (make-bag-of 15 9 35))
                           (cons (make-bag-of 13 5 4)
                                 (make-bag-of 10 12 15))
                           (cons (make-bag-of 14 6 3)
                                 nil))
                     (pair-bags (list (make-bag-of 10 12 15)
                                      (make-bag-of 13 5 4)
                                      (make-bag-of 15 9 35)
                                      (make-bag-of 1 2 3)
                                      (make-bag-of 14 6 3))))))

(test should-cross-over
  (is (equiv:object= (cons (make-bag-of 1 20 25 4 5 7)
                           (make-bag-of 13 2 3 10 19))
                     (cross-over (cons (make-bag-of 1 2 3 4 5 7)
                                       (make-bag-of 13 20 25 10 19))
                                 :chromosome-selector (lambda (_ __) '((1 . 3) . (1 . 3)))
                                 :ideal-bag-weight 35))))

(test should-copy-the-parent-over-when-single
  (is (equiv:object= (cons (make-bag-of 1 20 25 4 5 7) nil)
                     (cross-over (cons (make-bag-of 1 20 25 4 5 7) nil)
                                 :chromosome-selector (lambda (_ __) '((1 . 3) . (1 . 3)))
                                 :ideal-bag-weight 35))))

(test should-not-cross-over-when-sd-increases
  (is (equiv:object= (cons (make-bag-of 1 10 12 4 5 7)
                           (make-bag-of 13 1 2 10 19))
                     (cross-over (cons (make-bag-of 1 10 12 4 5 7)
                                       (make-bag-of 13 1 2 10 19))
                                 :chromosome-selector (lambda (_ __) '((1 . 3) . (1 . 3)))
                                 :ideal-bag-weight 35))))

(test should-cross-over-entire-generation
  (is (equiv:object= (list (make-bag-of 1 20 25 4 5 7)
                           (make-bag-of 2 3 13 10 19)
                           (make-bag-of 16 7 25 10)
                           (make-bag-of 5 6 1 4 5 20)
                           (make-bag-of 1 20 15 2 3)
                           (make-bag-of 1 2 21 10 18)
                           (make-bag-of 3 1 3 3 6 5 10 16))
                     (next-generation (list (make-bag-of 1 2 3 4 5 7) ;; 22
                                            (make-bag-of 20 25 13 10 19) ;;87
                                            (make-bag-of 16 5 6 10) ;; 37
                                            (make-bag-of 7 25 1 4 5 20) ;; 62
                                            (make-bag-of 1 20 15 2 3) ;;41
                                            (make-bag-of 1 2 21 10 18) ;; 51
                                            (make-bag-of 3 1 3 3 6 5 10 16)) ;;47
                                      :chromosome-selector (lambda (_ __) '((1 . 3) . (0 . 2)))))))

(test should-compute-chromosome-selection-range-for-cross-over
  (let* ((bag-a (make-bag-of 1 2 3 4 5 6 7))
         (length-of-a (length (elements bag-a)))
         (bag-b (make-bag-of 10 20 30 40))
         (length-of-b (length (elements bag-b)))
         (range (random-chromosome-selector (cons bag-a bag-b) 18))
         (range-for-a (car range))
         (range-for-b (cdr range))
         (a-start (car range-for-a))
         (a-end (cdr range-for-a))
         (b-start (car range-for-b))
         (b-end (cdr range-for-b)))
    (is (<= 0 a-start))
    (is (< a-start length-of-a))
    (is (< a-start a-end))
    (is (<= a-end length-of-a))
    (is (<= 0 b-start))
    (is (< b-start length-of-b))
    (is (< b-start b-end))
    (is (<= b-end length-of-b))))