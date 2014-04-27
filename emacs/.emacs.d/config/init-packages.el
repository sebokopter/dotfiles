(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
; emacs calls 'packaage-initalize' functions after loading the init file therefore force load now
(setq package-enable-at-startup nil)
(package-initialize)

(provide 'init-packages)
