;;; regex-utils.el -*- lexical-binding: t; -*-

(defun first (l)
  (nth 0 l))
(defun second (l)
  (nth 1 l))

;;;  parse env file
(setq parse-env-regex (rx (seq bol (group(*? nonl)) "=" (group(*? nonl)) eol)))

(defun get-matched-group (group-number)
  (buffer-substring-no-properties (match-beginning group-number) (match-end group-number)))

(defun parse-env (buffer regex)
  (with-current-buffer buffer
    (goto-char 0)
    (let (kv-list '())
      (while (setq point (re-search-forward regex nil t))
             (let ((kv (list (get-matched-group 1) (get-matched-group 2))))
               (setq kv-list (cons kv kv-list))))
      kv-list)))

(parse-env "circleci_staging.env" parse-env-regex)

(defun replace-kv (key value buffer)
  (with-current-buffer (or buffer (current-buffer))
   (goto-char 0)
   (replace-regexp
    (rx-to-string `(seq "$" ,key))
    value)))

(dolist
    (kv (parse-env "circleci_staging.env" parse-env-regex))
    (replace-kv (first kv) (second kv) "deploy-staging.sh"))


(with-current-buffer "circleci_staging.env"
  (re-search-forward parse-env-regex nil t)
  (get-matched-group 2))

(setq ll '())
(cons 1 ll)
(mapc)
