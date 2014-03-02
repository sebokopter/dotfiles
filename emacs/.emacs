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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;; Cperl-Mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.\\([pP]\\([Llm]\\|[oO][dD]\\)\\|al+\\|t\\|manuscript\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

; perldoc
(add-hook 'cperl-mode-hook
  (lambda ()
    (local-set-key (kbd "C-h f") 'cperl-perldoc)))
(setq cperl-invalid-face (quote off))
(setq cperl-electric-keywords t)

; mode-compile
(autoload 'mode-compile "mode-compile")
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile" "Command to kill a compilation launched by `mode-compile`" t)
(global-set-key "\C-ck" 'mode-compile-kill)

;; Helper for compilation. Close the compilation window if
;; there was no error at all.
(setq compilation-exit-message-function
       (lambda (status code msg)
         ;; If M-x compile exists with a 0
         (when (and (eq status 'exit) (zerop code))
           ;; then bury the *compilation* buffer, so that C-x b doesn't go there
 	  (bury-buffer "*compilation*")
 	  ;; and return to whatever were looking at before
 	  (replace-buffer-in-windows "*compilation*"))
         ;; Always return the anticipated result of compilation-exit-message-function
 	(cons msg code)))
; don't indent horizontally to the parenthesis instead indent as expected just a tabular width
(custom-set-variables '(cperl-indent-parens-as-block t))

(defun prelude-cperl-mode-defaults ()
  (setq cperl-indent-level 4)
  (setq cperl-continued-statement-offset 8)
  ;; cperl-hairy affects all those variables, but I prefer
  ;; a more fine-grained approach as far as they are concerned
  (setq cperl-font-lock t)
  (setq cperl-electric-lbrace-space t)
  (setq cperl-electric-parens nil)
  (setq cperl-electric-linefeed nil)
  (setq cperl-electric-keywords nil)
  (setq cperl-info-on-command-no-prompt t)
  (setq cperl-clobber-lisp-bindings t)
  ;; zeige cperl help nach einer gewissen zeit
  (setq cperl-lazy-help-time 3)

  ;; if you want all the bells and whistles
  (setq cperl-hairy)

  (set-face-background 'cperl-array-face nil)
  (set-face-background 'cperl-hash-face nil)
  (setq cperl-invalid-face nil)
  (font-lock-comment-annotations))

(setq prelude-cperl-mode-hook 'prelude-cperl-mode-defaults)

(add-hook 'cperl-mode-hook (lambda ()
                             (run-hooks 'prelude-cperl-mode-hook)) t)

; line length
(require 'whitespace)
(setq whitespace-style
		'(face lines-tail))
(setq whitespace-line-column 80)
(setq whitespace-display-mappings
		'((space-mark 32 [183] [46])
		  (newline-mark 10 [182 10])
		  (tab-mark 9 [9655 9] [92 9])
		 ))
;global:
;(setq global-whitespace-mode t)
;local:
(add-hook 'cperl-mode-hook 'whitespace-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; general programming ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun font-lock-comment-annotations ()
  "Highlight a bunch of well known comment annotations.

This functions should be added to the hooks of major modes for programming."
  (font-lock-add-keywords
   nil '(("\\<\\(\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):\\)"
          1 font-lock-warning-face t))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; other cool features ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Window switching. (C-x o goes to the next window)
(global-set-key (kbd "C-x O") (lambda ()
                                (interactive)
                                (other-window -1))) ;; back one

;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)

;; Start a new eshell even if one is active.
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))

;; kill lines backward
(global-set-key (kbd "C-<backspace>") (lambda ()
                                        (interactive)
                                        (kill-line 0)
                                        (indent-according-to-mode)))

;; replace buffer-menu with ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; enable some really cool extensions like C-x C-j(dired-jump)
(require 'dired-x)

;; ediff - don't start another frame
(require 'ediff)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; clean up obsolete buffers automatically
(require 'midnight)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;; Line Numbering ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(line-number-mode 1)
(column-number-mode 1)
(global-linum-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;; Toolbar/Menubar/... ;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;; Minibuffer ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ido)
(ido-mode 1)
;(ido-enable-flex-matching t)
(fset 'yes-or-no-p 'y-or-n-p)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;; Window tiling ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Split & Resize
(define-key global-map (kbd "C-x |") 'split-window-horizontally)
(define-key global-map (kbd "C-x _") 'split-window-vertically)
(define-key global-map (kbd "C-{") 'shrink-window-horizontally)
(define-key global-map (kbd "C-}") 'enlarge-window-horizontally)
(define-key global-map (kbd "C-^") 'enlarge-window)

;; Navigating: Windmove uses Shift-<up> etc.
(windmove-default-keybindings)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;; Text Input ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(show-paren-mode 1)
(delete-selection-mode 1)
(setq mouse-yank-at-point t
	  save-interprogram-paste-before-kill t
	  backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))
)
;;Enter
(define-key global-map (kbd "RET") 'newline-and-indent)

(global-set-key (kbd "M-/") 'hippie-expand)

;;; Tab Offsets
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
;; C
(setq-default c-basic-offset 4)
;; Javascript
(setq-default js2-basic-offset 4)
;; JSON
(setq-default js-indent-level 4)
;; Coffeescript
(setq coffee-tab-width 4)
;; Typescript
(setq typescript-indent-level 4 typescript-expr-indent-offset 4)
;; Python
(setq-default py-indent-offset 4)
;; XML
(setq-default nxml-child-indent 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;; Buffer Misc ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;; Color Theme ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/elisp/color-theme-6.6.0")
(require 'color-theme)
;(color-theme-initialize) needed ???
(add-to-list 'load-path "~/.emacs.d/elisp/emacs-color-theme-solarized")
(require 'color-theme-solarized)
(color-theme-solarized-dark)
; ** toggle day/night
(defun toggle-night-color-theme ()
  "Switch to/from night color scheme."
  (interactive)
  (require 'color-theme)
  (if (eq (frame-parameter (next-frame) 'background-mode) 'light)
      (color-theme-snapshot) ; restore default (light) colors
    ;; create the snapshot if necessary
    (when (not (commandp 'color-theme-snapshot))
      (fset 'color-theme-snapshot (color-theme-make-snapshot)))
    (color-theme-solarized-light)))
(global-set-key (kbd "<f11>") 'toggle-night-color-theme)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;; Org-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "DELEGATED(D)")))
(setq org-directory "~/org")
; do i want to see everything of a file?
;(setq org-startup-folded (quote showeverything))
; do i want some wrapping or truncating?
(setq org-startup-truncated nil)

;; Agenda
(define-key global-map "\C-ca" 'org-agenda)
(setq org-agenda-files (quote ("~/org")))
;;; Agenda GTD
(setq org-agenda-custom-commands (quote (("D" "Daily Action List" agenda "" ((org-agenda-ndays 1) (org-agenda-sorting-strategy (quote (time-up priority-down tag-up))) (org-deadline-warning-days 1))))))
;; calendar/diary mode in org zu integrieren ist wohl nicht so performant wie direkt in org-mode alles einzutragen
(setq org-agenda-include-diary nil)

(setq calendar-date-style "european")

;; Org Mode Caputer (Remember is deprecated but still the recent version in ubuntu)
(global-set-key "\C-cr" 'org-remember)
(setq org-remember-templates 
  '(("Todo" ?t "* TODO %?")
  ("Journal" ?j "** %^{Head Line} %U %^g\n%i%?" "~/journal.org")))
(eval-after-load 'remember
  '(add-hook 'remember-mode-hook 'org-remember-apply-template))
(setq org-default-notes-file (concat org-directory "/notes.org"))

(defun gtd ()
   (interactive)
   (find-file "~/org/inbox.org")
   (find-file "~/org/next-actions.org")
   (find-file "~/org/projekte.org")
   (find-file "~/org/calendar.org")
   (find-file "~/org/someday.org")
   (find-file "~/org/journal.org")
)

; org-remember
(define-key global-map "\C-cr" 'org-remember)
(setq org-default-notes-file (concat org-directory "/notes.org"))

(add-to-list 'load-path "~/.emacs.d/elisp")

;; Next Word vim-like
;; http://stackoverflow.com/questions/1771102/changing-emacs-forward-word-behaviour
(require 'misc)
(global-set-key "\M-p" '(lambda ()
  (interactive)
  (with-syntax-table my-vim-syntax-table (forward-word-to-beginning))))
(defun forward-word-to-beginning (&optional n)
  "Move point forward n words and place cursor at the beginning."
  (interactive "p")
  (let (myword)
    (setq myword
      (if (and transient-mark-mode mark-active)
        (buffer-substring-no-properties (region-beginning) (region-end))
        (thing-at-point 'symbol)))
    (if (not (eq myword nil))
      (forward-word n))
    (forward-word n)
    (backward-word n)))
(defvar my-vim-syntax-table
  (let ((table (make-syntax-table)))
  (modify-syntax-entry ?\( "$" table)
  (modify-syntax-entry ?\) "$" table)
  table))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;; Calendar Mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq calendar-week-start-day 1
      calendar-day-name-array ["Sonntag" "Montag" "Dienstag" "Mittwoch"
                               "Donnerstag" "Freitag" "Samstag"]
      calendar-month-name-array ["Januar" "Februar" "März" "April" "Mai"
                                 "Juni" "Juli" "August" "September"
                                 "Oktober" "November" "Dezember"])

(setq calendar-mark-holidays-flag t)
(setq calendar-mark-diary-entries t)
(setq diary-show-holidays-flag t)

(setq solar-n-hemi-seasons
      '("Frühlingsanfang" "Sommeranfang" "Herbstanfang" "Winteranfang"))

(setq holiday-general-holidays
      '((holiday-fixed 1 1 "Neujahr")
        (holiday-fixed 5 1 "1. Mai")
        (holiday-fixed 10 3 "Tag der Deutschen Einheit")))

;; Feiertage für Bayern, weitere auskommentiert
(setq holiday-christian-holidays
      '((holiday-float 12 0 -4 "1. Advent" 24)
        (holiday-float 12 0 -3 "2. Advent" 24)
        (holiday-float 12 0 -2 "3. Advent" 24)
        (holiday-float 12 0 -1 "4. Advent" 24)
        (holiday-fixed 12 25 "1. Weihnachtstag")
        (holiday-fixed 12 26 "2. Weihnachtstag")
        (holiday-fixed 1 6 "Heilige Drei Könige")
        (holiday-easter-etc -48 "Rosenmontag")
        ;; (holiday-easter-etc -3 "Gründonnerstag")
        (holiday-easter-etc  -2 "Karfreitag")
        (holiday-easter-etc   0 "Ostersonntag")
        (holiday-easter-etc  +1 "Ostermontag")
        (holiday-easter-etc +39 "Christi Himmelfahrt")
        (holiday-easter-etc +49 "Pfingstsonntag")
        (holiday-easter-etc +50 "Pfingstmontag")
        (holiday-easter-etc +60 "Fronleichnam")
        (holiday-fixed 8 15 "Mariae Himmelfahrt")
        (holiday-fixed 11 1 "Allerheiligen")
        ;; (holiday-float 11 3 1 "Buss- und Bettag" 16)
        (holiday-float 11 0 1 "Totensonntag" 20)))

(setq holiday-hebrew-holidays nil)
(setq holiday-islamic-holidays nil)
(setq holiday-bahai-holidays nil)
(setq holiday-local-holidays nil)
(setq holiday-oriental-holidays nil)
(setq holiday-other-holidays nil)
(setq holiday-solar-holidays nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MELPA ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(require 'package)
;(add-to-list 'package-archives
;  '("melpa" . "http://melpa.milkbox.net/packages/") t)
