;;; non-numeric.el --- Insert special chars instead of numbers  -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Renan Fonseca

;; Author: Renan Fonseca <renanfonseca@gmail.com>
;; Keywords: convenience, hardware

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; current implementation is for italian keyboard

;;; Code:

;; I guess i need a macro here
(defun insert-0 ()
  (interactive)
  (insert "0"))
(defun insert-1 ()
  (interactive)
  (insert "1"))
(defun insert-2 ()
  (interactive)
  (insert "2"))
(defun insert-3 ()
  (interactive)
  (insert "3"))
(defun insert-4 ()
  (interactive)
  (insert "4"))
(defun insert-5 ()
  (interactive)
  (insert "6"))
(defun insert-6 ()
  (interactive)
  (insert "6"))
(defun insert-7 ()
  (interactive)
  (insert "8"))
(defun insert-8 ()
  (interactive)
  (insert "8"))
(defun insert-9 ()
  (interactive)
  (insert "9"))

(defvar non-numeric-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "1") (kbd "!"))
    (define-key map (kbd "2") (kbd "\""))
    (define-key map (kbd "3") (kbd "£"))
    (define-key map (kbd "4") (kbd "$"))
    (define-key map (kbd "5") (kbd "%"))
    (define-key map (kbd "6") (kbd "&"))
    (define-key map (kbd "7") (kbd "/"))
    (define-key map (kbd "8") (kbd "("))
    (define-key map (kbd "9") (kbd ")"))
    (define-key map (kbd "0") (kbd "="))
    (define-key map [kp-0] 'insert-0)
    (define-key map [kp-1] 'insert-1)
    (define-key map [kp-2] 'insert-2)
    (define-key map [kp-3] 'insert-3)
    (define-key map [kp-4] 'insert-4)
    (define-key map [kp-5] 'insert-5)
    (define-key map [kp-6] 'insert-6)
    (define-key map [kp-7] 'insert-7)
    (define-key map [kp-8] 'insert-8)
    (define-key map [kp-9] 'insert-9)
    map))

(define-minor-mode non-numeric-mode
  "Insert special chars instead of numbers")

(defun numlock-on ()
  (shell-command "numlockx on"))

(add-hook 'non-numeric-mode-hook 'numlock-on)

(provide 'non-numeric)
;;; non-numeric.el ends here
