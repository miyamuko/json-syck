;;;; -*- mode: lisp; package: json-syck -*-
;;;;
;;;; File: json-syck/version.l
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
  )

(in-package :json-syck)

(export '(json-syck-version
          ))

(defconstant +json-syck-version+ "0.1.1")

(defun json-syck-version ()
  +json-syck-version+)


(provide "json-syck/version")

;;;; End
