(in-package :iisc.set-part)

(in-suite :iisc.set-part)

(def-suite test-suite :description "util tests")

(test should-know-sd-computation
  (is (equal (sqrt (/ 2 3)) (util:sd '(1 2 3) 2))))