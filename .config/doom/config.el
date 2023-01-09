;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Otero Díaz"
      user-mail-address "4396445-oterodiaz@users.noreply.gitlab.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq doom-font (font-spec :family "SFMono Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "SF Pro Rounded" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-tomorrow-night)
(setq dark-theme 'doom-tomorrow-night)
(setq light-theme 'doom-tomorrow-day)
(defun get-correct-theme ()
  (if (= (call-process-shell-command "dark_mode.sh") 0)
      dark-theme
    light-theme))
(setq doom-theme (get-correct-theme))

;; Function to run when the macOS theme changes
(defun update-theme ()
  (load-theme (get-correct-theme)))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Notes/")


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

;; Set default window size
(setq initial-frame-alist '((width . 120) (height . 60)))

;; Enable smooth scrolling
(setq mac-mouse-wheel-smooth-scroll t)
(setq mouse-wheel-progressive-speed 1)

;; Configure the scroll margin
(setq scroll-margin 7)
(setq hscroll-margin 7)

;; Configure fill column
(setq fill-column 80)

;; Set the font size of org latex previews
(after! org (plist-put org-format-latex-options :scale 3.0))

;; Remap evil-ex (:) to ;
(map! :desc "Remap evil-ex (:) to ;"
      :nv
      ";" #'evil-ex)

;; Use right option key as meta when not in insert mode
(defun option-to-compose ()
  (setq mac-right-option-modifier 'compose-chars))
(defun option-to-meta ()
  (setq mac-right-option-modifier 'meta))
(add-hook 'evil-insert-state-entry-hook 'option-to-compose)
(add-hook 'evil-insert-state-exit-hook 'option-to-meta)
(option-to-meta)

;; Keymap for toggling trailing whitespace highlighting
(defun toggle-show-trailing-whitespace ()
  "Toggle show-trailing-whitespace"
  (interactive)
  (setq show-trailing-whitespace (not show-trailing-whitespace))
  (message "%s Trailing Whitespace Highlighting"
           (if show-trailing-whitespace "Enabled" "Disabled")))
(map! :leader
      :desc "Toggle show-trailing-whitespace for the current buffer"
      "t t" #'toggle-show-trailing-whitespace)

;; Writable buffer for rustic-cargo-run
(defun interactive-rustic-cargo-run ()
  (interactive)
  (rustic-cargo-run)
  (let (
      (orig-win (selected-window))
      (run-win (display-buffer (get-buffer "*cargo-run*") nil 'visible))
    )
    (select-window run-win)
    (comint-mode)
    (read-only-mode 0)
    (end-of-buffer)
  )
)
(map! :after rustic
      :localleader
      :map rustic-mode-map
      :desc "Run 'cargo run' interactively."
      "b R" #'interactive-rustic-cargo-run)
