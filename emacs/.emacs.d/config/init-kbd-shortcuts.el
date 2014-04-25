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

;; Navigating: Windmove uses Shift-<up> etc.
(windmove-default-keybindings)


(provide 'init-kbd-shortcuts)
