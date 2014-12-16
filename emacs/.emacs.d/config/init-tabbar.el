(tabbar-mode 1)
(global-set-key "\M-n" 'tabbar-forward)
(global-set-key "\M-p" 'tabbar-backward)
(set-face-attribute
 'tabbar-button nil
 :foreground "dark gray"
 :box '(:line-width 1 :color "gray72" :style released-button))

(provide 'init-tabbar)
