;;; consult-slime.el --- Consult commands for SLIME -*- lexical-binding: t -*-

;; Author: Dmitry Kosenkov
;; Version: 0.1.0
;; URL: https://github.com/Junker/consult-slime
;; Keywords: convenience
;; Package-Requires: ((emacs "24.1") (consult "1.0") (slime "2.18"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;; Provides SLIME-related Consult commands.

;;; Code:


(require 'consult)
(require 'slime)
(require 'slime-repl)

(defun consult-slime--connection-candidates ()
  "Connection candidates."
  (let* ((fstring "%s%2s  %-10s  %-17s  %-7s %-s %s")
         (collect (lambda (p)
                    (cons
                     (format fstring
                             (if (eq slime-default-connection p) "*" " ")
                             (slime-connection-number p)
                             (slime-connection-name p)
                             (or (process-id p) (process-contact p))
                             (slime-pid p)
                             (slime-lisp-implementation-type p)
                             (slime-connection-output-buffer p))
                     p))))
    (mapcar collect (reverse slime-net-processes))))

(defun consult-slime-go-to-repl (conn)
  "Switched to marked REPL(s)."
  (let ((slime-dispatching-connection conn))
    (switch-to-buffer (slime-output-buffer))))

(defun consult-slime-list-connections ()
  "Yet another `slime-list-connections' with `consult'."
  (interactive)
  (consult-slime-go-to-repl
   (consult--read (consult-slime--connection-candidates)
				  :prompt "Slime connections: "
				  :require-match nil
                  :lookup #'consult--lookup-cdr
				  :sort nil)))

(defun consult-slime-repl-history ()
  "Select an input from the SLIME repl's history and insert it."
  (interactive)
  (when slime-repl-input-history
	(insert (consult--read slime-repl-input-history
						   :prompt "Slime REPL History: "
						   :require-match nil
						   :history t
						   :sort nil))))

(provide 'consult-slime)
;;; consult-slime.el ends here
