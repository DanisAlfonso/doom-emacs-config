;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Danny Ramírez"
      user-mail-address "danis.ramirez.hn@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-horizon)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Disable the exit confirmation prompt
(setq confirm-kill-emacs nil)

;; Set default frame size
(add-to-list 'default-frame-alist '(width . 120))  ; Width in characters
(add-to-list 'default-frame-alist '(height . 38)) ; Height in characters

;; Set transparency
(add-to-list 'default-frame-alist '(alpha . (90 . 97))) ; 90% active, 97% inactive

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-banner)

;; Set custom frame title
(setq frame-title-format '("DNR Emacs - %b"))

;; Enable org-modern
(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  ;; Add custom configuration for org-modern if needed
  (setq org-modern-star ["◉" "○" "✸" "✿"]
        org-modern-list '((43 . "➤") (45 . "•") (42 . "◦"))))

;; Enable org-appear
(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autolinks t))

;; Configure org-roam
(use-package! org-roam
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory (file-truename "~/org-roam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i"   . completion-at-point))
  :config
  (org-roam-setup))

;; All the icons configuration
(use-package! all-the-icons
  :if (display-graphic-p))

(use-package! all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package! all-the-icons-ivy-rich
  :init (all-the-icons-ivy-rich-mode 1))

(use-package! all-the-icons-ivy
  :after ivy
  :init
  (setq all-the-icons-ivy-buffer-commands
        '(ivy-switch-buffer
          ivy-switch-buffer-other-window
          counsel-projectile-switch-to-buffer
          counsel-projectile-switch-to-buffer-other-window))
  :config
  (all-the-icons-ivy-setup))

;; Additional org-mode configurations
(after! org
  (setq org-hide-emphasis-markers t  ;; Hide markup elements
        org-pretty-entities t        ;; Display entities as Unicode symbols
        org-startup-with-inline-images t  ;; Show inline images by default
        org-image-actual-width '(300) ;; Default width for images
        org-startup-indented t        ;; Enable org-indent-mode by default
        org-startup-folded 'content   ;; Fold Org mode buffers by default
        org-ellipsis " ⤵"             ;; Change ellipsis symbol
        ))

;; Custom org faces
(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.3))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.2))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.1))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
 ;; Add more customization here
 )

;; Org mode syntax highlighting for source code blocks
(setq org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-edit-src-content-indentation 2
      org-src-window-setup 'current-window)

(setq org-hide-leading-stars t
      org-odd-levels-only t)

