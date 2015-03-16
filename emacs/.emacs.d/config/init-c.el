(defun my-c-mode-common-defaults ()
  (setq c-default-style "k&r"
        c-basic-offset 4)
  (c-set-offset 'substatement-open 0))
(setq my-c-mode-common-hook 'my-c-mode-common-defaults)
(add-hook 'c-mode-comon-hook (lambda ()
                               (run-hooks 'my-c-mode-common-hook)))
(provide 'init-c)
