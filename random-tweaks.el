;;; random-tweaks.el -*- lexical-binding: t; -*-

(with-current-buffer "*scratch*" (emacs-lisp-mode))


(defun language-manager ()
  (interactive)
  (eval( cdr (assoc 'selected-manager dir-local-variables-alist))))

(defun kill-window-and-buffer ()
  (interactive)
  (kill-buffer)
  (delete-window))


(defun mark-or-copy ()
  (interactive)
  (if (use-region-p)
      (kill-ring-save nil nil t)
      (mark-sexp)))


;;; keybindings
(require 'general)

(general-define-key
 "C-x k" "C-x K"
 "C-x f" 'find-file
 "M-s s" 'consult-line-multi
 "C-s" 'consult-line
 "<f6>" 'language-manager
 "<f7>" 'magit
 "C-," 'xref-push-marker-stack
 "s-o" 'spread-into-frames
 "s-p" 'i3-terminal
 "M-/" 'undo-fu-only-redo
 "C-q" 'kill-window-and-buffer
 "M-w" 'mark-or-copy
 "C-r" 'consult-recent-file
 "C-x C-z" 'repeat-complex-command)

(general-define-key
 :keymaps 'clojure-mode-map
 "M-d" 'sp-kill-sexp
 "M-DEL" 'backward-kill-sexp)

(general-define-key
 :keymaps 'dired-mode-map
 "v" 'dired-view-file-on-frame
 "q" 'quit-and-close-frame)


(general-define-key
 "C-x d" 'projectile-dired
 "C-x C-d" 'dired-jump-other-frame)

(general-define-key
 :keymaps 'python-mode-map
 "<f8>" 'python-pytest-dispatch
 "/" 'insert-file-name-on-key-seq)
 ;; "C-y" 'funky-yank)                     ;



(provide 'random-tweaks)
