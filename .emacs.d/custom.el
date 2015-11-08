(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark tango)))
 '(delete-by-moving-to-trash t)
 '(european-calendar-style t)
 '(org-agenda-custom-commands
   (quote
    (("r" tags-todo "REFILE" nil)
     ("W" "Weekly review"
      ((agenda ""
	       ((org-agenda-ndays 7)))
       (stuck "")
       (tags "PROJECT")
       (todo "SOMEDAY")
       (todo "WAITING"))
      "" nil)
     ("p" tags "+PROJECT"
      ((org-use-tag-inheritance nil)
       (org-agenda-sorting-strategy
	(quote
	 (todo-state-up)))))
     ("u" "Unscheduled tasks" tags-todo ""
      ((org-agenda-skip-function
	(quote
	 (org-agenda-skip-entry-if
	  (quote scheduled)
	  (quote deadline))))
       (org-agenda-tag-filter-preset
	(quote
	 ("-PROJECT" "-REFILE"))))))))
 '(org-clock-into-drawer 1)
 '(org-enforce-todo-checkbox-dependencies t)
 '(org-enforce-todo-dependencies t)
 '(org-log-into-drawer "LOGBOOK")
 '(org-refile-targets
   (quote
    ((org-agenda-files :tag . "PROJECT")
     (org-agenda-files :maxlevel . 2))))
 '(org-stuck-projects (quote ("+PROJECT/-DONE-CANCELED" ("NEXT") nil)))
 '(org-todo-keywords
   (quote
    ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(x)")
     (sequence "WAITING(w)" "SOMEDAY(s)" "|" "CANCELED(c)"))))
 '(org-use-fast-todo-selection (quote prefix))
 '(vc-make-backup-files t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-done ((t (:strike-through t))))
 '(org-headline-done ((t (:strike-through t)))))
