;;;; -*- mode: lisp; package: json-syck -*-
;;;;
;;;; File: json-syck/loader.l
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
  (require "json-syck/preprocessor")
  (require "json-syck/datatype")
  (require "json-syck/conditions")
  )

(in-package :json-syck)

(export '(json-load
          ))

(defun json-load (json-text &rest options)
  (let ((yaml-syck::*syck-datatype-handler-alist* *json-datatype-handler-alist*))
    (handler-case
        (multiple-value-bind (yaml-str-or-filename file?)
            (json-preprocess json-text)
          (unwind-protect
              (apply (if file? 'yaml-syck:syck-load-file 'yaml-syck:syck-load)
                     yaml-str-or-filename options)
            (json-postprocess yaml-str-or-filename file?)))
      (yaml-syck:syck-simple-error (c)
        (raise-json-parse-error (yaml-syck:syck-simple-error-errmsg c))))))


(provide "json-syck/loader")


;;;; End
