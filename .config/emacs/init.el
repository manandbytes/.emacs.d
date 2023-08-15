;; -*- lexical-binding: t -*-
(package-initialize)

(require 'org)
;; compilation breaks defmacro autoloads
(org-babel-load-file
 (expand-file-name "emacs.org" user-emacs-directory) nil)
