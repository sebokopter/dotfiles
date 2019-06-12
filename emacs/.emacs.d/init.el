
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path (concat user-emacs-directory "config"))
; system features
(require 'cl)
; my features
;; init-packages to be loaded first to be sure there are no dependencies
;; because it could be invoked via package-initialize
(require 'init-packages)
(require 'init-kbd-shortcuts)
(require 'init-ediff)
(require 'init-midnight)
(require 'init-multiple-cursors)
(require 'init-auto-mode)
(require 'init-misc)
(require 'init-smex)
(require 'init-ido)
(require 'init-theme)
(require 'init-perl)
(require 'init-programming)
(require 'init-c)
(require 'init-numbers)
(require 'init-bars)
(require 'init-desktop)
(require 'init-tabbar)
(require 'init-minibuffer)
; dired-x has to be loaded after ido (init-minibuffer)
(require 'init-dired)
(require 'init-saveplace)
(require 'init-recentf)
(require 'init-bookmark)
(require 'init-org)
(require 'init-server)
;(require 'init-company)
;(require 'init-auctex)
;(require 'init-git)
(require 'init-custom)

; don't forget to recompile after changes
(defun byte-recompile ()
  (interactive)
  (byte-recompile-directory "~/.emacs.d/config" 0))

