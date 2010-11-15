(in-package :iisc.set-part)
(in-suite :iisc.set-part)

(def-suite test-suite :description "class definition tests")

(test should-capture-weight-attribute
  (is (= 14 (weight (make-element 14)))))

(test should-understand-equality
  (is (equiv:object= (make-element 23)
                     (make-instance 'element :weight 23))))

(test should-understand-set-weight
  (is (= 45 (weight (make-bag (list (make-element 20)
                                    (make-element 10)
                                    (make-element 15)))))))