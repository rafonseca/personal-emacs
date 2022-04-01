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

(defun my/project-search ()
  (interactive)
  (if (use-region-p)
      (let ((start (region-beginning))
            (end (region-end)))

           (+vertico/project-search nil (buffer-substring start end)))
      (+vertico/project-search)))

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
 "C-x C-z" 'repeat-complex-command
 "C-c v b" 'magit-blob-mode
 "C-x v" 'view-file
 "M-s M-s" 'my/project-search
 "C-t" nil
 "C-t t" 'outline-minor-mode
 "C-t s" 'consult-outline
 "C-t a" 'outline-show-all)

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
 ;; "C-y" 'funky-yank)

(defun outline-down-heading ()
  (interactive)
  ;; TODO do not forward out of level
  (outline-next-heading))


(general-define-key
 :keymaps 'outline-minor-mode-map
 "M-<left>" 'outline-hide-subtree
 "M-<right>" 'outline-show-children
 "C-M-<left>" 'outline-hide-other
 "C-M-<right>" 'outline-show-subtree
 "C-M-<up>" 'outline-hide-sublevels
 "C-M-<down>" 'outline-show-all
 "C-<left>" 'outline-up-heading
 "C-<right>" 'outline-down-heading
 "C-<up>" 'outline-backward-same-level
 "C-<down>" 'outline-forward-same-level)

;; tramp section
(setq remote-file-name-inhibit-cache nil)
(setq vc-ignore-dir-regexp
      (format "%s\\|%s"
                    vc-ignore-dir-regexp
                    tramp-file-name-regexp))
(setq tramp-verbose 1)

(provide 'random-tweaks)

;; org section
(defun org-set-date-property ()
  (interactive)
  (org-set-property "date" (org-time-stamp nil)))
