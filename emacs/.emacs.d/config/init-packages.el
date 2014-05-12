(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
;; emacs loads package.el packages/features/functions at the end of init file initalization
;; therefore you could force load now. but better use after-init-hook
;; see http://stackoverflow.com/a/18783152/1128373

;(package-initialize)
;(setq package-enable-at-startup nil)

(provide 'init-packages)
