; no startup message
(setq-default inhibit-startup-message t)

; use system font
(setq-default font-use-system-font t)

; ediff - don't start another frame
(require 'ediff)
(setq-default ediff-window-setup-function 'ediff-setup-windows-plain)

; clean up obsolete buffers automatically
(require 'midnight)

(add-hook 'after-init-hook 'misc-after-init-hook)
(defun misc-after-init-hook ()
  (require 'multiple-cursors)
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
)

(defun other-window-kill-buffer ()
  "Kill the buffer in the other window"
  (interactive)
  ;; Window selection is used because point goes to a different window
  ;; if more than 2 windows are present
  (let ((win-curr (selected-window))
        (win-other (next-window)))
    (select-window win-other)
    (kill-this-buffer)
    (select-window win-curr)))

(global-set-key (kbd "C-x K") 'other-window-kill-buffer)

; for gitit wiki pages which are written in markdown
(add-to-list 'auto-mode-alist '(".page" . markdown-mode))

; track Emacs commands frequency
; keyfreq is loaded by packages.el
(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

(provide 'init-misc)
