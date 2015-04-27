(add-hook 'after-init-hook 'my-mc-after-init-hook)
(defun my-mc-after-init-hook ()
  (use-package multiple-cursors
    :ensure t)
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
)

(provide 'init-multiple-cursors)