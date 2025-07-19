#!/bin/bash
# Unified Debian Setup Script for SulacoLAN Nodes (Hicks, Jonesy, Hudson)

LOGFILE=~/setup.log
HOSTNAME=$(hostname)

check_step() {
    grep -q "$1" "$LOGFILE" 2>/dev/null
}

mark_step() {
    echo "$1" >> "$LOGFILE"
}

set -e

update_system() {
    echo "[+] Updating and upgrading system..."
    apt update && apt upgrade -y
    mark_step "update_system"
}

install_dev_tools() {
    echo "[+] Installing development tools..."
    apt install -y \
        build-essential clang clangd clang-tools cppcheck cppman curl \
        g++ gcc gdb git lldb make man-db manpages-dev manpages-posix \
        nano nodejs npm openjdk-17-jdk python3 python3-pip rustc rust-doc \
        libncurses-dev valgrind software-properties-common gnupg lsb-release wget
    mark_step "install_dev_tools"
}

install_gui_tools() {
    echo "[+] Installing graphical tools and desktop environments..."
    apt install -y \
        i3 i3status i3lock suckless-tools dmenu xterm rofi thunar \
        network-manager-gnome volumeicon-alsa lxappearance xinit \
        brave-browser firefox-esr chromium libreoffice
    mark_step "install_gui_tools"
}

install_optional_sysadmin_tools() {
    echo "[+] Installing sysadmin and monitoring tools..."
    apt install -y \
        btop htop sl s-tui ufw arp hdparm fdisk gdisk iftop iostat iotop \
        iptables sysstat dmidecode route net-tools
    mark_step "install_optional_sysadmin_tools"
}

install_tui_tools() {
    echo "[+] Installing console eye-candy and helpers..."
    apt install -y figlet toilet boxes emacs cal
    mark_step "install_tui_tools"
}

install_xfce_if_hicks() {
    if [[ "$HOSTNAME" == "hicks" ]]; then
        echo "[+] Installing XFCE for Hicks only..."
        apt install -y xfce4
        mark_step "install_xfce"
    fi
}

setup_clang19() {
    echo "[+] Setting up Clang 19 as default..."
    apt install -y clang-19 clangd-19 lldb-19 lld-19 libc++-19-dev libc++abi-19-dev
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-19 100
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-19 100
    update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-19 100
    mark_step "setup_clang19"
}

main() {
    check_step "update_system" || update_system
    check_step "install_dev_tools" || install_dev_tools
    check_step "install_gui_tools" || install_gui_tools
    check_step "install_optional_sysadmin_tools" || install_optional_sysadmin_tools
    check_step "install_tui_tools" || install_tui_tools
    check_step "install_xfce" || install_xfce_if_hicks
    check_step "setup_clang19" || setup_clang19

    echo "[✓] Debian setup complete for $HOSTNAME."
}

main

