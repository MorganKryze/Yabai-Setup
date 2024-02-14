#!/bin/zsh

# === Define the path to the script ===

echo "yabai-setup: 🛠️ Getting the full path of yabai-setup.sh 🛠️"
full_path_shell=$(realpath src/yabai-setup.sh)
full_path_project=$(realpath .)

# === Add the reference to the script and set the path as an environment variable ===

line_to_add="\n# Yabai commands for tiling management\nexport YABAI_SETUP_PATH=\"$full_path_project\"\nsource \"$full_path_shell\""

# === Add the reference to the script in .zshrc ===

echo "yabai-setup: 🛠️ Trying to add the reference to the file in the .zshrc 🛠️"
if [ -f ~/.zshrc ]; then
    if ! grep -qF "source $full_path_shell" ~/.zshrc; then
        echo "$line_to_add" >> ~/.zshrc
        echo "yabai-setup: 🎉 Line successfully added! You may restart your terminal to use the functions. 🎉"
    else
        echo "yabai-setup: 🛠️ Line already exists in .zshrc. No action taken. 🛠️"
    fi
else
    echo "yabai-setup: .zshrc file not found. Please create one in your home directory."
    echo "yabai-setup: ❌ Operation aborted. ❌"
fi
