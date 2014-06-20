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

(defun new-game ()
  (make-instance 'game))

(defun move (game house-number)
  (let* ((rest (nthcdr house-number (houses game)))
	 (seed-count (seed-count (car rest))))
    (setf (seed-count (car rest)) 0)
    (loop for houses = (cdr rest) then (cdr houses)
	  until (zerop seed-count)
	  do (incf (seed-count (car houses)))
	     (decf seed-count))))

(defvar *game*)


