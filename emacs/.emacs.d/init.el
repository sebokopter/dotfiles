(add-to-list 'load-path (concat user-emacs-directory "config"))
; system features
(require 'cl)
; my features
;; init-packages to be loaded first to be sure there are no dependencies
;; because it could be invoked via package-initialize
(require 'init-packages)
(require 'init-misc)
(require 'init-kbd-shortcuts)
(require 'init-dired)
(require 'init-theme)
(require 'init-perl)
(require 'init-programming)
(require 'init-numbers)
(require 'init-bars)
(require 'init-minibuffer)
(require 'init-saveplace)
(require 'init-recentf)
(require 'init-bookmark)
(require 'init-org)
(require 'init-flyspell)
;(require 'init-company)
;(require 'init-auctex)
;(require 'init-git)
