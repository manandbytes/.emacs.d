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

;; local recipes or advices to existing ones
(setq el-get-sources
      '(el-get
        (:name smex ;; a smart M-x enhancement
               :after (progn
                        (global-set-key (kbd "M-x") 'smex)
                        (global-set-key (kbd "M-X") 'smex-major-mode-commands)
                        (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;; an old M-x
                        ))
        (:name magit
               :after (progn
                        (global-set-key (kbd "C-x C-z") 'magit-status)))
        (:name org-mode
               :after (progn
                        ;; http://orgmode.org/manual/Clocking-work-time.html
                        (setq org-clock-persist t)
                        (org-clock-persistence-insinuate)

                        (global-set-key (kbd "C-c a") 'org-agenda)
                        (global-set-key (kbd "C-c r") 'org-capture) ;; capture with C-c r
                        (global-set-key (kbd "C-c .") 'org-time-stamp) ;; insert timestamp everywhere with 'C-c .'

                        ;; a link type to show debian's package info using apt-utils-mode
                        (when (require 'apt-utils nil 'noerror)
                          (require 'org)
                          (defun org-deb-open (package)
                            (apt-utils-show-package-1 package t nil))
                          (org-add-link-type "deb"
                                             'org-deb-open))))
        (:name crontab-mode
               :checksum f68206c1d10de68ba0685ce4cb14741c7ca7c648
               :after (progn
                        (add-to-list 'auto-mode-alist '("\\.cron\\(tab\\)?\\'" . crontab-mode))
                        (add-to-list 'auto-mode-alist '("cron\\(tab\\)?\\."    . crontab-mode))
                        )
               )

        (:name puppet-flymake :pkgname "grimradical/puppet-flymake" :type github)
        ))

(setq my:el-get-packages
      '(el-get
        command-frequency
        crontab-mode
        helm
        magit
        magit-view-file
        org-mode
        puppet-mode
        smex
        ))

(setq my:el-get-packages
      (append my:el-get-packages
              (mapcar #'el-get-source-name el-get-sources)))

(el-get 'sync my:el-get-packages)

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

;; enable SMerge, a minor mode to quickly navigate between conflicts and
;; choose which to keep, for files with conflict markers
(defun sm-try-smerge ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (when (re-search-forward "^<<<<<<< " nil t)
      (smerge-mode 1))))
;; smerge-mode will be enabled for files which contain conflict markers
(add-hook 'find-file-hook 'sm-try-smerge t)

; edit html files with nxml-mode
(add-to-list 'auto-mode-alist '("\\.html$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.htm$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xhtml$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xhtm$" . nxml-mode))

;; Maven POM files
(add-to-list 'auto-mode-alist '("\\pom.xml$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\pom-*.xml$" . nxml-mode))

;; Eclipse's project files
(add-to-list 'auto-mode-alist '("\\.project$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.classpath$" . nxml-mode))

; Java deployable artifacts
(add-to-list 'auto-mode-alist '("\\.jar$" . archive-mode))
(add-to-list 'auto-mode-alist '("\\.war$" . archive-mode))
(add-to-list 'auto-mode-alist '("\\.ear$" . archive-mode))
(add-to-list 'auto-mode-alist '("\\.sar$" . archive-mode))
;; BeanShell files
(add-to-list 'auto-mode-alist '("\\.bsh$" . java-mode))
;; AspectJ files
(add-to-list 'auto-mode-alist '("\\.aj$" . java-mode))

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
 '(custom-enabled-themes (quote (tango-dark tango)))
 '(delete-by-moving-to-trash t)
 '(european-calendar-style t)
 '(url-proxy-services
   (quote
    (("no_proxy" . "\\(localhost\\|127\\.0\\.0\\.0/8\\|::1\\)")
     ("http" . "127.0.0.1:3128"))))
 '(org-agenda-custom-commands (quote (("r" tags-todo "REFILE" nil))))
 '(org-agenda-start-on-weekday nil)
 '(org-link-abbrev-alist (quote (("github" . "https://github.com/%s"))))
 '(vc-make-backup-files t)
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
