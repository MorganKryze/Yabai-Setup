#!/bin/sh

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

yabai-start() {
    echo "yabai-start: 🛠️ Starting yabai and skhd services 🛠️"
    yabai --start-service
    skhd --start-service

    echo "yabai-start: 🎉 yabai and skhd services started successfully! 🎉"
}

yabai-stop() {
    echo "yabai-stop: 🛠️ Stopping yabai and skhd services 🛠️"
    yabai --stop-service
    skhd --stop-service

    echo "yabai-stop: 🎉 yabai and skhd services stopped successfully! 🎉"
}

yabai-restart() {
    echo "yabai-restart: 🛠️ Restarting yabai and skhd services 🛠️"
    yabai --stop-service
    skhd --stop-service
    yabai --start-service
    skhd --start-service

    echo "yabai-restart: 🎉 yabai and skhd services restarted successfully! 🎉"
}
