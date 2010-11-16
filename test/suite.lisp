(in-package :tlb.set-part)

 (eval-when (:compile-toplevel :load-toplevel :execute)
   (unless (fiveam:get-test :set-part)
     (fiveam:def-suite :set-part)))

(fiveam:def-suite :tlb.set-part :in :set-part)