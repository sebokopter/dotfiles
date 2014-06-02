(load "server")
(unless (server-running-p) (server-start))
; remove those annoying "Buffer ... still has clients; kill it?" messages
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)
(provide 'init-server)
