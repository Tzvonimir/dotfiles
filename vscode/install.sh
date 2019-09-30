#!/usr/bin/env bash
#
# Symlink vscode user settings

CURRENT_DIR="$(dirname "$0")"
SETTINGS_DIR="$HOME/Library/Application Support/Code/User"

ln -s "$CURRENT_DIR"/settings.json "$SETTINGS_DIR"/settings.json
ln -s "$CURRENT_DIR"/keybindings.json "$SETTINGS_DIR"/keybindings.json

EXTENSIONS=(
    2gua.rainbow-brackets
    avli.clojure
    ban.spellright
    cduruk.thrift
    clptn.code-paredit
    dbaeumer.vscode-eslint
    HookyQR.beautify
    mechatroner.rainbow-csv
    ms-python.python
    ms-vscode.sublime-keybindings
    pedrorgirardi.vscode-cljfmt
    PeterJausovec.vscode-docker
    redhat.java
    vscjava.vscode-maven
)

for e in "${EXTENSIONS[@]}"; do
    code --install-extension "$e"
done