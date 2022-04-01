;;; dart-tweaks.el -*- lexical-binding: t; -*-

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)


(setq package-selected-packages
  '(dart-mode lsp-mode lsp-dart lsp-treemacs flycheck company flutter
    ;; Optional packages
    lsp-ui company hover))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

(add-hook 'dart-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      company-minimum-prefix-length 1
      lsp-lens-enable t
      lsp-signature-auto-activate nil)
(setq lsp-dart-sdk-dir "~/flutter/bin/cache/dart-sdk/")
(setq lsp-dart-flutter-sdk-dir "/home/rafonseca/flutter/")


(with-eval-after-load 'projectile
  (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
  (add-to-list 'projectile-project-root-files-bottom-up "BUILD"))
(use-package lsp-mode
  :init (setq lsp-keymap-prefix "<f5>"))

(use-package flutter
  :after dart-mode
  :bind (:map dart-mode-map
              ("C-M-x" . #'flutter-run-or-hot-reload))
  :custom
  (flutter-sdk-path "~/flutter/"))
(setenv "CHROME_EXECUTABLE" "google-chrome-stable")

(provide 'dart-tweaks)
