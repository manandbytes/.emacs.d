(message "🥱 Loading early-init.el")

;; (setq package-enable-at-startup nil
;;       use-package-verbose t)

(add-hook 'before-init-hook (lambda () (message "🪝 Before init")))
(add-hook 'after-init-hook (lambda () (message "🪝 After init")))
(add-hook 'emacs-startup-hook (lambda () (message "🪝 Emacs startup")))
(add-hook 'window-setup-hook (lambda () (message "🪝 Window setup")))

;; native compilation settings
(when (featurep 'native-compile)
  (require 'xdg)
  ;; set native compilation cache directory
  (let ((eln-cache-dir (expand-file-name "emacs/eln-cache/" (xdg-cache-home))))
    (if (fboundp 'startup-redirect-eln-cache)
	(startup-redirect-eln-cache eln-cache-dir)
      (add-to-list 'native-comp-eln-load-path eln-cache-dir))))
