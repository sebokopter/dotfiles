(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "DELEGATED(D)")))
(setq org-directory "~/org")
; do i want to see everything of a file?
;(setq org-startup-folded (quote showeverything))
; do i want some wrapping or truncating?
(setq org-startup-truncated nil)

;; Agenda
(define-key global-map "\C-ca" 'org-agenda)
(setq org-agenda-files (quote ("~/org/next-actions")))
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
   (find-file "~/org/today.org")
   (find-file "~/org/journal.org")
   (switch-to-buffer "today.org")
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

(provide 'init-org)
