;; compilation breaks defmacro autoloads
(require 'org)
(org-babel-load-file
 (expand-file-name "emacs.org" user-emacs-directory) nil)
