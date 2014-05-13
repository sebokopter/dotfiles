; show line length with whitespace mode
(require 'whitespace)
(setq whitespace-style
		'(face lines-tail))
(setq whitespace-line-column 80)
(setq whitespace-display-mappings
		'((space-mark 32 [183] [46])
		  (newline-mark 10 [182 10])
		  (tab-mark 9 [9655 9] [92 9])
		 ))
; global would be:
;(setq global-whitespace-mode t)
; but we set it local in the corresponding prgramming languages init files
; e.g. (add-hook 'cperl-mode-hook 'whitespace-mode)

(defun font-lock-comment-annotations ()
 "Highlight a bunch of well known comment annotations.

This functions should be added to the hooks of major modes for programming."
  (font-lock-add-keywords
   nil '(("\\<\\(\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):\\)"
          1 font-lock-warning-face t))))

(show-paren-mode 1)
(setq show-paren-delay 0)
(delete-selection-mode 1)
(setq mouse-yank-at-point t
	  save-interprogram-paste-before-kill t
	  backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))
)
;;Enter
(define-key global-map (kbd "RET") 'newline-and-indent)

(global-set-key (kbd "M-/") 'hippie-expand)

;;; Tab Offsets
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;;;;; mode-compile  ;;;;;
;; installed with `package-install mode-compile`
;; following instructions copied from mode-compile.el
(autoload 'mode-compile "mode-compile"
"Command to compile current buffer file based on the major mode" t)
;(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
"Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)
(global-set-key "\C-cc" 'mode-compile)

;; The default length of the compilation window
(setq compilation-window-height 24)
;; On compilation, don't ask for command
(setq compilation-read-command t)

;; Name compilation buffer after the buffer name
;(setq compilation-buffer-name-function 
;      (lambda (mode) (concat "*" (downcase mode) ": " (buffer-name) "*")))

;; create compile window but prevent it from showing up
;(defadvice compile (around compile/save-window-excursion first () activate)
;  (save-window-excursion ad-do-it))

;; Helper for compilation. Close the compilation window if there was no error at all.
(setq compilation-exit-message-function
       (lambda (status code msg)
         ;; If M-x compile exists with a 0
         (when (and (eq status 'exit) (zerop code))
           ;; then optionally bury the *compilation* buffer, so that C-x b doesn't go there
; 	  (bury-buffer "*compilation*")
    ;; and delete the *compilation* window
    (delete-window (get-buffer-window (get-buffer "*compilation*"))))
    ;; Always return the anticipated result of compilation-exit-message-function
 	(cons msg code)))


;; on the fly syntax check
(flymake-mode 1)

(provide 'init-programming)