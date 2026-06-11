;; Melpa
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;; add custom dir to load path
(add-to-list 'load-path "~/.emacs.d/custom/")

;; YAML mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;; line number on
(global-linum-mode t)
;;(setq linum-format "%d ")

;; projectile w/ grizzl
(require 'grizzl)
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'grizzl)
(global-set-key (kbd "<backtab>") 'projectile-find-file)

;; buffer name autocomplete via ido
(require 'ido)
(ido-mode t)

;; load theme
;;(load-theme 'darkokai t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'monokai t)

;; bind auto-indent to right brace
(global-set-key (kbd "C-M-]") 'indent-region)

;; silver searcher
(require 'ag)

;; Turn off tabs FOREVER
(setq-default indent-tabs-mode nil)

;; Use 2-space indent for JavaScript
(setq js-indent-level 4)

;; use bash environment in windowed mode
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize))

;; git
(require 'git)
(require 'git-blame)

;; prevent silly initial splash screen
(setq inhibit-splash-screen t)

(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 2)))
;; remove toolbar
(tool-bar-mode -1)

(autoload 'crystal-mode "crystal-mode" "Major mode for crystal files" t)
(add-to-list 'auto-mode-alist '("\\.cr$" . crystal-mode))
(add-to-list 'interpreter-mode-alist '("crystal" . crystal-mode))

(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

(when (eq system-type 'darwin)
  (require 'ls-lisp)
  (setq ls-lisp-use-insert-directory-program nil))

(require 'tramp)
(setq tramp-default-method "ssh")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe-mode 0 nil (fringe))
 '(package-selected-packages
   (quote
    (kotlin-mode monokai-theme lispyscript-mode thrift projectile markdown-mode json-mode go-mode exec-path-from-shell elixir-mode darkokai-theme csv-mode ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
