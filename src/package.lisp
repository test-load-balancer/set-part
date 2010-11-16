(defpackage :tlb.set-part
  (:use :common-lisp :it.bese.FiveAM)
  (:nicknames :prt)
  (:export #:improve-partitions))

(defpackage :tlb.set-part.util
  (:use :common-lisp)
  (:nicknames :prt-util)
  (:export #:sd))

(defpackage :tlb.set-part.spiking
  (:use :common-lisp)
  (:nicknames :prt-spk)
  (:export #:ncalls #:bag-of-size))
