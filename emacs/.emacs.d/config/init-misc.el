;; no startup message
(setq-default inhibit-startup-message t)

;; use system font
(setq-default font-use-system-font t)

;; cache directory for bookmarks, ido history, ...
(setq-default my-cache-user-emacs-directory (concat user-emacs-directory "cache"))

;; disable elisp *scratch* buffer and use empty buffer instead
(defun my-close-scratch ()
  (kill-buffer "*scratch*")
  (if (not (delq nil (mapcar 'buffer-file-name (buffer-list))))
      (my-new-empty-buffer)
    ))

(defun my-emacs-startup-hook ()
  (my-close-scratch))

(add-hook 'emacs-startup-hook 'my-emacs-startup-hook)

(provide 'init-misc)
