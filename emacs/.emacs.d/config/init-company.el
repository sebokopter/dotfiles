; load company-mode for autocompletion
(add-to-list 'load-path "~/.emacs.d/elisp/company-mode")
(autoload 'company-mode "company" nil t)
(setq company-auto-complete t)
(setq company-auto-complete-chars '(41 46))
(setq company-idle-delay t)
(setq company-minimum-prefix-length 1)
(setq company-show-numbers t)
(setq company-global-modes
      '(not
        eshell-mode shell-mode term-mode terminal-mode))
(add-hook 'after-init-hook 'global-company-mode)

(provide 'init-company)
