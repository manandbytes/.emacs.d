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
 '(package-selected-packages
   '(adoc-mode ag all-the-icons-completion all-the-icons-dired
	       all-the-icons-gnus all-the-icons-nerd-fonts
	       android-mode annalist apache-mode artbollocks-mode
	       atomic-chrome auth-source-xoauth2-plugin
	       bash-completion beacon beancount benchmark-init bm
	       bpftrace-mode browse-kill-ring bug-hunter butler
	       buttercup cider clojure-mode-extra-font-locking
	       code-archive command-log-mode crdt csv csv-mode
	       cycle-quotes darkroom dashboard debase diff-hl diminish
	       dired-collapse dired-git-info dired-hist dired-narrow
	       dired-open dired-rsync dired-subtree diredfl docker
	       docker-compose-mode dockerfile-mode doom-modeline
	       doom-themes dpkg-dev-el easy-kill-extras edit-server
	       editorconfig ef-themes eglot-java elf-mode elfeed-org
	       elfeed-tube emacs-everywhere embark-org-roam es-mode
	       eshell-bookmark eshell-git-prompt eshell-prompt-extras
	       expand-region feather fira-code-mode flycheck-eglot
	       flycheck-ledger flycheck-package flycheck-plantuml
	       flycheck-pycheckers flycheck-pyflakes flymake-proselint
	       flymake-puppet flymake-shellcheck flymake-yamllint
	       fontaine frames-only-mode free-keys geiser git-modes
	       git-timemachine gitlab-ci-mode-flycheck gnosis
	       gnus-desktop-notify gnus-notes goto-chg graphql
	       graphql-ts-mode groovy-mode helm-ag helm-descbinds
	       helm-describe-modes helm-dictionary helm-jstack
	       helm-lsp helm-org-ql helm-org-rifle helm-projectile
	       helm-selector helm-wordnet helpful hierarchy initsplit
	       jenkins jq-ts-mode json-navigator json-snatcher keycast
	       keyfreq leaf ledger-mode lentic lf lin linum-relative
	       lispy llvm-ts-mode log4j-mode logito logview
	       lorem-ipsum lsp-focus lsp-java lsp-ui macrostep
	       major-mode-hydra marginalia markdown-toc marshal
	       mastodon memoize minimap minions mmm-mode modus-themes
	       moody move-text mpv multiple-cursors nano-agenda
	       nano-modeline nano-theme nhexl-mode nix-mode
	       nix-ts-mode nix-update nnreddit nntwitter nov ob-async
	       ob-chatgpt-shell ob-dall-e-shell ob-git-permalink
	       ob-graphql ob-prolog ob-restclient ob-tmux objed
	       olivetti org-ai org-autolist org-brain org-bullets
	       org-contrib org-drill org-edna org-mind-map org-modern
	       org-msg org-parser org-pomodoro org-present
	       org-projectile org-protocol-jekyll org-re-reveal
	       org-roam-ql-ql org-roam-ui org-sidebar org-timeline
	       org-tree-slide org-vcard org-web-tools orgalist orgbox
	       orgit-forge orglink osm outshine ox-asciidoc ox-gfm
	       ox-gist ox-jekyll-md ox-jira ox-pandoc ox-reveal
	       package-lint-flymake pandoc-mode paredit-everywhere
	       parent-mode pass pcap-mode pelican-mode
	       persistent-scratch pip-requirements pocket-lib poke
	       poke-mode popup powerline pretty-sha-path protobuf-mode
	       puppet-mode qrencode rainbow-identifiers rainbow-mode
	       req-package restclient-jq scratch shackle shell-here
	       shfmt shut-up skewer-mode smart-mode-line smartparens
	       spacious-padding spatial-navigate spray sudo-edit sway
	       sway-lang-mode sx systemd tmux-mode torrent-mode tramp
	       tramp-theme transmission treesit-auto tsc undo-tree
	       unicode-fonts use-package-chords use-package-el-get
	       use-package-ensure-system-package use-package-hydra
	       visual-regexp-steroids vlf w3m web-mode which-key
	       wordnut wrap-region writegood-mode writeroom-mode
	       ws-butler wttrin xclip xr yasnippet
	       youtube-sub-extractor ytdl))
 '(vc-make-backup-files t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-done ((t (:strike-through t))))
 '(org-headline-done ((t (:strike-through t)))))
