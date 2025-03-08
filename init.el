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

;; custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;;; Load file:

(if (file-exists-p custom-file) (load-file custom-file))

(require 'options) ;; user options

(require 'plugins) ;; plugins config

(require 'vim) ;; evil config

(require 'c_config) ;; c config

(require 'latex_config) ;; latex config

(provide 'init)
;;; init.el ends here
