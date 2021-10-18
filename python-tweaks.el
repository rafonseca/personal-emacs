;;; python-tweaks.el -*- lexical-binding: t; -*-

(setq blacken-only-if-project-is-blackened t)
(add-hook 'python-mode-hook 'blacken-mode)

(defun force-file-name-completion ()
  (add-hook 'completion-at-point-functions 'complete-file-name 0 'local))
(add-hook 'python-mode-hook 'force-file-name-completion)



(defun insert-file-name-on-key-seq ()
    "This function prompt for a file and insert its name when the
    sequence \"\.\/ is inserted. It should be binded to key /"
    (interactive)
    (insert "/")
    (if (looking-back "\"\.\/" 3)
        (insert(file-relative-name(read-file-name "Insert filename")))))

(defun funky-yank (beg end)
  "When yanking text on selected region, kill region and yank"
  (interactive "r")
  (if (use-region-p)
      (let ((selected-substring (buffer-substring-no-properties beg end)))
        (kill-region beg end)
        (yank 2)
        (current-kill 1))
      (yank)))



(provide 'python-tweaks)
