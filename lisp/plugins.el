;;; plugins.el --- plugins config

;; Commentary:

;; this file includes most plugins config

;;; Code:

;; hydra
(use-package hydra
 :ensure t)

(use-package use-package-hydra
 :ensure t
 :after hydra)


;; consel and ivy 搜索和补全优化
(use-package counsel
 :ensure t)
  
(use-package ivy
 :ensure t
 :init
 (ivy-mode 1)
 (counsel-mode 1)
 :config
 (setq ivy-use-virtual-buffers t)
 (setq search-default-mode #'char-fold-to-regexp)
 (setq ivy-count-format "(%d/%d) ")
 :bind
 (
  ("C-x C-@" . 'counsel-mark-ring); 在某些终端上 C-x C-SPC 会被映射为 C-x C-@，比如在 macOS 上，所以要手动设置
  ("C-x C-SPC" . 'counsel-mark-ring)
  :map minibuffer-local-map
  ("C-r" . counsel-minibuffer-history)))

;; 命令历史记录
(use-package amx
 :ensure t
 :init (amx-mode))

;; 窗口跳转
(use-package ace-window
 :ensure t
 :bind (("C-x o" . 'ace-window)))

;; 撤回
(use-package undo-tree
 :ensure t
 :init (global-undo-tree-mode)
 :custom
 (undo-tree-auto-save-history nil))

;; 滚轮
(use-package good-scroll
 :ensure t
 :if window-system     ; 在图形化界面时才使用这个插件
 :init (good-scroll-mode))

;; nerd font and icons
(use-package nerd-icons
  ;; :custom
  ;; The Nerd Font you want to use in GUI
  ;; "Symbols Nerd Font Mono" is the default and is recommended
  ;; but you can use any other Nerd Font if you want
  ;; (nerd-icons-font-family "Symbols Nerd Font Mono")
  )

;; doom modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; whiwh-key
(use-package which-key
 :init (which-key-mode))

;; avy
(use-package avy
 :ensure t
 )

;; marginalia
(use-package marginalia
 :ensure t
 :init (marginalia-mode)
 :bind (:map minibuffer-local-map
     ("M-A" . marginalia-cycle)))

;; dashboard
(use-package dashboard
 :ensure t
 :config
 (setq dashboard-banner-logo-title "DrinkLessMilkTea") ;; 个性签名
 (setq dashboard-projects-backend 'projectile) ;; 读者可以暂时注释掉这一行，等安装了 projectile 后再使用
 (setq dashboard-startup-banner 'official) ;; 也可以自定义图片
 (setq dashboard-items '((recents . 5)  ;; 显示多少个最近文件
  (bookmarks . 5) ;; 显示多少个最近书签
  (projects . 10))) ;; 显示多少个最近项目
 (dashboard-setup-startup-hook))

;; rainbow-delimiters
(use-package rainbow-delimiters
 :ensure t
 :hook (prog-mode . rainbow-delimiters-mode))

;; company-mode
(use-package company
 :ensure t
 :init (global-company-mode)
 :config
 (setq company-minimum-prefix-length 1) ; 只需敲 1 个字母就开始进行自动补全
 (setq company-tooltip-align-annotations t)
   (setq company-idle-delay 0.0)
 (setq company-show-numbers t) ;; 给选项编号 (按快捷键 M-1、M-2 等等来进行选择).
 (setq company-selection-wrap-around t)
 (setq company-transformers '(company-sort-by-occurrence))) ; 根据选择的频率进行排序，读者如果不喜欢可以去掉

(use-package company-box
   :ensure t
   :if window-system
   :hook (company-mode . company-box-mode))

;; yasnippet
(use-package yasnippet
 :ensure t
 :hook
 (prog-mode . yas-minor-mode)
 :config
 (yas-reload-all)
 ;; add company-yasnippet to company-backends
 (defun company-mode/backend-with-yas (backend)
  (if (and (listp backend) (member 'company-yasnippet backend))
   backend
   (append (if (consp backend) backend (list backend))
        '(:with company-yasnippet))))
 (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
 ;; unbind <TAB> completion
 (define-key yas-minor-mode-map [(tab)]    nil)
 (define-key yas-minor-mode-map (kbd "TAB")  nil)
 (define-key yas-minor-mode-map (kbd "<tab>") nil)
 :bind
 (:map yas-minor-mode-map ("S-<tab>" . yas-expand)))
  
(use-package yasnippet-snippets
 :ensure t
 :after yasnippet)

;; flycheck
(use-package flycheck
 :ensure t
 :config
 (setq truncate-lines nil) ; 如果单行信息很长会自动换行
 :hook
 (prog-mode . flycheck-mode))

(use-package lsp-mode
 :ensure t
 :init
 ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
 (setq lsp-keymap-prefix "C-c l"
	lsp-file-watch-threshold 500)
 :hook  (lsp-mode . lsp-enable-which-key-integration) ; which-key integration
 :commands (lsp lsp-deferred)
 :config
 (setq lsp-completion-provider :none) ;; 阻止 lsp 重新设置 company-backend 而覆盖我们 yasnippet 的设置
 (setq lsp-headerline-breadcrumb-enable t)
 :bind
 ("C-c l s" . lsp-ivy-workspace-symbol)) ;; 可快速搜索工作区内的符号（类名、函数名、变量名等）

(use-package lsp-ui
 :ensure t
 :config
 (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
 (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
 (setq lsp-ui-doc-position 'top))

(use-package lsp-ivy
 :ensure t
 :after (lsp-mode))

;; dap-mode
(use-package dap-mode
 :ensure t
 :after lsp-mode
 :init (add-to-list 'image-types 'svg)
 :commands dap-debug
 :custom
 (dap-auto-configure-mode t)
 :hydra
 (dap-hydra
  (:color pink :hint nil :foreign-keys run)
  "
^Stepping^     ^Switch^         ^Breakpoints^     ^Debug^           ^Eval^           
^^^^^^^^---------------------------------------------------------------------------------------------------------------
_n_: Next      _ss_: Session      _bb_: Toggle     _dd_: Debug         _ee_: Eval         
_i_: Step in    _st_: Thread       _bd_: Delete     _dr_: Debug recent     _er_: Eval region
_o_: Step out    _sf_: Stack frame    _ba_: Add       _dl_: Debug last      _es_: Eval thing at point
_c_: Continue    _su_: Up stack frame   _bc_: Set condition  _de_: Edit debug template  _ea_: Add expression.
_r_: Restart frame _sd_: Down stack frame  _bh_: Set hit count  _ds_: Debug restart
_Q_: Disconnect   _sl_: List locals    _bl_: Set log message
         _sb_: List breakpoints
         _se_: List expressions
"
  ("n" dap-next)
  ("i" dap-step-in)
  ("o" dap-step-out)
  ("c" dap-continue)
  ("r" dap-restart-frame)
  ("ss" dap-switch-session)
  ("st" dap-switch-thread)
  ("sf" dap-switch-stack-frame)
  ("su" dap-up-stack-frame)
  ("sd" dap-down-stack-frame)
  ("sl" dap-ui-locals)
  ("sb" dap-ui-breakpoints)
  ("se" dap-ui-expressions)
  ("bb" dap-breakpoint-toggle)
  ("ba" dap-breakpoint-add)
  ("bd" dap-breakpoint-delete)
  ("bc" dap-breakpoint-condition)
  ("bh" dap-breakpoint-hit-condition)
  ("bl" dap-breakpoint-log-message)
  ("dd" dap-debug)
  ("dr" dap-debug-recent)
  ("ds" dap-debug-restart)
  ("dl" dap-debug-last)
  ("de" dap-debug-edit-template)
  ("ee" dap-eval)
  ("ea" dap-ui-expressions-add)
  ("er" dap-eval-region)
  ("es" dap-eval-thing-at-point)
  ("q" nil "quit" :color blue)
  ("Q" dap-disconnect "Disconnect" :color blue))
 :config
 (dap-ui-mode 1)
 (defun dap-hydra ()
	(interactive)
	"Run `dap-hydra/body'."
	(dap-hydra/body)))

;; projectile
(use-package projectile
 :ensure t
 :bind (("C-c p" . projectile-command-map))
 :config
 (setq projectile-mode-line "Projectile")
 (setq projectile-track-known-projects-automatically nil))

(use-package counsel-projectile
 :ensure t
 :after (projectile)
 :init (counsel-projectile-mode))

;; magit
(use-package magit
 :ensure t)

;; catppuccin
(use-package catppuccin-theme
  :ensure
  :config (load-theme 'catppuccin :no-confirm))

(provide 'plugins)
;;; plugins.el ends here
