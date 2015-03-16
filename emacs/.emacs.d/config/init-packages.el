(require 'package)
(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
;;                         ("gnu" . "http://elpa.gnu.org/packages/")
;;                         ("org" . "http://orgmode.org/elpa/")
;;                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ))
(package-initialize)

(unless (package-installed-p 'use-package)
    (package-install 'use-package))
(setq use-package-verbose t)
(require 'use-package)

(provide 'init-packages)
