(setq-default
 mode-line-format
 '(
   ;; point position
   (8
    (:propertize " %l:" face font-lock-string-face)
    (:eval (propertize "%c" 'face (if (>= (current-column) 80)
                                      'font-lock-warning-face
                                    'font-lock-string-face))))

   ;; major modes
   ;; not interested in minor modes
   ;; (can always be listed with C-h m)
   (:propertize "%m: " face font-lock-variable-name-face
                help-echo buffer-file-coding-system)

   ;; shortened directory (if buffer have a corresponding file)
   (:eval
    (when (buffer-file-name)
      (propertize (shorten-directory default-directory 35)
                  'face 'font-lock-comment-face)))

   ;; buffer name
   (:propertize "%b" face font-lock-doc-face)

   ;; right aligned stuff
   (:eval
    (let* ((status-offset 2)
           (nyan-offset
            (+ status-offset (if nyan-mode (+ 2 nyan-bar-length) 0))))

      (concat

       ;; nyan-cat
       (when nyan-mode
         (concat
          (propertize " " 'display `(space :align-to (- right ,nyan-offset)))
          (propertize "|" 'face 'vertical-border)
          (nyan-create)
          (propertize "|" 'face 'vertical-border)))

       ;; read-only / changed
       (propertize " " 'display `(space :align-to (- right ,status-offset)))
       (cond (buffer-read-only
              (propertize "RO" 'face 'eshell-prompt))
             ((buffer-modified-p)
              (propertize "* " 'face 'eshell-prompt))
             (t "  ")))))))

(defun special-buffer-p (buffer-name)
  "Check if buffer-name is the name of a special buffer."
  (or (string-match-p "^\\*.+\\*$" buffer-name)
      ;; workaround for magit's 'trailing asterisk' problem
      ;; https://github.com/magit/magit/issues/2334
      (string-match-p "^\\*magit.*:.+$" buffer-name)))

;; helper function
;; stolen from: http://amitp.blogspot.se/2011/08/emacs-custom-mode-line.html
(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat ".../" output)))
    output))
