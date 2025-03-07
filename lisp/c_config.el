;;; c_config.el --- c and cpp configuration

;;; Commentary:

;; this file is about c and cpp configuration

;;; Code:

(use-package c++-mode
 :functions  ; suppress warnings
 c-toggle-hungry-state
 :hook
 (c-mode . lsp-deferred)
 (c++-mode . lsp-deferred)
 (c++-mode . c-toggle-hungry-state))

(provide 'c_config)
;;; c_config.el ends here
