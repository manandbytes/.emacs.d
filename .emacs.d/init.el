; yes-or-no -> y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

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

(add-to-list 'load-path "~/.emacs.d/lisp/")

; disable menu bar and tool bar
(menu-bar-mode -1)
(tool-bar-mode -1)

(eval-after-load "tramp"
  '(progn
     (defun mn-sudo-mode-line-function ()
       (when (string-match "^/su\\(do\\)?:" default-directory)
         (setq mode-line-format
               (format-mode-line mode-line-format
                                 'font-lock-warning-face))))

     (defvar sudo-tramp-prefix
       "/sudo:"
       (concat "Prefix to be used by sudo commands when building tramp path "))

     (defun sudo-file-name (filename)
       (set 'splitname (split-string filename ":"))
       (if (> (length splitname) 1)
           (progn (set 'final-split (cdr splitname))
                  (set 'sudo-tramp-prefix "/sudo:"))
         (progn (set 'final-split splitname)
                (set 'sudo-tramp-prefix (concat sudo-tramp-prefix "root@localhost:"))))
       (set 'final-fn (concat sudo-tramp-prefix (mapconcat (lambda (e) e) final-split ":")))
       (message "splitname is %s" splitname)
       (message "sudo-tramp-prefix is %s" sudo-tramp-prefix)
       (message "final-split is %s" final-split)
       (message "final-fn is %s" final-fn)
       (message "%s" final-fn))

     (defun sudo-reopen-file ()
       "Reopen file as root by prefixing its name with sudo-tramp-prefix and by clearing buffer-read-only"
       (interactive)
       (let*
           ((file-name (expand-file-name buffer-file-name))
            (sudo-name (sudo-file-name file-name)))
         (progn
           (setq buffer-file-name sudo-name)
           (rename-buffer sudo-name)
           (setq buffer-read-only nil)
           (message (concat "File name set to " sudo-name)))))

     (add-hook 'find-file-hooks 'mn-sudo-mode-line-function)
     (add-hook 'dired-mode-hook 'mn-sudo-mode-line-function)
     )
  )

;; integrate vcsh and magit
;; - open directory '/vcsh:<repo>:.'
;; - M-x magit-status
(eval-after-load "tramp"
  '(progn
     (add-to-list 'tramp-methods '("vcsh"
                                   (tramp-login-program "vcsh")
                                   (tramp-login-args
                                    (("enter")
                                     ("%h")))
                                   (tramp-remote-shell "/bin/sh")
                                   (tramp-remote-shell-args
                                    ("-c"))))

     (defun tramp-parse-vcsh (_ignore)
       "List all repositories"
       (mapcar (lambda (x) (list nil x)) (split-string (shell-command-to-string "vcsh list"))))
     (tramp-set-completion-function "vcsh" '((tramp-parse-vcsh "")))
     )
  )

; edit html files with nxml-mode
(add-to-list 'auto-mode-alist '("\\.html$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.htm$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xhtml$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xhtm$" . nxml-mode))

;; use markdown mode for *.md files
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))

;; Gemfile is a Ruby file
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

;; Puppet files
(add-to-list 'auto-mode-alist '("Puppetfile$" . puppet-mode))
(add-hook 'puppet-mode-hook 'flymake-puppet-load)

;; Killing lines, inspired by http://xahlee.org/emacs/emacs_delete_whole_line.html
;; - kill the rest of the current line, C-k by default
;; - kill the whole line including its terminating newline, C-S-k
(global-set-key (kbd "C-S-k") 'kill-whole-line)

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
