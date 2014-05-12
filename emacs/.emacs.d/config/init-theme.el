(add-hook 'after-init-hook 'theme-after-init-hook)
(defun theme-after-init-hook ()
  ;; alternative initialisation with package-initialize
  ;(package-initialize)
  ;; emacs23 variante
  ;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
  (load-theme 'solarized-dark t)
  (setq dark-or-light 'solarized-dark)

  (defun toggle-night-color-theme ()
   "Switch to/from night color scheme."
    (interactive)
    (if (eq dark-or-light 'solarized-light)
  		(setq dark-or-light 'solarized-dark)
  		(setq dark-or-light 'solarized-light))
    (load-theme dark-or-light t))

  (define-key global-map (kbd "<f11>") 'toggle-night-color-theme)
)

(provide 'init-theme)
