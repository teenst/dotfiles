;;default for emacsapp
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
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
;; elispとconfディレクトリをサブディレクトリごとload-pathに通す
(add-to-load-path "elisp" "conf" "public_repos")

;; package.el use melpa
(when (require 'package nil t)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/"))
  (package-initialize))

;; auto-install
(when (require 'auto-install nil t)
  ;; def Install Directory
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; Get elisp name from EmacsWiki
  (auto-install-update-emacswiki-package-name t)
  ;; use func "install-elisp"
  (auto-install-compatibility-setup))

;; inline-patch
(setq default-input-method "MacOSX")

;; "C-t"でウィンドウを切り替える
(define-key global-map (kbd "C-t") 'other-window)

;; カラム番号表示
(column-number-mode t)

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

;; Mac の文字コードの設定
(set-language-environment "Japanese")
(require 'ucs-normalize)
(prefer-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

;; paren-mode 対応する括弧を強調して表示
;(setq show-paren-delay 0) ; 表示秒数
;(show-paren-mode t)

;; インデント
;(setq perl-indent-level 4)
;(setq c-indent-level 4)
(setq-default indent-tabs-mode nil)

;emacs-appフォント
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

;; color-theme


;;undo-tree
;(require 'undo-tree)
;(global-undo-tree-mode)
