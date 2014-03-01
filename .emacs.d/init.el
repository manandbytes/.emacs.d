(server-start)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

; yes-or-no -> y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

;; integrate vcsh and magit
;; - open directory '/vcsh:<repo>:.'
;; - M-x magit-status
(eval-after-load "tramp"
  '(add-to-list 'tramp-methods '("vcsh"
                                 (tramp-login-program "vcsh")
                                 (tramp-login-args
                                  (("enter")
                                   ("%h")))
                                 (tramp-remote-shell "/bin/sh")
                                 (tramp-remote-shell-args
                                  ("-c"))))
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backups/"))))
 '(delete-by-moving-to-trash t)
 '(url-proxy-services
   (quote
    (("no_proxy" . "\\(localhost\\|127\\.0\\.0\\.0/8\\|::1\\)")
     ("http" . "127.0.0.1:3128"))))
 '(vc-make-backup-files t)
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
