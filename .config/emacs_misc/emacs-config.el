(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(setq initial-major-mode 'org-mode)
(setq popup-windows nil)
(setq ring-bell-function 'ignore)
(setq load-prefer-newer t)
(setq site-run-file nil)
(setq x-underline-at-descent-line t)
(setq widget-image-enable nil)
(setq browse-url-browser-function 'browse-url-xdg-open)
(setq window-divider-default-right-width 24)
(setq window-divider-default-places 'right-only)
(setq backup-by-copying t)
(setq confirm-kill-emacs 'yes-or-no-p)
(setq native-comp-speed -1)
(setq native-comp-async-report-warnings-errors nil)
(setq compilation-scroll-output 'first-error)

(setq-default indent-tabs-mode nil)
(setq-default line-spacing 0)


(global-auto-revert-mode t)

(defalias 'yes-or-no-p 'y-or-n-p)

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse
      uniquify-separator " • "
      uniquify-after-kill-buffer-p t
      uniquify-ignore-buffers-re "^\\*")

(save-place-mode t)

(defvar user-temporary-file-directory
  (concat temporary-file-directory user-login-name "/"))

(make-directory user-temporary-file-directory t)

(setq backup-directory-alist `(("." . ,user-temporary-file-directory)
                               (tramp-file-name-regexp nil)))

(setq auto-save-file-name-transforms `((".*" ,user-temporary-file-directory t)))

(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))

(setq create-lockfiles nil)

(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment   'utf-8)

;; (use-package modus-themes)
  (require-theme 'modus-themes)

  (setq modus-themes-bold-constructs t)
  (setq modus-themes-italic-constructs t)
  (setq modus-themes-subtle-line-numbers t)
  (setq modus-themes-fringes 'subtle)
  (setq modus-themes-variable-pitch-ui t)

  (load-theme 'modus-vivendi)

;;  (set-face-font 'default "Rec Mono SemiCasual-16")
;;
;;  (setq default-frame-alist
;;        (append (list
;;                 '(font . "Rec Mono Casual-14"))))
;;
;;  (set-fontset-font t 'symbol "Noto Color Emoji" nil 'append)

  (set-default 'cursor-type '(bar . 1))

  (menu-bar-mode 0)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (show-paren-mode t)
  (window-divider-mode 1)

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(use-package selectrum)
(use-package selectrum-prescient)
(use-package marginalia)

(selectrum-mode t)
(selectrum-prescient-mode t)
(prescient-persist-mode t)
(marginalia-mode)

(autoload 'ffap-guesser "ffap")
(autoload 'ffap-file-at-point "ffap")

(defun minibuffer-default-add-function+ ()
  (with-selected-window (minibuffer-selected-window)
    (delete-dups
     (delq nil
           (list (thing-at-point 'symbol)
                 (thing-at-point 'list)
                 (ffap-guesser))))))

(defun complete-path-at-point+ ()
  (let ((fn (ffap-file-at-point))
        (fap (thing-at-point 'filename)))
    (when (and (or fn
                   (equal "/" fap))
               (save-excursion
                 (search-backward fap (line-beginning-position) t)))
      (list (match-beginning 0)
            (match-end 0)
            #'completion-file-name-table))))


(setq minibuffer-default-add-function #'minibuffer-default-add-function+)
(add-hook 'completion-at-point-functions #'complete-path-at-point+ 'append)

(use-package corfu)

(global-corfu-mode)

(setq completion-cycle-threshold 3)
(setq read-extended-command-predicate #'command-completion-default-include-p)
(setq corfu-auto t)
(setq corfu-quit-no-match 'separator)

(use-package editorconfig)
(editorconfig-mode t)

(use-package apheleia)
(apheleia-global-mode t)

(use-package project)
(use-package tabspaces)
(use-package ripgrep)

(setq project-vc-extra-root-markers '(".prj"))

(setq tabspaces-use-filtered-buffers-as-default t)
(setq tabspaces-remove-to-default nil)
(setq tabspaces-include-buffers '("*scratch*"))

(setq tab-bar-close-button-show nil)
(setq tab-bar-tab-hints t)

(setq xref-search-program 'ripgrep)

(add-to-list 'project-switch-commands '(magit-project-status "Magit" ?m))

(tabspaces-mode)

(setq org-startup-indented nil)
(setq org-image-actual-width (truncate (window-pixel-width)))
(setq org-todo-keywords '((sequence "TODO" "DOING" "|" "DONE")))

(defun enable-visual-line-mode ()
  (visual-line-mode t))

(add-hook 'org-mode-hook #'enable-visual-line-mode)

(use-package outshine)
(add-hook 'emacs-lisp-mode-hook 'outshine-mode)

(use-package magit)

(setq magit-completing-read-function #'selectrum-completing-read)

(use-package git-link)

;;; Terminal Emulation

(use-package vterm)

(require 'treesit)

(setq treesit-language-source-alist
      '((bash . ("git@github.com:tree-sitter/tree-sitter-bash.git"))
        (c . ("git@github.com:tree-sitter/tree-sitter-c.git"))
        (cpp . ("git@github.com:tree-sitter/tree-sitter-cpp.git"))
        (css . ("git@github.com:tree-sitter/tree-sitter-css.git"))
        (elixir . ("git@github.com:elixir-lang/tree-sitter-elixir.git"))
        (heex . ("git@github.com:phoenixframework/tree-sitter-heex.git"))
        (go . ("git@github.com:tree-sitter/tree-sitter-go.git"))
        (html . ("git@github.com:tree-sitter/tree-sitter-html.git"))
        (javascript . ("git@github.com:tree-sitter/tree-sitter-javascript.git"))
        (json . ("git@github.com:tree-sitter/tree-sitter-json.git"))
        (lua . ("git@github.com:Azganoth/tree-sitter-lua.git"))
        (make . ("git@github.com:alemuller/tree-sitter-make.git"))
        (ocaml . ("git@github.com:tree-sitter/tree-sitter-ocaml.git" "ocaml/src" "ocaml"))
        (python . ("git@github.com:tree-sitter/tree-sitter-python.git"))
        (php . ("git@github.com:tree-sitter/tree-sitter-php.git"))
        (typescript . ("git@github.com:tree-sitter/tree-sitter-typescript.git" "typescript/src" "typescript"))
        (ruby . ("git@github.com:tree-sitter/tree-sitter-ruby.git"))
        (rust . ("git@github.com:tree-sitter/tree-sitter-rust.git"))
        (sql . ("git@github.com:m-novikov/tree-sitter-sql.git"))
        (toml . ("git@github.com:tree-sitter/tree-sitter-toml.git"))
        (zig . ("git@github.com:GrayJack/tree-sitter-zig.git"))))

(require 'ansi-color)

(defun colorize-compilation-buffer ()
  (ansi-color-apply-on-region compilation-filter-start (point-max)))

(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(require 'eglot)

(fset #'jsonrpc--log-event #'ignore)

(use-package asdf
  :straight (:type git :host github :repo "tabfugnic/asdf.el"))

(require 'asdf)

(asdf-enable)

(use-package enh-ruby-mode)

(add-to-list 'auto-mode-alist
             '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))

(use-package rubocop)
(add-hook 'enh-ruby-mode-hook #'rubocop-mode)
(add-hook 'enh-ruby-mode-hook 'eglot-ensure)

(use-package bundler)

(use-package elixir-mode)
(use-package exunit)
(use-package mix)

(add-to-list 'auto-mode-alist '("\\(?:\\.ex\\|\\.exs\\)" . elixir-mode))
(add-to-list 'eglot-server-programs '(elixir-mode "~/.local/bin/elixir-ls-0.15.0/language_server.sh"))

(add-hook 'elixir-mode-hook 'eglot-ensure)
(add-hook 'elixir-mode-hook 'mix-minor-mode)

(use-package markdown-toc)

(use-package yaml-mode)

(use-package typescript-mode)
(use-package web-mode)
(use-package json-mode)

(add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescript-mode))

(add-hook 'typescript-mode-hook 'eglot-ensure)

(use-package zig-mode)

(use-package haskell-mode)

(use-package nix-mode)
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

(use-package rustic)

(setq rustic-format-on-save t)
(setq rustic-format-trigger 'on-save)

(use-package go-mode)

(use-package protobuf-mode)
(add-to-list 'auto-mode-alist '("\\.proto?\\'" . protobuf-mode))

(use-package smalltalk-mode)

(use-package kubernetes)
(use-package terraform-mode)
(use-package dockerfile-mode)

(add-to-list 'auto-mode-alist '("\\.tf\\'" . terraform-mode))
(add-to-list 'auto-mode-alist '("\\Dockerfile" . dockerfile-mode))

(use-package pocket-reader)

(use-package envrc)

(envrc-global-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values '((require . "publish.el"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
