(use-package smex :ensure t)

(setq smex-save-file (expand-file-name ".smex-items" my-cache-user-emacs-directory))
(smex-initialize)

(provide 'init-smex)
