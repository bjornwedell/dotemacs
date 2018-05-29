(use-package color-theme-sanityinc-tomorrow
  :ensure t

  :init
  (load-theme 'sanityinc-tomorrow-night t)

  :config
  (let ((bg "#1d1f21")
	(fg "#c5c8c6")
	(selection "#373b41")
	(comment "#969896")
	(red "#cc6666")
	(full-red "#ff0000")
	(yellow "#f0c674")
	(green "#b5bd68")
	(full-green "#00ff00"))

    ;; fringe
    (set-face-attribute 'fringe nil :background bg)
    (set-face-attribute 'git-gutter-fr:modified nil :background bg :foreground yellow)
    (set-face-attribute 'git-gutter-fr:added nil :background bg :foreground green)
    (set-face-attribute 'git-gutter-fr:deleted nil :background bg :foreground red)

    ;; whitespace
    (set-face-attribute 'trailing-whitespace nil :background bg :foreground red :underline t)

    ;; paren
    (set-face-attribute 'show-paren-match nil :background bg :foreground full-green :bold t)
    (set-face-attribute 'show-paren-mismatch nil :background bg :foreground full-red :bold t)

    ;; mode line
    (set-face-attribute 'mode-line nil :box `(:line-width 1 :color ,selection))
    (set-face-attribute 'mode-line-inactive nil :box `(:line-width 1 :color ,selection) :background bg)

    ;; line number mode
    (set-face-attribute 'line-number nil :background bg :foreground selection)
    (set-face-attribute 'line-number-current-line nil :background bg :foreground fg)

    ;; cursor
    (set-cursor-color fg)))
