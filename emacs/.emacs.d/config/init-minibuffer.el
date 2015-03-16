;;; interactivly do things
;; helm is more powerful than ido
;(ido-mode 1)
;;; enabled flex-matching instead of default fuzzy matching?
;(ido-enable-flex-matching t)

;;; shorten yes or no answers to y or n
(fset 'yes-or-no-p 'y-or-n-p)

(use-package uniquify)
(setq uniquify-buffer-name-style 'post-forward)
(use-package ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
;; sort the ibuffer according to the following groups
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("bookmarks" (mode . bookmark-bmenu-mode))
               ("dired" (mode . dired-mode))
               ("perl" (mode . cperl-mode))
               ("c/c++" (or
                         (mode . c-mode)
                         (mode . c++-mode)
                         (mode . cmake-mode)))
               ("elisp" (mode . emacs-lisp-mode))
               ("org" (or
                       (name . "^\\*Calendar\\*$")
                       (mode . org-mode)))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")))))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

;; this should clean up dired and view-mode buffers after some time
(when (use-package tempbuf nil 'noerror)
  (add-hook 'dired+-mode-hook 'turn-on-tempbuf-mode)
  (add-hook 'view-mode-hook 'turn-on-tempbuf-mode)
)

;; TODO: try out fancy-narrow
;(add-to-list 'load-path "~/.emacs.d/elisp/fancy-narrow")
;(use-package 'fancy-narrow)
;(fancy-narrow-mode 1)

(provide 'init-minibuffer)
