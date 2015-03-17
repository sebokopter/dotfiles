(use-package saveplace
  :ensure t)
(setq save-place-file (concat user-emacs-directory ".cache/places"))
(setq-default save-place t)

(provide 'init-saveplace)
