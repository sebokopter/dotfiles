; no startup message
(setq inhibit-startup-message t)

; use system font
(setq font-use-system-font t)

;; ediff - don't start another frame
(require 'ediff)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; clean up obsolete buffers automatically
(require 'midnight)

(provide 'init-misc)
