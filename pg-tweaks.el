;;; pg-tweaks.el -*- lexical-binding: t; -*-

(add-to-list 'load-path "~/repos/emacs-libpq/")
(require 'pq)

(defun get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))
;; thanks to “Pascal J Bourguignon” and “TheFlyingDutchman [zzbba…@aol.com]”. 2010-09-02


(defvar-local conn nil
  "When a connection is established, it contains the connection
  object used by pq library")

(defun set-postgres-uri ()
  (sql-get-login  'server 'port 'user 'password 'database))

(defun get-postgres-uri ()
  (format "postgres://%s:%s@%s:%s/%s" sql-user sql-password sql-server sql-port sql-database))

(defun pq:set-connection (&optional URI)
  "Uses function and variables from sql-mode to obtain login
params, and then setup pq connection using buffer local variable
conn.
   Additionally, if URI is non nil, uses URI."
  (if-let (target-db URI)
      (setq conn (pq:connectdb target-db))
      (setq conn (pq:connectdb (get-postgres-uri)))))

(defun pq:get_tables ()
  (pq:query conn "select table_name from information_schema.tables where table_schema='public';"))

(defun pq:get_columns  (TABLE)
  (pq:query conn (format "select column_name from information_schema.columns where table_name='%s';" TABLE)))

(defun pq:execute_script (SCRIPT)
  (let ((content
         (pcase SCRIPT
           ((pred bufferp) (read-buffer SCRIPT))
           ((and (pred stringp) (pred get-buffer))  (with-current-buffer SCRIPT (buffer-string)))
           ((and (pred stringp) (pred file-exists-p)) (get-string-from-file SCRIPT)))))
    (pq:query conn content)))




(define-minor-mode dynamic-postgres-mode
  "Dynamic completion for postgres"
  :init-value nil
  :lighter " dyn-pg"
  :keymap
    (let ((map (make-sparse-keymap)))
    ;; (define-key map (kbd "9") 'insert-open-par)
     map))

(add-hook 'dynamic-postgres-mode-hook 'dyn-pg-hook)

(defcustom dyn-pg-snippet-dir "~/.emacs.d/snippets/" "Snippet directory of dynamic postgres minor mode")

(defun toggle-dyn-pg-on ()
  "Configure yasnippet variables"
  (progn
    (delq!  dyn-pg-snippet-dir yas-snippet-dirs); make sure that our snippet comes first
    (push dyn-pg-snippet-dir yas-snippet-dirs)))

(defun toggle-dyn-pg-off ()
  "Unset yasnippet variables"
  (delq!  dyn-pg-snippet-dir yas-snippet-dirs))

(defun dyn-pg-hook ()
  (if dynamic-postgres-mode
      (toggle-dyn-pg-off)
      (toggle-dyn-pg-on)))



(provide 'pg-tweaks)
