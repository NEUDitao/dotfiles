
(require 'package)

(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(setq column-number-mode t)
(global-linum-mode)

(global-set-key [C-wheel-up] 'text-scale-increase)
(global-set-key [C-wheel-down] 'text-scale-decrease)

(use-package default-text-scale
	     :ensure t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (default-text-scale use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package default-text-scale
  :ensure t)


