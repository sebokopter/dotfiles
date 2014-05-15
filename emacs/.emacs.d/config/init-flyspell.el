(dolist (hook '(lisp-mode-hook
                emacs-lisp-mode-hook
                ruby-mode-hook
                yaml-mode
                python-mode-hook
                shell-mode-hook
                php-mode-hook
                css-mode-hook
                haskell-mode-hook
                nxml-mode-hook
                perl-mode-hook
                cperl-mode-hook
                java-mode-hook
                c-mode-hook
                c++-mode-hook
                erlang-mode-hook))
  (add-hook hook 'flyspell-prog-mode))
; flyspell very annoying in org-mode
;(dolist (hook '(text-mode-hook
;                org-mode-hook))
;  (add-hook hook 'flyspell-mode))
; is text-mode-hook also invoked when running org-mode?
;(add-hook 'text-mode-hook 'flyspell-mode)

(let ((langs '("american" "deutsch8")))
  (setq lang-ring (make-ring (length langs)))
  (dolist (elem langs) (ring-insert lang-ring elem)))

(defun cycle-ispell-languages ()
  (interactive)
  (let ((lang (ring-ref lang-ring -1)))
    (ring-insert lang-ring lang)
    (ispell-change-dictionary lang)))

(global-set-key (kbd "<f8>") 'cycle-ispell-languages)

(provide 'init-flyspell)
