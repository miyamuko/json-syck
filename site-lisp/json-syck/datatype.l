;;;; -*- mode: lisp; package: json-syck -*-
;;;;
;;;; File: json-syck/datatype.l
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

(defconstant *json-ctrl-char-alist*
  '(("\\\"" . "\"")
    ("\\/" . "/")
    ("\\\\" . "\\")
    ("\\b" . "\b")
    ("\\f" . "\f")
    ("\\n" . "\n")
    ("\\r" . "\r")
    ("\\t" . "\t")))

(defparameter *json-datatype-handler-alist*
  (mapcar #'(lambda (pair)
              (cons (car pair) 'json-convert))
          yaml-syck::*syck-datatype-handler-alist*))

(defparameter *json-number-regexp*
  "^-?\\(0\\|[1-9][0-9]*\\)\\(\\.[0-9]+\\)?\\([eE][+-]?[0-9]+\\)?$")


(defun json-convert (value option)
  (cond ((equal "null" value) (json-parse-null value option))
        ((equal "true" value) (json-parse-true value option))
        ((equal "false" value) (json-parse-false value option))
        ((string-match *json-number-regexp* value) (json-parse-number value option))
        (t (json-parse-string value option))))

(defun json-parse-null (value option)
  (yaml-syck:syck-parser-option-null option))

(defun json-parse-true (value option)
  (yaml-syck:syck-parser-option-true option))

(defun json-parse-false (value option)
  (yaml-syck:syck-parser-option-false option))

(defun json-parse-number (value option)
  (flet ((raise! ()
           (raise-json-parse-error "invalid number: ~S" value)))
    (handler-case
        (let ((n (read (make-string-input-stream value))))
          (unless (numberp n)
            (raise!))
          n)
      (reader-error (c)
        (raise!)))))

(defun json-parse-string (value option)
  (reduce #'(lambda (v fn) (funcall fn v))
          '(json-gsub-unicode-char
            json-gsub-ctrl-char)
          :initial-value value))

(defun json-gsub-unicode-char (value)
  (gsub (value "\\\\u\\([0-9a-fA-F]\\{4\\}\\)")
    (unicode-char (parse-integer (match-string 1) :radix 16))))

(defun json-gsub-ctrl-char (value)
  (gsub (value "\\\\[\"/\\\\fnrtb]")
    (cdr (assoc value *json-ctrl-char-alist* :test #'string=))))


(provide "json-syck/datatype")

;;;; End
