(setq os-packages-path "C:\\gabri\\.emacs.d\\emacs_packages")
(setq vc-follow-symlinks t)
(prefer-coding-system 'utf-8-unix)

(add-to-list 'load-path
	  (concat os-packages-path "use-package/"))

;; per spacemacs theme
(add-to-list 'load-path "C:\\gabri\\.emacs.d\\emacs_themes\\spacemacs-theme-20230530.1751")

(package-initialize)
(require 'use-package)

(use-package package
  :config
  (setq package-archive-priorities
	'(("melpa-stable" .2)
	  ("MELPA" .1)
	  ("gnu" .0)))
  (setq package-archives
	'(("melpa-stable" . "https://stable.melpa.org/packages/")
	  ("MELPA" . "https://melpa.org/packages/")
	  ("gnu" . "http://elpa.gnu.org/packages/")
	  ("gnu-devel" . "https://elpa.gnu.org/devel/")))
  )

(add-to-list 'custom-theme-load-path  "C:\\gabri\\.emacs.d\\emacs_themes\\spacemacs-theme-20230530.1751")
(load-theme 'spacemacs-dark t)

(use-package org-bullets
  :ensure t
  :hook
  (org-mode . org-bullets-mode)

  :config
  (setq org-bullets-face-name (quote org-bullets-face))
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

  (setq org-bullets-bullet-list '("✙" "✞" "✟" "✝" "†" "✠" "✚" "✜" "✛" "✢" "✣" "✤" "✥"))
 )

(use-package company
:ensure t
:defer t
:config
(setq company-idle-delay 0)
(setq company-minimum-prefix-lenght 3)
(setq company-selection-wrap-around t)
(company-tng-configure-default)
(setq company-quickhelp-color-background "#4F4F4F")
(setq company-quickhelp-colo-foreground "#DCDCCC")

(global-company-mode 1))

(use-package ivy
 :ensure t
 :config
 (ivy-mode 1)
 (setq ivy-re-builders-alist
	 '((swiper . ivy--regex-plus)
	   (t      . ivy--regex-fuzzy)))
)

(use-package swiper
   :ensure t
   :config
   (global-set-key "\C-s" 'swiper)
 )

(use-package beacon
  :ensure t
  :config
  (beacon-mode 1))

(use-package all-the-icons
  :ensure t)

(use-package nyan-mode
  :ensure t
  :config
  (nyan-mode)
  )

;; Simple type 'y' for 'yes' and 'n' for 'no'.
(defalias 'yes-or-no-p
  'y-or-n-p)

(defalias 'yes-or-no-p 'y-or-n-p)

;; Set global value for paragraph width
(setq-default fill-column 70)

;; Stop emacs from losing informations.
(setq undo-limit 20000000)
(setq undo-strong-limit 40000000)

;; Smooth scroll
(setq scroll-step 3)
(setq line-number-mode t)
(setq inhibit-startup-screen t)
(setq ring-bell-function (quote ignore))

;; Display Clock 
(display-time)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; Turn off the toolbar
(tool-bar-mode 0)

;; add column number in the main bar
(column-number-mode)

(global-visual-line-mode)

(setq auto-mode-alist
       (append
	'(("\\.cpp$"    . c++-mode)
	  ("\\.hin$"    . c++-mode)
	  ("\\.cin$"    . c++-mode)
	  ("\\.inl$"    . c++-mode)
	  ("\\.rdc$"    . c++-mode)
	  ("\\.h$"      . c++-mode)
	  ("\\.c$"      . c++-mode)
	  ("\\.cc$"     . c++-mode)
	  ("\\.c8$"     . c++-mode)
	  ("\\.txt$"    . indented-text-mode)
	  ("\\.emacs$"  . emacs-lisp-mode)
	  ("\\.gen$"    . gen-mode)
	  ("\\.ms$"     . fundamental-mode)
	  ("\\.m$"      . objc-mode)
	  ("\\.mm$"     . objc-mode)
	  ("\\.asm$"    . asm86-mode)
	  ("\\.inc$"    . asm86-mode)
	  ) auto-mode-alist))

(setq auto-mode-alist
       (append
	'((".offlineimaprc"   . conf-mode)
	  (".moc.conf"        . conf-mode)
	  ("github_blog.prf"  . conf-mode)
	  ("knwl_org.prf"     . conf-mode)
	  ("public_org.prf"   . conf-mode)
	  ("i3config"         . conf-mode)
	  (".i3blocks.conf"   . conf-mode)
	  (".compton.conf"    . conf-mode)
	  (".gitconfig"       . conf-mode)
	  ) auto-mode-alist))

;; -------------------------------
;; Colored text
;; -------------------------------
(setq fixme-modes '(c++-mode c-mode emacs-lisp-mode latex-mode scheme-mode python-mode))
(make-face 'font-lock-fixme-face)
(make-face 'font-lock-note-face)
(make-face 'font-lock-important-face)
(make-face 'font-lock-debug-face)

(mapc (lambda (mode)
	    (font-lock-add-keywords
	     mode
	     '(("\\<\\(TODO\\)" 1 'font-lock-fixme-face t)
	       ("\\<\\(DEBUG\\)" 1 'font-lock-debug-face t)
	       ("\\<\\(IMPORTANT\\)" 1 'font-lock-important-face t)
	       ("\\<\\(NOTE\\)" 1 'font-lock-note-face t))))
	  fixme-modes)

(modify-face 'font-lock-fixme-face "Magenta" nil nil t nil t nil nil)
(modify-face 'font-lock-debug-face "DarkOrange" nil nil t nil t nil nil)
(modify-face 'font-lock-important-face "Red" nil nil t nil t nil nil)
(modify-face 'font-lock-note-face "DeepSkyBlue" nil nil t nil t nil nil)

(defun my/tangle-dotfiles()
   (interactive)
  (when (equal (buffer-file-name)
	       (expand-file-name "C:\\gabri\\.emacs.d\\dotemacs.org"))
    (org-babel-tangle)
    (message "Dotfile tangle")	       
  ))

(add-hook 'after-save-hook #'my/tangle-dotfiles)
