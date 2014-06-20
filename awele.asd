(cl:in-package #:common-lisp-user)

(asdf:defsystem :awele
  :depends-on (:hunchentoot)
  :serial t
  :components
  ((:file "packages")
   (:file "awele")))

