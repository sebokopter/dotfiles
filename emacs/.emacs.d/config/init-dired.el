; disable if using ido: dired-x doesn't play nicely with ido's dired :-(
(use-package dired-x)
(add-hook 'after-init-hook 'dired-after-init-hook)
(defun dired-after-init-hook ()
  (use-package dired+)
  ; open directories in same buffer
  (toggle-diredp-find-file-reuse-dir 1)
  ; don't use maximum-decoration. greater number eq more font-decoration
  (setq font-lock-maximum-decoration 1)
)

(autoload 'dired-jump "dired"
  "Jump to Dired buffer corresponding to current buffer." t)

(autoload 'dired-jump-other-window "dired"
  "Like \\[dired-jump] (dired-jump) but in other window." t)

(define-key global-map "\C-x\C-j" 'dired-jump)
(define-key global-map "\C-x4\C-j" 'dired-jump-other-window)

(provide 'init-dired)
