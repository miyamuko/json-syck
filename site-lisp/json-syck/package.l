;;;; -*- mode: lisp; package: user -*-
;;;;
;;;; File: json-syck/package.l
;;;;
;;;; License:
;;;;
;;;;   Copyright (c) 2008 MIYAMUKO Katsuyuki.
;;;;
;;;;   json-syck is released under an MIT license.
;;;;   See json-syck/docs/MIT-LICENSE for full license.
;;;;

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "yaml-syck")
  (unless (find-package :json-syck)
    (defpackage :json-syck
      (:use
       :lisp
       :editor ;; for regexp
       ))))


(provide "json-syck/package")

;;;; End
