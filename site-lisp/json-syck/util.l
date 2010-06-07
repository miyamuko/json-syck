;;;; -*- mode: lisp; package: json-syck -*-
;;;;
;;;; File: json-syck/util.l
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

(defmacro D((args) &body body)
  #-json-syck-debug
  `(progn ,@body)
  #+json-syck-debug
  `(D0 (,args) ,@body))

(defmacro D0((args) &body body)
  (let ((gstart (gensym))
        (gend (gensym))
        (gresult (gensym)))
    `(let ((,gstart (si:performance-counter))
           (,gend 0)
           (,gresult))
       (setf ,gresult (multiple-value-list (progn ,@body)))
       (setf ,gend (si:performance-counter))
       (msgbox "[~1F] ~S => ~S: line=~D, col=~D, point=~D"
               (/ (- ,gend ,gstart) si:*performance-counter-frequency*)
               ,args ,gresult
               (current-line-number) (current-column) (point))
       (values-list ,gresult))))


(defmacro gsub ((str re) &body body)
  `(call-gsub ,str ,re #'(lambda () ,@body)))
(setf (get 'gsub 'ed:lisp-indent-hook) 1)

(defun call-gsub (str re fn)
  (when (and re str)
    (let ((result)
          (start 0))
      (while (string-match re str start)
        (let ((b (match-beginning 0))
              (e (match-end 0)))
          (push (substring str start b) result)
          (push (funcall fn) result)
          (setf start e)))
      (push (substring str start) result)
      (format nil "~{~A~}" (reverse result)))))


(provide "json-syck/util")

;;;; End
