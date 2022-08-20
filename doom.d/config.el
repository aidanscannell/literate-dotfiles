;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Aidan Scannell"
      user-mail-address "scannell.aidan@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-dracula)
(setq doom-theme 'doom-laserwave)
;; (setq doom-theme 'doom-moonlight)
;; (setq doom-theme 'doom-monokai)
;; (setq doom-theme 'doom-wilmersdorf)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory (concat (getenv "HOME")"/Library/Mobile Documents/com~apple~CloudDocs/org"))
;; (setq org-directory "~/Dropbox/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq zot_bib (concat org-directory "/ref/zotero-library.bib")
      ;; org_ref_bib (concat (getenv "HOME") "/Dropbox/org/ref/org-ref-library.bib")
      org_notes org-directory
      org_contacts (concat org-directory "/contacts.org"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Format
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Disable formatter from lsp so that (format +onsave)
;; (setq +format-with-lsp nil)

;; (setq-hook! 'python-mode-hook +format-with 'html-tidy)
;; (setq-hook! 'python-mode-hook +format-with :none)

(defvar +format-on-save-enabled-modes
  '(not emacs-lisp-mode    ; elisp's mechanisms are good enough
        sql-mode           ; sqlformat is currently broken
        tex-mode           ; latexindent is broken
        latex-mode
        html-mode
        org-msg-edit-mode) ; doesn't need a formatter
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(after! org
  (use-package! org-projectile
    :config
    (org-projectile-per-project)
    (setq org-projectile-per-project-filepath "todo.org")
    (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
    ;; (setq org-projectile-projects-file "~/Dropbox/org/project_todos.org")
    (setq org-projectile-projects-file "~/Library/Mobile Documents/com~apple~CloudDocs/org/project_todos.org")
    (push (org-projectile-project-todo-entry) org-capture-templates)
    ;; (global-set-key (kbd "C-c c") 'org-capture)
    ;; (global-set-key (kbd "C-c n p") 'org-projectile-project-todo-completing-read)))
    ;; :init
    ;; (org-projectile-per-project)
    ;; (setq org-projectile-per-project-filepath "project_todos.org")
    ;; (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
    ;; (setq org-projectile-projects-file "~/Dropbox/org/project_todos.org")
    ;; (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
    ;; (push (org-projectile-project-todo-entry) org-capture-templates)
    ;; (global-set-key (kbd "C-c c") 'org-capture)
    ;; (global-set-key (kbd "C-c n p") 'org-projectile-project-todo-completing-read)))

    (setq org-contacts-files org_contacts
          org-todo-keywords '((sequence "SOMEDAY" "TODO" "PROGRESS" "|" "DONE" "DELEGATED" "CANCELLED"))
          ;;  ;; org-default-notes-file "~/Dropbox/org/notes.org"
          org-startup-indented t ;; Keep the indentation well structured
          org-bullets-bullet-list '("■" "◆" "▲" "▶"))


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Org LaTeX
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Setup org-ref
    (use-package! org-ref
      :config
      (setq org-ref-default-bibliography '(zot_bib)))

    ;; Import ignore-headlines to allow a headline (but not its children) to
    ;; be ignored.  Any headline tagged with the 'ignore' tag will be
    ;; ignored (i.e. will not be included in the export), but any child
    ;; headlines will not be ignored (unless explicitly tagged to be
    ;; ignored), and will instead have their levels promoted by one.
    (use-package! org-contrib
      :config
      (require 'ox-extra)
      (ox-extras-activate '(latex-header-blocks ignore-headlines)))
    ;; (use-package! ox-extra
    ;;   :config
    ;;   (ox-extras-activate '(latex-header-blocks ignore-headlines)))

    (use-package! ox-latex
      :config
      (setq org-latex-pdf-process
            '("latexmk -interaction=nonstopmode -output-directory=./tex -output-format=pdf %f"))
      ;; '("latexmk -f -silent -output-directory=./tex -output-format=pdf %f \n cp ./tex/%b.pdf ./%b.pdf"))
      ;; (setq org-latex-with-hyperref nil) ;; stop org adding hypersetup{author..} to latex export
      ;; (setq org-latex-prefer-user-labels t)
      (unless (boundp 'org-latex-classes)
        (setq org-latex-classes nil)))

    ))

;; ;; function to add newpage tag functionality to org exporter
;; (after! org
;;   (defun org/get-headline-string-element  (headline backend info)
;;     (let ((prop-point (next-property-change 0 headline)))
;;       (if prop-point (plist-get (text-properties-at prop-point headline) :parent))))

;;   (defun org/ensure-latex-clearpage (headline backend info)
;;     (when (org-export-derived-backend-p backend 'latex)
;;       (let ((elmnt (org/get-headline-string-element headline backend info)))
;;         (when (member "newpage" (org-element-property :tags elmnt))
;;           (concat "\\clearpage\n" headline)))))

;;   (add-to-list 'org-export-filter-headline-functions
;;                'org/ensure-latex-clearpage)
;;   )

;; Org Babel
;; (setq +python-ipython-repl-args '("-i" "--simple-prompt" "--no-color-info"))
;; (setq org-babel-async-ipython t)
;; (require 'ox-ipynb)
;; (require 'ob-ipython)
;; (add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (ipython . t)
   (org . t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LaTeX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (add-hook pdf-view-mode-hook 'auto-revert-mode)
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

;; Config for doom latex lang
(after! reftex
  (setq reftex-default-bibliography zot_bib))

;; (setq +latex-viewers '(pdf-tools preview))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! :leader
      (:desc "M-x" "SPC"  #'execute-extended-command)
      (:desc "M-x" "C-SPC"  #'execute-extended-command))

;; avy jump
(after! avy
  (map! :leader
        (:prefix-map ("j" . "jump")
         :desc "jump to char" "j"  #'avy-goto-char-2
         :desc "jump to word" "w"  #'avy-goto-word-0
         :desc "jump to line" "l"  #'avy-goto-line
         :desc "jump to url" "u"   #'avy-goto-url
         :desc "imenu" "i"  #'counsel-imenu
         :desc "switch-buffer" "b"  #'+ivy/switch-workspace-buffer
         :desc "goto-last-change" "c"  #'goto-last-change
         :desc "find-function" "f"  #'find-function
         :desc "find-variable" "v"  #'find-variable
         )))

;; comment lines with SPC ;;
(map! :after evil
      :leader
      :desc "comment lines" ";" 'evilnc-comment-or-uncomment-lines)

;; Deleted other window using SPC w D
(map! :map evil-window-map
      :desc "delete other window" "D" #'ace-delete-window)

;; change workspaces to "layouts" using l instead of using TAB
(map! :leader
      (:prefix-map ("l" . "layouts")
       :desc "previos" "k"  #'+workspace/switch-left
       :desc "next" "j"  #'+workspace/switch-right
       :desc "switch" "l"  #'+workspace/switch-to
       :desc "delete" "d"  #'+workspace/delete
       :desc "new" "n"  #'+workspace/new
       ))

(after! evil-snipe (evil-snipe-mode -1))

;; dired quick links
(defun my/open-config () (interactive) (dired "/Users/scannea1/.config"))
(defun my/open-dotfiles() (interactive) (dired "/Users/scannea1/dotfiles"))
(defun my/open-python-projects () (interactive) (dired "/Users/scannea1/Developer/python-projects"))
(defun my/open-home () (interactive) (dired "/Users/scannea1"))
(defun my/open-documents () (interactive) (dired "/Users/scannea1/Documents"))
(defun my/open-emacs () (interactive) (dired doom-private-dir))
(defun my/open-downloads () (interactive) (dired "/Users/scannea1/Downloads"))
(defun my/open-notes () (interactive) (dired "/Users/scannea1/Dropbox/org"))

(map! :after dired
      :map dired-mode-map
      :ng "h" #'dired-up-directory
      :ng "l" #'dired-find-file)

(map! :after dired
      :leader
      (:prefix-map ("d" . "dired")
       :desc "~/.config" "c"  #'my/open-config
       :desc "~/dotfiles" "g"  #'my/open-dotfiles
       :desc "here" "d"  #'dired-jump
       :desc "emacs" "e"  #'my/open-emacs
       :desc "~/Documents" "D"  #'my/open-documents
       :desc "~/" "h"  #'my/open-home
       :desc "~/Downloads" "o"  #'my/open-downloads
       :desc "python-projects" "p"  #'my/open-python-projects
       :desc "notes" "n"  #'my/open-notes
       ))

(after! evil
  (after! dired-ranger
    (evil-collection-define-key 'normal 'dired-mode-map
      ;; "h" 'dired-single-up-directory
      "H" 'dired-omit-mode
      ;; "l" 'dired-single-buffer
      "y" 'dired-ranger-copy
      "X" 'dired-ranger-move
      "p" 'dired-ranger-paste)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; dired
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; change ls to gls for grouping by directories on osx
;; (setq insert-directory-program "gls" dired-use-ls-dired t)
(setq dired-listing-switches "-agho --group-directories-first"
      dired-omit-files "^\\.[^.].*"
      dired-omit-verbose nil)

;; (autoload 'dired-omit-mode "dired-x")

;; (add-hook 'dired-load-hook
;;           (lambda ()
;;             (interactive)
;;             (dired-collapse)))

;; TODO disable all-the-icons-dired-mode in terminal emacs
;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; (add-hook 'dired-mode-hook
;;           (lambda ()
;;             (interactive)
;;             (dired-omit-mode 1)
;;             (all-the-icons-dired-mode 1)
;;             ;; (dired-rainbow-mode 1)
;;             (hl-line-mode 1)))

;; (after! dired-rainbow
;;   (progn
;;     (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
;;     (dired-rainbow-define html "#eb5286" ("css" "less" "sass" "scss" "htm" "html" "jhtm" "mht" "eml" "mustache" "xhtml"))
;;     (dired-rainbow-define xml "#f2d024" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata"))
;;     (dired-rainbow-define document "#9561e2" ("docm" "doc" "docx" "odb" "odt" "pdb" "pdf" "ps" "rtf" "djvu" "epub" "odp" "ppt" "pptx"))
;;     (dired-rainbow-define markdown "#ffed4a" ("org" "etx" "info" "markdown" "md" "mkd" "nfo" "pod" "rst" "tex" "textfile" "txt"))
;;     (dired-rainbow-define database "#6574cd" ("xlsx" "xls" "csv" "accdb" "db" "mdb" "sqlite" "nc"))
;;     (dired-rainbow-define media "#de751f" ("mp3" "mp4" "mkv" "MP3" "MP4" "avi" "mpeg" "mpg" "flv" "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
;;     (dired-rainbow-define image "#f66d9b" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg" "png" "psd" "eps" "svg"))
;;     (dired-rainbow-define log "#c17d11" ("log"))
;;     (dired-rainbow-define shell "#f6993f" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))
;;     (dired-rainbow-define interpreted "#38c172" ("py" "ipynb" "rb" "pl" "t" "msql" "mysql" "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
;;     (dired-rainbow-define compiled "#4dc0b5" ("asm" "cl" "lisp" "el" "c" "h" "c++" "h++" "hpp" "hxx" "m" "cc" "cs" "cp" "cpp" "go" "f" "for" "ftn" "f90" "f95" "f03" "f08" "s" "rs" "hi" "hs" "pyc" ".java"))
;;     (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
;;     (dired-rainbow-define compressed "#51d88a" ("7z" "zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
;;     (dired-rainbow-define packaged "#faad63" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3" "vdf" "vpk" "bsp"))
;;     (dired-rainbow-define encrypted "#ffed4a" ("gpg" "pgp" "asc" "bfe" "enc" "signature" "sig" "p12" "pem"))
;;     (dired-rainbow-define fonts "#6cb2eb" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
;;     (dired-rainbow-define partition "#e3342f" ("dmg" "iso" "bin" "nrg" "qcow" "toast" "vcd" "vmdk" "bak"))
;;     (dired-rainbow-define vc "#0074d9" ("git" "gitignore" "gitattributes" "gitmodules"))
;;     (dired-rainbow-define-chmod executable-unix "#38c172" "-.*x.*")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Elpy functions
(defun my/elpy-shell-send-file-current ()
  "Run \"elpy-shell-send-file\" with current file"
  (interactive)
  (elpy-shell-send-file (buffer-file-name (window-buffer (minibuffer-selected-window)))))

(after! python
  (map! :map python-mode-map
        :localleader
        :g "z" 'elpy-shell-switch-to-shell
        :g "c" 'my/elpy-shell-send-file-current
        :g "d" 'sphinx-doc ;; add docstring to function
        ;; :g "i" 'my/poetry-ipython
        ;; :g "p" 'my/poetry-execute-in-ipython
        (:prefix-map ("i" . "imports")
         :g "i" 'pyimport-insert-missing
         :g "r" 'pyimport-remove-unused
         :g "s" 'py-isort-buffer)
        ;; (:prefix-map ("v" . "virtual envs")
        ;;  :g "a" 'poetry-add
        ;;  :g "c" 'poetry-check
        ;;  :g "d" 'poetry-venv-deactivate
        ;;  :g "e" 'poetry-edit-pyproject-toml
        ;;  :g "i" 'poetry-install
        ;;  :g "l" 'poetry-show
        ;;  :g "r" 'poetry-run
        ;;  :g "s" 'poetry-shell
        ;;  :g "u" 'poetry-update
        ;;  :g "w" 'poetry-venv-workon)
        ;; :g "p" 'my/poetry-execute-file)
        ))

(after! flycheck
  (flycheck-define-checker
      python-mypy ""
      :command ("mypy"
                "--ignore-missing-imports" "--fast-parser"
                "--python-version" "3.6"
                source-original)
      :error-patterns
      ((error line-start (file-name) ":" line ": error:" (message) line-end))
      :modes python-mode)

  (add-to-list 'flycheck-checkers 'python-mypy t)
  (flycheck-add-next-checker 'python-pylint 'python-mypy t))
