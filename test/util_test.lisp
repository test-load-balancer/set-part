(in-package :tlb.set-part)

(in-suite :tlb.set-part)

(def-suite test-suite :description "util tests")

(test should-know-sd-computation
  (is (equal (sqrt (/ 2 3)) (prt-util:sd '(1 2 3) 2))))