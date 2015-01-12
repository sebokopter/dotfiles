(desktop-save-mode 1)

;; look here
(setq desktop-path '("~/.emacs.d/"))
;; save here
(setq desktop-dirname "~/.emacs.d/")
;; filename to write to/look for
(setq desktop-base-file-name "emacs-desktop")

(defun saved-session ()
  (file-exists-p (concat desktop-dirname "/" desktop-base-file-name)))

(provide 'init-desktop)
