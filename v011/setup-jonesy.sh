#!/bin/bash
# Jonesy Setup Script for Fedora-based Systems (DNF)

set -e

update_system() {
    echo "[+] Updating system..."
    dnf update -y
}

install_base_dev_tools() {
    echo "[+] Installing base dev tools..."
    dnf install -y gcc g++ make gdb binutils cpp glibc-devel glibc-headers kernel-headers valgrind cppcheck
}

install_editors() {
    echo "[+] Installing editors..."
    dnf install -y vim nano emacs
}

install_docs_tools() {
    echo "[+] Installing documentation tools..."
    dnf install -y man-pages man-pages-posix cppman
}

install_languages() {
    echo "[+] Installing programming languages and tools..."
    dnf install -y rust cargo java-17-openjdk-devel nodejs npm
}

install_ascii_tools() {
    echo "[+] Installing ASCII art tools..."
    dnf install -y figlet toilet boxes lolcat
}

install_terminal_tools() {
    echo "[+] Installing terminal utilities..."
    dnf install -y lynx tmux fzf htop btop ncdu tree
}

install_networking_tools() {
    echo "[+] Installing networking tools..."
    dnf install -y net-tools iproute iputils nmap traceroute dhcp-server acl
}

install_file_sharing() {
    echo "[+] Installing Samba, NFS, and rsync..."
    dnf install -y samba samba-common nfs-utils rsync openssh-server
}

install_web_server_tools() {
    echo "[+] Installing HTTPD and web utilities..."
    dnf install -y httpd curl wget
}

install_misc_utilities() {
    echo "[+] Installing misc tools..."
    dnf install -y jq fd-find ripgrep neofetch
}

export -f update_system install_base_dev_tools install_editors install_docs_tools
export -f install_languages install_ascii_tools install_terminal_tools
export -f install_networking_tools install_file_sharing install_web_server_tools
export -f install_misc_utilities
