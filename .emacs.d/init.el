;;default for emacsapp
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;load-pathを追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))
;; elispディレクトリをサブディレクトリごとload-pathに通す
(add-to-load-path "elisp" "site-lisp")

;; package.el use melpa
(setq url-http-attempt-keepalives nil)

(when (require 'package nil t)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives
               '("ELPA" . "http://tromey.com/elpa/"))
  (package-initialize))
; melpa.el
(require 'melpa)

;; auto-install
(when (require 'auto-install nil t)
  ;; def Install Directory
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; Get elisp name from EmacsWiki
  (auto-install-update-emacswiki-package-name t)
  ;; use func "install-elisp"
  (auto-install-compatibility-setup))


;; "C-t"でウィンドウを切り替える
(define-key global-map (kbd "C-t") 'other-window)

;; カラム番号表示
(column-number-mode t)

;; ラインにハイライト
(global-hl-line-mode t)

;; タイトルバーにフルパスを表示
(setq frame-title-format "%f")

;;menu-bar非表示
(menu-bar-mode 0)

;;関数移動のためのimenu(この割当てはterminal emacsでは不可能)
(global-set-key (kbd "C-.") 'imenu)

;;Backupファイルを作らない
(setq make-backup-files nil)


;; 入力されるキーシーケンスを入れ替える
;; ?\C-?はDELのキーシーケンス
(keyboard-translate ?\C-h ?\C-?)
;; 別のキーバインドにヘルプを割り当てる
(global-set-key (kbd "C-x ?") 'help-command)
;; emacsキーバインド
;(require 'emacs-keybind)

;; PATHを追加
(setenv "PATH" (mapconcat 'identity exec-path ":"))



;; paren-mode 対応する括弧を強調して表示
;(setq show-paren-delay 0) ; 表示秒数
;(show-paren-mode t)

;; インデント
;(setq perl-indent-level 4)
;(setq c-indent-level 4)
(setq-default indent-tabs-mode nil)

;; Mac用の設定
(when (eq system-type 'darwin)
  ;; inline-patch
  (setq default-input-method "MacOSX")
  
  ;; Mac 文字コードの設定
  (set-language-environment "Japanese")
  (require 'ucs-normalize)
  (prefer-coding-system 'utf-8)
  (setq file-name-coding-system 'utf-8)
  (setq locale-coding-system 'utf-8)

  ;;emacs-appフォント
  (set-face-attribute 'default nil
                      :family "Menlo"
                      :height 150)
  (set-fontset-font
   nil 'japanese-jisx0208
   (font-spec :family "Hiragino_Maru_Gothic_ProN"))
  
  (setq face-font-rescale-alist
        '((".*Menlo.*" . 1.0)
          (".*Hiragino_Maru_Gothic_ProN.*" . 1.2)
          ("-cdac$" . 1.3))))

;; タブ文字と全角スペースの可視化
(setq whitespace-style
      '(tabs tab-mark spaces space-mark))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))
(require 'whitespace)
(global-whitespace-mode 1)
(set-face-foreground 'whitespace-space "LightSlateGray")
(set-face-background 'whitespace-space "DarkSlateGray")
(set-face-foreground 'whitespace-tab "LightSlateGray")
(set-face-background 'whitespace-tab "DarkSlateGray")


;; auto-complete
;; M-x package-install RET auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories 
             "~/.emacs.d/elpa/auto-complete-20130724.1750/dict/")
(ac-config-default)
;; (setq ac-auto-start nil)
;; (ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)


;; Helm-mode
(global-set-key (kbd "C-c h") 'helm-mini)
(helm-mode 1)
;(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-helm)

;; color-theme
(load-theme 'solarized-dark t)

;;undo-tree
;(require 'undo-tree)
;(global-undo-tree-mode)

;; Ruby-mode
(autoload 'ruby-mode "ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;; Ruby-insert-end
(defun ruby-insert-end ()
  (interactive)
  (insert "end")
  (ruby-indent-line t)
  (end-of-line))


;; ruby-block
(require 'ruby-block)
(setq ruby-block-highlight-toggle t)
(defun ruby-mode-hook-ruby-block()
  (ruby-block-mode t))
(add-hook 'ruby-mode-hook 'ruby-mode-hook-ruby-block)

;; ruby-elecrtric
(defun ruby-mode-hook-ruby-elecrtric ()
  (ruby-electric-mode t))
(add-hook 'ruby-mode-hook 'ruby-mode-hook-ruby-elecrtric)


;; Ruby flymake
(require 'flymake)

(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))
(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

(defun ruby-mode-hook-flymake-init ()
 "Don't want flymake mode for ruby regions in rhtml files and also on read only files"
  (if (and (not (null buffer-file-name))
           (file-writable-p buffer-file-name))
      (flymake-mode-on)))
(add-hook 'ruby-mode-hook 'ruby-mode-hook-flymake-init)

(require 'ruby-tools)

;;Rsense
;;read http://cx4a.org/software/rsense/manual.ja.html
(setq rsense-home "/Users/teenst/.emacs.d/opt/rsense-0.3")
(require 'rsense)

(add-hook 'ruby-mode-hook
          '(lambda ()
             ;; .や::を入力直後から補完開始
             (add-to-list 'ac-sources 'ac-source-rsense-method)
             (add-to-list 'ac-sources 'ac-source-rsense-constant)
             ;; C-x .で補完出来るようキーを設定
             (define-key ruby-mode-map (kbd "C-x .") 'ac-complete-rsense)))

;;Rsense hook Reference
;(setq rsense-rurema-home (concat rsense-home "/doc/ruby-refm-1.9.3-dynamic-snapshot"))
;(setq rsense-rurema-refe "refe-1_9_3")

;; Ruby indent
;; http://willnet.in/13
(setq ruby-deep-indent-paren-style nil)
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

;;ruby-refactor
(add-hook 'ruby-mode-hook 'ruby-refactor-mode-launch)

;;zossima
(add-hook 'ruby-mode-hook 'zossima-mode)


;; python
(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))
(add-hook 'python-mode-hook '(lambda () 
            (define-key python-mode-map "\"" 'electric-pair)
            (define-key python-mode-map "\'" 'electric-pair)
            (define-key python-mode-map "(" 'electric-pair)
            (define-key python-mode-map "[" 'electric-pair)
            (define-key python-mode-map "{" 'electric-pair)
            (define-key python-mode-map "\C-m" 'newline-and-indent)))
;;; ac-python
(require 'ac-python)

;;flymake-python
;;(install-elisp "https://raw.github.com/seanfisk/emacs/sean/src/lib/flymake-python.el")
(when (require 'flymake-python nil t)
  ;;use flake8
  (setq flymake-python-syntax-checker "flake8"))
(load-library "flymake-cursor")


;; YaTeX mode
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)
                ("\\.ltx$" . yatex-mode)
                ("\\.cls$" . yatex-mode)
                ("\\.sty$" . yatex-mode)
                ("\\.clo$" . yatex-mode)
                ("\\.bbl$" . yatex-mode)) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq tex-command "/usr/texbin/ptex2pdf -l -u -ot '-synctex=1'")
(setq dvi2-command "/usr/bin/open -a TeXShop")
(setq YaTeX-kanji-code 4)
(setq bibtex-command "pbibtex")
(add-hook 'yatex-mode-hook 'turn-on-reftex)
;;(add-hook 'yatex-mode-hook'(lambda ()(setq auto-fill-function nil)))


;;markdown-mode
(setq auto-mode-alist 
      (cons '("\\.md" . markdown-mode) auto-mode-alist))
