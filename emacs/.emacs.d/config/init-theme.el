(load-theme 'solarized-dark t)

; ** toggle dark/light (aka day/night) solarized theme
(defun toggle-night-color-theme ()
  "Switch to/from night color scheme."
  (interactive)
  (require 'color-theme)
  (if (eq (frame-parameter (next-frame) 'background-mode) 'light)
      (color-theme-snapshot) ; restore default (light) colors
    ;; create the snapshot if necessary
    (when (not (commandp 'color-theme-snapshot))
      (fset 'color-theme-snapshot (color-theme-make-snapshot)))
    (color-theme-solarized-light)))
(global-set-key (kbd "<f11>") 'toggle-night-color-theme)

(provide 'init-theme)
