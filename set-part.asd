;; -*- lisp -*-

(defpackage :tlb.set-part.system
  (:use :common-lisp
        :asdf))

(in-package :tlb.set-part.system)

(defsystem :set-part
  :author '("Janmejay Singh <singh.janmejay@gmail.com>"
            "Pavan KS <itspanzi@gmail.com>")
  :properties ((:test-suite-name . :tlb.set-part.test))
  :components ((:static-file "set-part.asd")
               (:module :src
                        :components ((:file "package")
                                     (:file "classes" :depends-on ("package"))
                                     (:file "part" :depends-on ("classes" "util"))
                                     (:file "util" :depends-on ("package"))))
               (:module :test
                        :components ((:file "suite")
                                     (:file "part_test" :depends-on ("suite"))
                                     (:file "classes_test" :depends-on ("suite"))
                                     (:file "util_test" :depends-on ("suite")))
                        :depends-on (:src)))
  :depends-on (:fiveam :mw-equiv))

(defmethod asdf:perform ((op asdf:test-op) (system (eql (find-system :set-part))))
  (funcall (intern (string :run!) (string :tlb.set-part)) :tlb.set-part))

