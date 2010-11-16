;; -*- lisp -*-

(defpackage :iisc.set-part.system
  (:use :common-lisp
        :asdf))

(in-package :iisc.set-part.system)

(defsystem :set-part
  :author "Janmejay Singh <singh.janmejay@gmail.com>"
  :properties ((:test-suite-name . :iisc.set-part.test))
  :components ((:static-file "set-part.asd")
               (:module :src
                        :components ((:file "package")
                                     (:file "classes" :depends-on ("package"))
                                     (:file "part" :depends-on ("classes" "util"))
                                     (:file "util" :depends-on ("package"))))
               (:module :test
                        :components ((:file "suite")
                                     (:file "part" :depends-on ("suite"))
                                     (:file "classes" :depends-on ("suite"))
                                     (:file "util_test" :depends-on ("suite")))
                        :depends-on (:src)))
  :depends-on (:fiveam :mw-equiv))

(defmethod asdf:perform ((op asdf:test-op) (system (eql (find-system :set-part))))
  (funcall (intern (string :run!) (string :iisc.set-part)) :iisc.set-part))

