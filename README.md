# Consult-SLIME

Consult commands for SLIME

## Instalation

It's available on Melpa:

```
M-x package-install consult-slime
```

or

```lisp
(use-package consult-slime)
```

## Usage

Consult-SLIME defines a few new commands:

- `consult-slime-list-connections` - Yet another slime-list-connections with Consult.
- `consult-slime-repl-history` - Select an input from the SLIME REPL history and insert it.


## Credits

Based on [Helm-SLIME](https://github.com/emacs-helm/helm-slime).
