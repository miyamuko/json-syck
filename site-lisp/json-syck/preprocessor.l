;;;; -*- mode: lisp; package: json-syck -*-
;;;;
;;;; File: json-syck/preprocessor.l
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

;; 8K バイト以上はファイルに保存して parse
(defvar *json-max-string-size* (* 8 1024))

(defun json-preprocess (json-text)
  (let ((now (selected-buffer))
        (buf (get-buffer-create "*json-syck:tmp*")))
    (unwind-protect
        (with-set-buffer
          (set-buffer buf)
          (insert json-text)
          (json-remove-extra-paren-buffer)
          (json-insert-space-after-object-separater)
          (if (< *json-max-string-size* (point-max))
              (let ((tmp (make-temp-file-name "json-syck")))
                (write-file tmp t)
                (values tmp t))
            (values (buffer-substring (point-min) (point-max)) nil)))
      (with-set-buffer
        (delete-buffer buf)
        (set-buffer now)))))

(defun json-postprocess (yaml-str-or-filename file?)
  (when file?
    (delete-file yaml-str-or-filename
                 :if-does-not-exist :skip
                 :if-access-denied :skip)))


;; json が () で囲まれていたら削除する
(defun json-remove-extra-paren-buffer ()
  (goto-char (point-max))
  (when (eq #\) (char-before (point)))
    (delete-backward-char))
  (goto-char (point-min))
  (when (eq #\( (char-after (point)))
    (delete-char)))

;; 文字列以外の : , のあとにスペースを挿入
(defun json-insert-space-after-object-separater ()
  (c-mode)
  (while (scan-buffer "[:,]" :regexp t :tail t)
    (unless (eq (parse-point-syntax) :string)
      (insert " "))))


(provide "json-syck/preprocessor")

;;;; End
