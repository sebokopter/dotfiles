;; Window switching (C-x o) should also work backwards (C-x O)
(global-set-key (kbd "C-x O") (lambda ()
                                (interactive)
                                (other-window -1)))

;;; Window tiling
;; Split & Resize
(define-key global-map (kbd "C-x |") 'split-window-horizontally)
(define-key global-map (kbd "C-x _") 'split-window-vertically)
(define-key global-map (kbd "C-{") 'shrink-window-horizontally)
(define-key global-map (kbd "C-}") 'enlarge-window-horizontally)
(define-key global-map (kbd "C-^") 'enlarge-window)

;; Navigating: Windmove uses Shift-<up>, etc. by default
;(windmove-default-keybindings)
; change it to C-c-<up>, etc.
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

(defun my-other-window-kill-buffer ()
  "Kill the buffer in the other window"
  (interactive)
  ;; Window selection is used because point goes to a different window
  ;; if more than 2 windows are present
  (let ((win-curr (selected-window))
        (win-other (next-window)))
    (select-window win-other)
    (kill-this-buffer)
    (select-window win-curr)))

(global-set-key (kbd "C-x K") 'my-other-window-kill-buffer)

; track Emacs commands frequency
; keyfreq is loaded by packages.el
(use-package keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

;; Global Keybindings

(defvar my-global-keys-minor-mode-map (make-sparse-keymap)
  "global-keys-minor-mode keymap.")

(define-key my-global-keys-minor-mode-map (kbd "C-c C-r") 'revert-buffer)
(define-key my-global-keys-minor-mode-map (kbd "C-c n") 'my-new-empty-buffer)
(define-key my-global-keys-minor-mode-map (kbd "C-c C-n") 'my-new-empty-elisp-buffer)
(define-key my-global-keys-minor-mode-map (kbd "C-x K") 'my-kill-buffer-next-window)

(global-set-key (kbd "M-x") 'smex)
;; Font size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Window switching. (C-x o goes to the next window)
(global-set-key (kbd "C-x O")
		(lambda ()
		  (interactive)
		  (other-window -1))) ;; back one

;; replace buffer-menu with ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)


(define-minor-mode my-global-keys-minor-mode
  "A minor mode so that global key settings override annoying major modes."
  t " global-keys" 'my-global-keys-minor-mode-map)

(my-global-keys-minor-mode 1)

(defconst my-global-minor-mode-alist (list (cons 'my-global-keys-minor-mode
                                              my-global-keys-minor-mode-map)))

(setf emulation-mode-map-alists '(my-global-minor-mode-alist))

;; disable global keyingdings in mini-buffer
(defun my-minibuffer-setup-hook ()
  (my-global-keys-minor-mode 0))
(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

;; Own Functions

(defun my-new-empty-buffer ()
  "Open a new empty buffer."
  (interactive)
  (setq initial-major-mode 'text-mode)
  (let ((buf (generate-new-buffer "untitled")))
    (switch-to-buffer buf)
    (funcall (and initial-major-mode))
    (setq buffer-offer-save t)))
(defun my-new-empty-elisp-buffer ()
  "Open a new empty elisp-interacitve-mode buffer."
  (interactive)
  (setq initial-major-mode 'lisp-interaction-mode)
  (let ((buf (generate-new-buffer "untitled")))
    (switch-to-buffer buf)
    (funcall (and initial-major-mode))
    (setq buffer-offer-save t)))

(defun my-kill-buffer-next-window ()
  "Kill the buffer in the next window"
  (interactive)
  ;; Window selection is used because point stays otherwise in the "other" window
  (let ((win-curr (selected-window))
        (win-other (next-window)))
    (select-window win-other)
    (kill-this-buffer)
    (select-window win-curr)))

(defun my-c-mode-common-defaults ()
  (setq c-default-style "k&r"
        c-basic-offset 4)
  (c-set-offset 'substatement-open 0))


(provide 'init-kbd-shortcuts)
