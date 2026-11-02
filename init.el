;;; init.el --- Personal Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Requires Emacs 29+ (uses built-in use-package and display-line-numbers).

;;; Code:

;;;; Package management
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package)
(setq use-package-always-ensure t)

;; Keep Customize's auto-generated settings out of init.el.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file nil t))

;;;; UI and styling
(setq inhibit-startup-screen t)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'fringe-mode)
  (fringe-mode 0))

;; Line numbers (replaces linum-mode, which was removed in Emacs 29).
(global-display-line-numbers-mode t)
(column-number-mode t)
(show-paren-mode t)

(use-package monokai-theme
  :config
  (load-theme 'monokai t t)             ; load, but don't enable yet
  ;; monokai sets `:distant-foreground nil' on some faces, which Emacs 29+
  ;; rejects with a warning.  Rewrite those to `unspecified' before enabling.
  (dolist (setting (get 'monokai 'theme-settings))
    (when (eq (car setting) 'theme-face)
      (dolist (clause (nth 3 setting))
        (let ((attrs (cadr clause)))
          (when (and (listp attrs)
                     (plist-member attrs :distant-foreground)
                     (null (plist-get attrs :distant-foreground)))
            (plist-put attrs :distant-foreground 'unspecified))))))
  (enable-theme 'monokai))

;;;; Editing
;; Turn off tabs FOREVER
(setq-default indent-tabs-mode nil)
(setq js-indent-level 4)
(add-hook 'java-mode-hook (lambda () (setq c-basic-offset 2)))

(global-set-key (kbd "C-M-]") #'indent-region)

;;;; Completion and navigation
(use-package ido
  :ensure nil
  :config
  (setq ido-enable-flex-matching t
        ido-everywhere t)
  (ido-mode t))

(use-package projectile
  :demand t
  :config
  (setq projectile-enable-caching t
        projectile-completion-system 'ido)
  (projectile-mode t)
  :bind (("<backtab>" . projectile-find-file)
         :map projectile-mode-map
         ("C-c p" . projectile-command-map)))

;; Silver searcher
(use-package ag :defer t)

;;;; Environment
;; Use the login shell's PATH in GUI Emacs on macOS.
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-initialize))

;; macOS `ls' doesn't support --dired; use Emacs' Lisp implementation.
(when (eq system-type 'darwin)
  (require 'ls-lisp)
  (setq ls-lisp-use-insert-directory-program nil))

(use-package tramp
  :ensure nil
  :config
  (setq tramp-default-method "ssh"))

;;;; Git
(use-package magit
  :bind ("C-x g" . magit-status))

;;;; Language modes
(use-package yaml-mode)
(use-package json-mode)
(use-package markdown-mode)
(use-package go-mode)
(use-package elixir-mode)
(use-package kotlin-mode)
(use-package csv-mode)
(use-package crystal-mode)
(use-package thrift)
(use-package lispyscript-mode)

;; Alternate theme, installed but not loaded: M-x load-theme RET darkokai
(use-package darkokai-theme :defer t)

(provide 'init)
;;; init.el ends here
