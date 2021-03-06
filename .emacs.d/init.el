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

;; PATHを追加
(setenv "PATH" (mapconcat 'identity exec-path ":"))


; Emacs package
;; package.el use melpa
(setq url-http-attempt-keepalives nil)

;; measure same file name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(when (require 'package nil t)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives
               '("ELPA" . "http://tromey.com/elpa/"))
  (package-initialize))
;; melpa.el
;(require 'melpa)

;; auto-install
(when (require 'auto-install nil t)
  ;; def Install Directory
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; Get elisp name from EmacsWiki
  (auto-install-update-emacswiki-package-name t)
  ;; use func "install-elisp"
  (auto-install-compatibility-setup))


; Emacs command & window views
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

;; カラム番号表示
(column-number-mode t)

;; ラインにハイライト
(global-hl-line-mode t)
(setq hl-line-face 'underline)

;; タイトルバーにフルパスを表示
(setq frame-title-format "%f")

;;menu-bar非表示
(menu-bar-mode 0)


;; "C-t"でウィンドウを切り替える
(define-key global-map (kbd "C-t") 'other-window)

;; 入力されるキーシーケンスを入れ替える
;; ?\C-?はDELのキーシーケンス
(keyboard-translate ?\C-h ?\C-?)
;; 別のキーバインドにヘルプを割り当てる
(global-set-key (kbd "C-x ?") 'help-command)
;; emacsキーバインド
;(require 'emacs-keybind)

;;Backupファイルを作らない
(setq make-backup-files nil)

;; インデント
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
          ("-cdac$" . 1.3)))

  ;; color-theme
  (load-theme 'solarized-dark t))

;cua-mode
;;from http://tech.kayac.com/archivmode/emacs-rectangle.html
(cua-mode t)
(setq cua-enable-cua-keys nil) ; そのままだと C-x が切り取りになってしまったりするので無効化

;redo+
(require 'redo+)
(global-set-key (kbd "C-?") 'redo)
(setq undo-no-redo t)

;関数移動のためのimenu(この割当てはterminal emacsでは不可能)
(global-set-key (kbd "C-.") 'imenu)


; auto-complete
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories 
               "~/.emacs.d/elpa/auto-complete-20131128.233/dict/")
  (ac-config-default)
  (setq ac-use-menu-map t)
  (setq ac-auto-start 2)  ;; n文字以上の単語の時に補完を開始
  (setq ac-delay 0.05)  ;; n秒後に補完開始
  (setq ac-use-fuzzy t)  ;; 曖昧マッチ有効
  (setq ac-use-comphist t)  ;; 補完推測機能有効
  (setq ac-auto-show-menu 0.05)  ;; n秒後に補完メニューを表示
  (setq ac-quick-help-delay 0.5)  ;; n秒後にクイックヘルプを表示
  (setq ac-ignore-case nil)  ;; 大文字・小文字を区別する
  (define-key ac-menu-map "\C-n" 'ac-next)
  (define-key ac-menu-map "\C-p" 'ac-previous))


;; Helm-mode
;; from http://d.hatena.ne.jp/a_bicky/20140104/1388822688
(global-set-key (kbd "C-c h") 'helm-mini)
(when (require 'helm-config nil t)
  (helm-mode 1)

  (define-key global-map (kbd "M-x")     'helm-M-x)
  (define-key global-map (kbd "C-x C-f") 'helm-find-files)
  (define-key global-map (kbd "C-x C-r") 'helm-recentf)
  (define-key global-map (kbd "M-y")     'helm-show-kill-ring)
  (define-key global-map (kbd "C-c i")   'helm-imenu)
  (define-key global-map (kbd "C-x b")   'helm-buffers-list)

  (define-key helm-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

  ;; Disable helm in some functions
  (add-to-list 'helm-completing-read-handlers-alist '(find-alternate-file . nil))

  ;; Emulate `kill-line' in helm minibuffer
  (setq helm-delete-minibuffer-contents-from-point t)
  (defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
    "Emulate `kill-line' in helm minibuffer"
    (kill-new (buffer-substring (point) (field-end))))

  (defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
    "Execute command only if CANDIDATE exists"
    (when (file-exists-p candidate)
      ad-do-it))

  (defadvice helm-ff-transform-fname-for-completion (around my-transform activate)
    "Transform the pattern to reflect my intention"
    (let* ((pattern (ad-get-arg 0))
           (input-pattern (file-name-nondirectory pattern))
           (dirname (file-name-directory pattern)))
      (setq input-pattern (replace-regexp-in-string "\\." "\\\\." input-pattern))
      (setq ad-return-value
            (concat dirname
                    (if (string-match "^\\^" input-pattern)
                        ;; '^' is a pattern for basename
                        ;; and not required because the directory name is prepended
                        (substring input-pattern 1)
                      (concat ".*" input-pattern)))))))

; Ruby
;;rbenv
(setq rbenv-installation-dir "~/.rbenv")
(global-rbenv-mode)

;; Ruby-mode
(autoload 'ruby-mode "ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;; rcodetools
(require 'rcodetools)
(setq rct-find-tag-if-available nil)
(defun ruby-mode-hook-rcodetools ()
  (define-key ruby-mode-map "\C-c\C-c" 'rct-complete-symbol)
  (define-key ruby-mode-map "\C-c\C-t" 'ruby-toggle-buffer)
  (define-key ruby-mode-map "\C-c\C-d" 'xmp)
  (define-key ruby-mode-map "\C-c\C-f" 'rct-ri))
(add-hook 'ruby-mode-hook 'ruby-mode-hook-rcodetools)
(add-hook 'ruby-mode-hook
          (lambda ()
            (require 'rcodetools)
            (require 'auto-complete-ruby)
            (make-local-variable 'ac-omni-completion-sources)
            (setq ac-omni-completion-sources '(("\\.\\=" . (ac-source-rcodetools))))))

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


;; http://d.hatena.ne.jp/kitokitoki/20100802/p1
(add-hook 'ruby-mode-hook
  (lambda ()
    (font-lock-add-keywords nil
      '(("^[^\n]\\{80\\}\\(.*\\)$" 1 font-lock-warning-face t)))))




; python
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


; YaTeX mode
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)
                ("\\.ltx$" . yatex-mode)
                ("\\.cls$" . yatex-mode)
                ("\\.sty$" . yatex-mode)
                ("\\.clo$" . yatex-mode)
                ("\\.bbl$" . yatex-mode)) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq tex-command "/usr/texbin/ptex2pdf -l -ot '-synctex=1 -file-line-error'")
(setq dvi2-command "/usr/bin/open -a TeXShop")
(setq YaTeX-kanji-code 4)
(setq bibtex-command "pbibtex")
(add-hook 'yatex-mode-hook 'turn-on-reftex)
;;(add-hook 'yatex-mode-hook'(lambda ()(setq auto-fill-function nil)))


;markdown-mode
(setq auto-mode-alist 
      (cons '("\\.md" . markdown-mode) auto-mode-alist))

(defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
  (setq flymake-check-was-interrupted t))
(ad-activate 'flymake-post-syntax-check)
