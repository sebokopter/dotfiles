(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "DELEGATED(D)")))
(setq org-todo-keyword-faces
      (quote (("INBOX" :foreground "#002b36" :background "red" :weight bold)
              ("INCUBATE" :foreground "#002b36" :background "orange red" :weight bold)
              ("TODO" :foreground "red" :weight bold)
              ("STARTED" :foreground "gold" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("PROJECT" :foreground "indian red" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("DELEGATED" :foreground "yellow green" :weight bold))))

(setq org-directory "~/org")
; do i want to see everything of a file?
;(setq org-startup-folded (quote showeverything))
; do i want some wrapping or truncating?
(setq org-startup-truncated nil)

;; Agenda
(define-key global-map "\C-ca" 'org-agenda)
(setq org-agenda-files (quote ("~/org/next-actions.org")))
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
   (find-file "~/org/someday.org")
   (find-file "~/org/today.org")
   (find-file "~/org/journal.org")
   (switch-to-buffer "today.org")
)

; org-remember
(define-key global-map "\C-cr" 'org-remember)
(setq org-default-notes-file (concat org-directory "/notes.org"))

(add-to-list 'load-path "~/.emacs.d/elisp")

; org-iswitchb
(global-set-key "\C-cb" 'org-iswitchb)

; org-export
;; remove Date, Author, Org Version footer from HTML-export
(setq org-export-html-postamble nil)

; org-pomodoro
(global-set-key (kbd "C-c p") 'org-pomodoro)

(provide 'init-org)
