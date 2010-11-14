(in-package :iisc.set-part)

 (eval-when (:compile-toplevel :load-toplevel :execute)
   (unless (fiveam:get-test :set-part)
     (fiveam:def-suite :set-part)))

(fiveam:def-suite :iisc.set-part :in :set-part)