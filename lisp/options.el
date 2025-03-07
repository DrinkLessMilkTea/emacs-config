;;; options.el --- open through open-options

;;; Commentary:

;; this file includes user options

;;; Code:

(electric-pair-mode t)            ; 自动补全括号
(add-hook 'prog-mode-hook #'show-paren-mode) ; 编程模式下，光标在括号上时高亮另一个括号
(column-number-mode t)            ; 在 Mode line 上显示列号
(global-auto-revert-mode t)         ; 当另一程序修改了文件时，让 Emacs 及时刷新 Buffer
(delete-selection-mode t)          ; 选中文本后输入文本会替换文本（更符合我们习惯了的其它编辑器的逻辑）
(setq inhibit-startup-message t)       ; 关闭启动 Emacs 时的欢迎界面
(setq make-backup-files nil)         ; 关闭文件自动备份
(add-hook 'prog-mode-hook #'hs-minor-mode)  ; 编程模式下，可以折叠代码块
(global-display-line-numbers-mode 1)     ; 在 Window 显示行号
(tool-bar-mode -1)              ; 关闭 Tool bar
(menu-bar-mode -1)              ; 关闭 Menu bar
(when (display-graphic-p) (toggle-scroll-bar -1)) ; 图形界面时关闭滚动条

(savehist-mode 1)              ; 打开 Buffer 历史记录保存
(setq display-line-numbers-type 'relative)  ; 显示相对行号
(add-to-list 'default-frame-alist '(width . 200)) ; 设定启动图形界面时的初始 Frame 宽度（字符数）
(add-to-list 'default-frame-alist '(height . 60)) ; 设定启动图形界面时的初始 Frame 高度（字符数）

(defun open-init()
  (interactive)
  (find-file ".emacs.d/init.el"))

(defun open-config()
  (interactive)
  (find-file ".emacs.d/lisp"))

(provide 'options)
;;; options.el ends here
