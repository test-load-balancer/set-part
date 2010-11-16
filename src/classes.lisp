(in-package :iisc.set-part)

(defmethod equiv:object-frozenp ((obj cons)) t)

(defclass element ()
  ((weight :reader weight :initarg :weight :type :integer)))

(defmethod make-element ((weight integer))
  (make-instance 'element :weight weight))

(defmethod equiv:object-frozenp ((obj element)) t)
(defmethod equiv:object-constituents ((type (eql 'element)))
  (list #'weight))

(defclass bag ()
  ((elements :reader elements :initarg :elements :type :list)
   (weight :reader weight :initarg :weight :type :integer)))

(defmethod make-bag ((elements cons))
  (let ((weight (reduce (lambda (val elem) (+ val (weight elem))) elements :initial-value 0)))
    (make-instance 'bag :elements elements :weight weight)))

(defmethod equiv:object-frozenp ((obj bag)) t)
(defmethod equiv:object-constituents ((type (eql 'bag)))
  (list #'elements
        #'weight))

(defmethod print-object ((bag bag) stream)
  (format stream "#<bag elements: ~a weight: ~a>" (elements bag) (weight bag)))

(defmethod print-object ((element element) stream)
  (format stream "#<element weight: ~a>" (weight element)))