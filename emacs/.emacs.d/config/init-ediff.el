;; ediff - don't start another frame
(use-package ediff
  :ensure t)
(setq-default ediff-window-setup-function 'ediff-setup-windows-plain)

(provide 'init-ediff)
