#!/bin/sh

# Display help information for Yabai functions, including descriptions and usage instructions
yabai-help() {
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    RED='\033[0;31m'
    ORANGE='\033[0;33m'
    RESET='\033[0m'

    echo -e "\nWelcome to the Yabai Helper!\n"

    echo -e "Here are all the Yabai functions created to help you manage your window manager.\n"

    echo -e "Available functions:\n"
    for func in yabai-install yabai-uninstall yabai-start yabai-stop yabai-restart; do
        echo -e "  ${BLUE}$func:${RESET}"
        case "$func" in
        "yabai-install")
            echo -e "    Install yabai and skhd and configure them.\n"
            echo -e "    Usage: ${GREEN}yabai-install${RESET}"
            ;;
        "yabai-uninstall")
            echo -e "    Uninstall yabai and skhd along with their configurations.\n"
            echo -e "    Usage: ${GREEN}yabai-uninstall${RESET}"
            ;;
        "yabai-start")
            echo -e "    Start yabai and skhd services.\n"
            echo -e "    Usage: ${GREEN}yabai-start${RESET}"
            ;;
        "yabai-stop")
            echo -e "    Stop yabai and skhd services.\n"
            echo -e "    Usage: ${GREEN}yabai-stop${RESET}"
            ;;
        "yabai-restart")
            echo -e "    Restart yabai and skhd services.\n"
            echo -e "    Usage: ${GREEN}yabai-restart${RESET}"
            ;;
        *)
            echo -e "  ${RED}No help text available.${RESET}"
            ;;
        esac
        echo ""
    done
}

# Install yabai and skhd using Homebrew
# Requires Homebrew to be installed
yabai-install() {
    if ! command -v brew &> /dev/null; then
        echo "yabai-install: HomeBrew is not installed. Please install HomeBrew first."
        echo "yabai-install: ❌ Operation aborted. ❌"
        return 1
    fi

    echo "yabai-install: 🛠️ Installing yabai and skhd using brew 🛠️"
    brew install yabai skhd

    echo "yabai-install: 🛠️ Copying yabai and skhd configuration files 🛠️"
    cp ./assets/.yabairc.example ~/.yabairc
    cp ./assets/.skhdrc.example ~/.skhdrc

    echo "yabai-install: 🛠️ Starting yabai and skhd services 🛠️"
    yabai --start-service
    skhd --start-service

    echo "yabai-install: 🎉 yabai and skhd installation completed successfully! You may now restart your computer. 🎉"
}

# Uninstall yabai and skhd along with their configurations
yabai-uninstall() {
    read -r rmconfig"?yabai-uninstall: Do you want to remove yabai and skhd configuration files? [Y/n] " # for zsh
    if [[ $rmconfig =~ ^[Yy]$ ]]; then
        echo "yabai-uninstall: 🛠️ Removing yabai and skhd configuration files 🛠️"
        rm -f ~/.yabairc ~/.skhdrc
    else
        echo "yabai-uninstall: 🛠️ No action taken on configuration files 🛠️"
    fi

    echo "yabai-uninstall: 🛠️ Stopping yabai and skhd services 🛠️"
    yabai --stop-service
    skhd --stop-service
    yabai --uninstall-service
    skhd --uninstall-service

    echo "yabai-uninstall: 🛠️ Uninstalling yabai scripting addition 🛠️"
    sudo yabai --uninstall-sa

    echo "yabai-uninstall: 🛠️ Removing yabai and skhd logs and sockets 🛠️"
    rm -rf /tmp/yabai_$USER.out.log /tmp/yabai_$USER.err.log /tmp/yabai_$USER.lock /tmp/yabai_$USER.socket /tmp/yabai-sa_$USER.socket

    echo "yabai-uninstall: 🛠️ Uninstalling yabai and skhd using brew 🛠️"
    brew uninstall yabai skhd

    echo "yabai-uninstall: 🛠️ Restarting Dock 🛠️"
    killall Dock

    echo "yabai-uninstall: 🎉 yabai and skhd uninstallation completed successfully! You may now restart your computer. 🎉"
}

# Start yabai and skhd services
yabai-start() {
    echo "yabai-start: 🛠️ Starting yabai and skhd services 🛠️"
    yabai --start-service
    skhd --start-service

    echo "yabai-start: 🎉 yabai and skhd services started successfully! 🎉"
}

# Stop yabai and skhd services
yabai-stop() {
    echo "yabai-stop: 🛠️ Stopping yabai and skhd services 🛠️"
    yabai --stop-service
    skhd --stop-service

    echo "yabai-stop: 🎉 yabai and skhd services stopped successfully! 🎉"
}

# Restart yabai and skhd services
yabai-restart() {
    echo "yabai-restart: 🛠️ Restarting yabai and skhd services 🛠️"
    yabai --stop-service
    skhd --stop-service
    yabai --start-service
    skhd --start-service

    echo "yabai-restart: 🎉 yabai and skhd services restarted successfully! 🎉"
}
