(in-package :iisc.set-part)

(in-suite :iisc.set-part)

(def-suite test-suite :description "set partitioning tests")

(test foo
  (is (= 12 (foo 2))))

(test bar
  (is (= 3 (foo 1))))
