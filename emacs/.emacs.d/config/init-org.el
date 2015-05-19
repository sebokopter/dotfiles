(setq org-todo-keywords '((sequence "INBOX(i)" "INCUBATE(I)" "|")
                          (sequence "TODO(t)" "WAITING(w)" "|")
                          (sequence "PROJECT(p)" "|")
                          (sequence "DELEGATED(D)" "DONE(d)")))
(setq org-todo-keyword-faces
      (quote (("INBOX" :background "red" :foreground "black" :weight bold)
              ("INCUBATE" :background "orange" :foreground "black" :weight bold)
              ("TODO" :foreground "red" :weight bold)
              ("PROJECT" :foreground "red" :weight bold)
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
   (find-file "~/org/todo.org")
   (switch-to-buffer "todo.org")
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
