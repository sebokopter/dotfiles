;;; interactivly do things
(ido-mode 1)
;;; enabled flex-matching instead of default fuzzy matching?
;(ido-enable-flex-matching t)

;;; shorten yes or no answers to y or n
(fset 'yes-or-no-p 'y-or-n-p)


(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; TODO: try out fancy-narrow
;(add-to-list 'load-path "~/.emacs.d/elisp/fancy-narrow")
;(require 'fancy-narrow)
;(fancy-narrow-mode 1)

(provide 'init-minibuffer)
