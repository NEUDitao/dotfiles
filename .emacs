

;; enables packages, melpa, etc...
(require 'package)

;; Org mode
(require 'org)


;;; Code:

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)


;; glboal linumbers/colums
(global-display-line-numbers-mode t)
(setq column-number-mode t)

;; uses the visual audio bell, so it stops that beeping
(setq visible-bell t)

(use-package racket-mode
  :ensure t)
(use-package flycheck
  :ensure t)
(use-package rainbow-delimiters
  :ensure t)
(use-package markdown-mode
  :ensure t)
(use-package hacker-typer
  :ensure t)
(use-package elpy
  :ensure t)
(use-package py-autopep8
  :ensure t)

(elpy-enable)
(require 'py-autopep8)
(add-hook 'elpy-mode'hook 'py-autopep8-enable-on-save)

;; stores all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Turns rainbow delimiter on in most programming modes
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Enables flycheck (the thing needed for pylint)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; enables flycheck when elpy is enabled
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))


;; basic configs...
(display-battery-mode 1)
(setq inhibit-startup-message t)

;; zoom w/ mouse
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)




;;; Org Mode:
;; --------------------------------------------------

;; org mode keywords
(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "WAITING" "|" "DONE" "CANCELED")))


;; sets the agenda files
(setq org-agenda-files '("~/Dropbox/org"))

;; Sets up org mode keys C-c l and C-c a, whic are for string links, and
;; accessing agenda mode
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; Default capture template
(setq org-capture-templates
      '(("a" "My TODO task format." entry
	 (file "todo.org")
	 "* TODO %?
SCHEDULED: %t")))

;; always get to agenda thru "C-c t a"
(defun air-pop-to-org-agenda (&optional split)
  "Visit the org agenda, in the current window or a SPLIT."
  (interactive "P")
  (org-agenda nil "d")
  (when (not split)
    (delete-other-windows)))

(define-key global-map (kbd "C-c t a") 'air-pop-to-org-agenda)

;; creates a simplified agenda view

(defun air-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (pri-value (* 1000 (- org-lowest-priority priority)))
        (pri-current (org-get-priority (thing-at-point 'line t))))
    (if (= pri-value pri-current)
        subtree-end
      nil)))

(defun air-org-skip-subtree-if-habit ()
  "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (string= (org-entry-get nil "STYLE") "habit")
        subtree-end
      nil)))

(setq org-agenda-custom-commands
      '(("d" "Daily agenda and all TODOs"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (agenda "" ((org-agenda-ndays 1)))
          (alltodo ""
                   ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
                                                   (air-org-skip-subtree-if-priority ?A)
                                                   (org-agenda-skip-if nil '(scheduled deadline))))
                    (org-agenda-overriding-header "ALL normal priority tasks:"))))
         ((org-agenda-compact-blocks t)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (markdown-mode use-package rainbow-delimiters racket-mode flycheck))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
