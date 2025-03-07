;;; vim.el -- vim config

;;; Commentary:

;; this file is config about evil

;;; Code:

(use-package evil
 :ensure t
 :init (evil-mode))

(use-package goto-chg
  :ensure t)

;; keymaps
(evil-set-leader nil (kbd "SPC"))
(evil-global-set-key 'normal "s" 'avy-goto-char-timer)
(evil-global-set-key 'normal (kbd "<leader>e") 'eval-buffer)
(evil-global-set-key 'normal (kbd "<leader>b") 'ivy-switch-buffer)
(evil-global-set-key 'normal (kbd "<leader>s") 'save-buffer)
(evil-global-set-key 'normal (kbd "<leader>c") 'kill-buffer)
(evil-global-set-key 'normal (kbd "q") 'delete-window)
(evil-global-set-key 'normal (kbd "<leader>|") 'split-window-right)
(evil-global-set-key 'normal (kbd "<leader>\\") 'split-window-below)
(evil-global-set-key 'normal (kbd "<leader>q") 'save-buffers-kill-emacs)
(evil-global-set-key 'normal (kbd "<leader>f") 'project-find-file)
(evil-global-set-key 'normal (kbd "<leader>F") 'lsp-ivy-workspace-symbol)
(evil-global-set-key 'normal (kbd "<leader>t") 'suspend-frame)
(evil-global-set-key 'normal (kbd "<leader>g") 'magit-dispatch)

;; lsp keymaps
(evil-define-key 'normal 'lsp-ui-mode-map (kbd "gd") 'lsp-ui-peek-find-definitions)
(evil-define-key 'normal 'lsp-ui-mode-map (kbd "gD") 'lsp-ui-peek-find-references)

(provide 'vim)
;;; vim.el ends here
