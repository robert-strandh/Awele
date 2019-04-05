(cl:in-package #:awele)

;;; A house is where we keep the seeds during the game.  Initially, a
;;; house has 4 seeds.
(defclass house ()
  ((%seed-count :initform 4 :accessor seed-count)))

;;; This is an incomplete version of the game.  It needs to have a
;;; score house for each player as well.
(defclass game ()
  ((%player-1-captured :initform 0 :accessor player-1-captured)
   (%player-2-captured :initform 0 :accessor player-2-captured)
   (%houses :initform (let ((houses (loop repeat 12
                                          collect (make-instance 'house))))
                        ;; Make the list circular.
                        (setf (cdr (last houses)) houses)
                        houses)
            :accessor houses)))

(defun new-game ()
  (make-instance 'game))

;;; A move consists of locating the house with the number given,
;;; taking all the seeds out of that house and distributing them to
;;; the following houses, one seed per house.  Notice that this is not
;;; correct according to the rules of the game, because empty houses
;;; should be skipped and houses with exactly 2 or 3 seeds in them
;;; should be emptied and turned into a score for the player making
;;; the move.
(defun move (game house-number)
  (let* ((rest (nthcdr house-number (houses game)))
         (seed-count (seed-count (car rest))))
    (setf (seed-count (car rest)) 0)
    (loop for houses = (cdr rest) then (cdr houses)
          until (zerop seed-count)
          do (incf (seed-count (car houses)))
             (decf seed-count))))
