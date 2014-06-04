(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
;; emacs loads package.el packages/features/functions at the end of init file initalization
;; therefore you could force load now. but better use after-init-hook
;; see http://stackoverflow.com/a/18783152/1128373

;(package-initialize)
;(setq package-enable-at-startup nil)

; shamelessly stolen from: http://stackoverflow.com/a/10102154/1128373
(package-initialize)
;(setq url-httqp-attempt-keepalives nil)

(defvar init-packages
  '(dired+ helm midnight multiple-cursors)
  "A list of packages to ensure are installed at launch.")

(defun is-package-installed (p)
  "Ensure PACKAGE is installed."
  (cond ((package-installed-p p) t)
     (t nil)))

(defun installed-packages ()
  "Ensure all PACKAGES are installed."
  (mapcar 'is-package-installed init-packages))

(defun install-missing-packages ()
  (interactive)
  (unless (every 'identity (installed-packages))
    ;; check for new packages
    (message "%s" "Emacs is now refreshing its package database...")
    (package-refresh-contents)
    (message "%s" " done. ")
    ;; install the missing packages
    (dolist (package init-packages)
      (when (not (package-installed-p package))
        (package-install package)))))

(install-missing-packages)

(provide 'init-packages)
