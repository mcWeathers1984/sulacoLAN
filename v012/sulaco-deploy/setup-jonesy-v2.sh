#!/bin/bash
# Jonesy Setup Script for Fedora-based Systems (DNF5)

check_step() {
    grep -q "$1" ~/setup.log 2>/dev/null
}

mark_step() {
    echo "$1" >> ~/setup.log
}

set -e

update_system() {
    echo "[+] Updating system..."
    dnf5 update -y
    mark_step "update_system"
}

install_all_tools() {
    echo "[+] Installing all development tools..."
    dnf5 install -y binutils boxes clang cppcheck cppman curl emacs figlet g++ gcc gdb git glibc-devel glibc-headers         java-17-openjdk-devel kernel-headers lldb make man-pages manpages-posix nano nodejs npm python3 python3-pip         rust rust-doc toilet vim
    mark_step "install_all_tools"
}

main() {
    check_step "update_system" || update_system
    check_step "install_all_tools" || install_all_tools
    echo "[✓] Jonesy setup complete."
}

main
