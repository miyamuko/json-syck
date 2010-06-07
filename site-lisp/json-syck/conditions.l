;;;; -*- mode: lisp; package: json-syck -*-
;;;;
;;;; File: json-syck/conditions.l
;;;;
;;;; License:
;;;;
;;;;   Copyright (c) 2008 MIYAMUKO Katsuyuki.
;;;;
;;;;   json-syck is released under an MIT license.
;;;;   See json-syck/docs/MIT-LICENSE for full license.
;;;;

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "json-syck/package")
  (require "json-syck/util")
  )

(in-package :json-syck)

(export '(json-simple-error
          json-parse-error
          ))

(define-condition json-simple-error (simple-error)
  ()
  (:report (lambda (c s)
             (format s (json-simple-error-format-string c)
                     (json-simple-error-format-arguments c)))))

(define-condition json-parse-error (json-simple-error)
  ()
  (:report (lambda (c s)
             (format s (json-parse-error-format-string c)
                     (json-parse-error-format-arguments c)))))

(defun raise-json-parse-error (format-string &rest format-arguments)
  (error 'json-parse-error
         :format-string (concat "json parse error: " format-string)
         :format-arguments format-arguments))


(provide "json-syck/conditions")

;;;; End
