#!/bin/bash
# Hicks Setup Script for Debian-based Systems (APT)

set -e

update_system() {
    echo "[+] Updating system..."
    apt update && apt upgrade -y
}

install_base_dev_tools() {
    echo "[+] Installing base dev tools..."
    apt install -y build-essential gcc g++ make gdb clang lldb valgrind cppcheck
}

install_editors() {
    echo "[+] Installing editors..."
    apt install -y vim nano emacs
}

install_docs_tools() {
    echo "[+] Installing documentation tools..."
    apt install -y man-db manpages-dev manpages-posix cppman rust-doc default-jdk-doc
}

install_languages() {
    echo "[+] Installing programming languages and tools..."
    apt install -y default-jdk openjdk-17-jdk rustc cargo nodejs npm
}

install_ascii_tools() {
    echo "[+] Installing ASCII art tools..."
    apt install -y figlet toilet boxes lolcat
}

install_terminal_tools() {
    echo "[+] Installing terminal utilities..."
    apt install -y lynx tmux fzf btop ncdu tree
}

install_networking_tools() {
    echo "[+] Installing networking tools..."
    apt install -y net-tools dnsutils iputils-ping traceroute nmap isc-dhcp-server acl
}

install_file_sharing() {
    echo "[+] Installing Samba, NFS, and rsync..."
    apt install -y samba samba-common nfs-kernel-server rsync openssh-server
}

install_web_server_tools() {
    echo "[+] Installing Apache and web utilities..."
    apt install -y apache2 curl wget
}

install_misc_utilities() {
    echo "[+] Installing misc tools..."
    apt install -y jq fd-find ripgrep neofetch
}

export -f update_system install_base_dev_tools install_editors install_docs_tools
export -f install_languages install_ascii_tools install_terminal_tools
export -f install_networking_tools install_file_sharing install_web_server_tools
export -f install_misc_utilities
