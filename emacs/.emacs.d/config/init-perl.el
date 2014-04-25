;;; cperl-mode is preferred to perl-mode                                        
(defalias 'perl-mode 'cperl-mode)
(add-to-list 'auto-mode-alist '("\\.\\([pP]\\([Llm]\\|[oO][dD]\\)\\|al+\\|t\\|manuscript\\)\\'" . perl-mode))

;;; some default values for cperl. adapted from prelude.
(defun some-cperl-mode-defaults ()
  (setq cperl-indent-level 4)
  (setq cperl-continued-statement-offset 8)
  ;; cperl-hairy affects all those variables, but I prefer
  ;; a more fine-grained approach as far as they are concerned
  (setq cperl-font-lock t)
  (setq cperl-electric-lbrace-space t)
  (setq cperl-electric-parens nil)
  (setq cperl-electric-linefeed nil)
  ;; expand perl keywords (like foreach, while, ...)
  (setq cperl-electric-keywords t)
  (setq cperl-info-on-command-no-prompt t)
  (setq cperl-clobber-lisp-bindings t)
  ;; zeige cperl help nach einer gewissen zeit
  (setq cperl-lazy-help-time 3)

  ;; if you want all the bells and whistles
  (setq cperl-hairy t)

  ;; to make cperl always highlight scalar variables
  (setq cperl-highlight-variables-indiscriminately t)

  ;; array and hash syntax highlighting default is to bright therefore we change it
;  (set-face-background 'cperl-array-face nil)
;  (set-face-foreground 'cperl-array-face "blue")
;  (set-face-background 'cperl-hash-face nil)
  ;; disable higlighting trailing whitespaces (with underscore)
  (setq cperl-invalid-face nil)
  (font-lock-comment-annotations))

(setq some-cperl-mode-hook 'some-cperl-mode-defaults)
(add-hook 'cperl-mode-hook (lambda ()
                             (run-hooks 'some-cperl-mode-hook)) t)
(add-hook 'cperl-mode-hook 'whitespace-mode)

(provide 'init-perl)
