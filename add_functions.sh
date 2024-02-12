#!/bin/zsh

echo "yabai-setup: 🛠️ Getting the full path of yabai-setup.sh 🛠️"
full_path=$(realpath src/yabai-setup.sh)
line_to_add="\n# Yabai functions for tiling management\nsource $full_path\n"

echo "yabai-setup: 🛠️ Trying to add the reference to the file in the .zshrc 🛠️"
if [ -f ~/.zshrc ]; then
    if ! grep -qF "source $full_path" ~/.zshrc; then
        echo "$line_to_add" >> ~/.zshrc
        echo "yabai-setup: 🎉 Line successfully added! You may restart your terminal to use the functions. 🎉"
    else
        echo "yabai-setup: 🛠️ Line already exists in .zshrc. No action taken. 🛠️"
    fi
else
    echo "yabai-setup: .zshrc file not found. Please create one in your home directory."
    echo "yabai-setup: ❌ Operation aborted. ❌"
fi
