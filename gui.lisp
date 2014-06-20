(cl:in-package #:awele)

(defun awele ()
  (setf *game* (make-instance 'game))
  ;; Use a single-threaded taskmaster to avoid having to use locking. 
  (setf hunchentoot::*supports-threads-p* nil)
  (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor
		       :document-root "."
		       :port 4242)))

;;; The houses are stored in a circular list in the game.  We consider
;;; the houses as being numbered according to the order of appearance
;;; in this list.  This order is the one used when we make a move, so
;;; that grains are distributed by increasing index in this list.
;;; Therefore, we need to take this order into account when we display
;;; it.  In this version, we consider the house in the leftmost
;;; position on the bottom row to be house 0, and the number increase
;;; counter clockwise, so that to leftmost house on the top row is
;;; house number 11.  In some versions of the game, it is possible to
;;; choose whether to go clockwise or counter clockwise.  For that to
;;; be possible with the way we do it, a different display order has
;;; to be chosen. 
(defun show-game (game)
  (with-output-to-string (stream)
    (format stream "<html><head><title>Awele</title></head><body>")
    (format stream "<table>")
    (loop with house-numbers = '(11 10 9 8 7 6 0 1 2 3 4 5)
	  with houses = (houses game)
	  for row from 0 below 2
	  do (format stream "<tr>")
	     (loop for col from 0 below 6
		   for house-number = (pop house-numbers)
		   for house = (nth house-number houses)
		   do (format stream
			      "<td><a href=\"house?n=~a\">"
			      house-number)
		      (format stream
			      "<img src=\"Images/house-~a.png\"></a></td>"
			      (seed-count house)))
	     (format stream "</tr>"))
    (format stream "</table></body></hmtl>")))

(hunchentoot:define-easy-handler (house-click-handler :uri "/house") (n)
  (declare (ignore n))
  (show-game *game*))
