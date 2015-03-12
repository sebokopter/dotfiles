(use-package ido)
(ido-mode +1)

;; REMEMBER: C-j if you want to avoid [confirm] question after typing non-existing name

;; ido-enable-flex-matching helps to not have to write complete name (characters in between can be missing)
(setq-default ido-enable-flex-matching t)
(setq-default ido-save-directory-list-file (expand-file-name ".ido.last" my-cache-user-emacs-directory))
(setq-default ido-default-file-method 'selected-window)
(setq-default ido-max-prospects 10)



(provide 'init-ido)
