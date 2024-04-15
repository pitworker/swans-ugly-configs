(setq package-archives '(("melpa" . "http://melpa.org/packages/")
       ("gnu" . "http://elpa.gnu.org/packages/")))

(with-eval-after-load 'package
  (add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(eval-when-compile
  (add-to-list 'load-path "/home/swan/.emacs.d/use-package-2.4.5/")
  (require 'use-package))

(display-time-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(flycheck-color-mode-line tide elm-mode rust-mode web-mode use-package))
 '(column-number-mode t)
 '(gloal-display-line-numbers-mode t)
 '(inhibit-startup-screen t)
 '(safe-local-variables-values '((eval prettier-mode t)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(autoload 'web-mode "web-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode))
(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
(defun web-mode-init-hook ()
  "Hooks for Web mode. Adjust indent."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-sql-indent-offset 2))
(add-hook 'web-mode-hook 'web-mode-init-hook)

(defun untabify-everything ()
  (untabify (point-min) (point-max)))

(add-hook 'before-save-hook
    'delete-trailing-whitespace)
(add-hook 'before-save-hook
    'untabify-everything)

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq-default tab-stop-list (number-sequence 2 120 2))
(setq-default rust-indent-offset 2)
(setq-default elm-indent-offset 2)
(setq python-indent-guess-indent-offset nil)
(setq python-indent-offset 2)
(setq js-indent-level 2)
(add-hook 'python-mode-hook
    (lambda ()
      (setq indent-tabs-mode nil)
      (setq tab-width 2)
      (setq tab-stop-list (number-sequence 2 120 2))))

(windmove-default-keybindings)
(use-package tide :ensure t)
(use-package flycheck :ensure t)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (tide-hl-identifier-mode +1))
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)
(add-to-list 'auto-mode-alist '("\\.tsx?$" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (or (string-equal "tsx"
                                    (file-name-extension buffer-file-name))
                      (string-equal "ts"
                                    (file-name-extension buffer-file-name)))
              (setup-tide-mode))))
(flycheck-add-mode 'typescript-tslint 'web-mode)
