(add-hook 'after-init-hook 'helm-after-init-hook)
(defun helm-after-init-hook ()
  (require 'helm)
  (helm-mode 1)
  (global-set-key (kbd "C-c h") 'helm-mini)
  (setq-default helm-split-window-in-side-p t)
;; on which side should helm be shown? (default: below)
;  (setq helm-split-window-default-side 'right)
  ;; C-x b normally is bound to switch-to-buffer but with helm enabled
  ;; the text input search tries also to complete the text from non-existing
  ;; buffers which is quite annoying
  (global-set-key (kbd "C-x b") 'helm-buffers-list)
)
(provide 'init-helm)
