(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ace-window amx catppuccin-theme company company-box counsel
		counsel-projectile dap-mode dashboard doom-modeline
		evil flycheck good-scroll hydra lsp-ivy lsp-mode
		lsp-ui magit marginalia mwim projectile
		rainbow-delimiters undo-tree use-package-hydra
		yasnippet yasnippet-snippets)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el --- load the configuration

;;; Commentary:

;; this file start the configuration

;;; Code:

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory)) ;; add load path

;; init melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; init use-package
(eval-when-compile
 (require 'use-package))

;;; Load file:


(require 'options) ;; user options

(require 'plugins) ;; plugins config

(require 'vim) ;; evil config

(require 'c_config) ;; c config

(provide 'init)
;;; init.el ends here
