; dired-x has some really cool extensions like C-x C-j (dired-jump)
(require 'dired-x)

; open next directory/file in same buffer
(put 'dired-find-alternate-file 'disabled nil)

(provide 'init-dired)
