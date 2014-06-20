(cl:in-package #:awele)

(defun awele ()
  (setf *game* (make-instance 'game))
  ;; Use a single-threaded taskmaster to avoid having to use locking. 
  (setf hunchentoot::*supports-threads-p* nil)
  (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor
		       :document-root "."
		       :port 4242)))

(defun show-game (game)
  (with-output-to-string (stream)
    (format stream "<html><head><title>Awele</title></head><body>")
    (format stream "<table>")
    (loop for row from 0 below 2
	  do (format stream "<tr>")
	     (loop for col from 0 below 6
		   for houses = (houses game) then (cdr houses)
		   for house = (car houses)
		   do (format stream
			      "<td><a href=\"house?n=~a\">"
			      (+ (* 12 row) col))
		      (format stream
			      "<img src=\"Images/house-~a.png\"></a></td>"
			      (seed-count house)))
	     (format stream "</tr>"))
    (format stream "</table></body></hmtl>")))
