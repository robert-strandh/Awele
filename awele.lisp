(cl:in-package #:awele)

(defclass house ()
  ((%seed-count :initform 4 :accessor seed-count)))

(defclass game ()
  ((%player-1-captured :initform 0 :accessor player-1-captured)
   (%player-2-captured :initform 0 :accessor player-2-captured)
   (%houses :initform (let ((houses (loop repeat 12
					  collect (make-instance 'house))))
			;; Make the list circular.
			(setf (cdr (last houses)) houses))
	    :accessor houses)))

(defvar *game*)
