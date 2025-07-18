#!/bin/bash
# Hicks Setup Script for Debian-based Systems (APT)

check_step() {
    grep -q "$1" ~/setup.log 2>/dev/null
}

mark_step() {
    echo "$1" >> ~/setup.log
}

set -e

update_system() {
    echo "[+] Updating system..."
    apt update && apt upgrade -y
    mark_step "update_system"
}

install_all_tools() {
    echo "[+] Installing all development tools..."
    apt install -y build-essential clang cppcheck curl default-jdk default-jdk-doc emacs figlet g++ gcc gdb git lldb         make man-db manpages-dev manpages-posix nano nodejs npm openjdk-17-jdk python3 python3-pip rust-doc rustc         toilet boxes vim cppman
    mark_step "install_all_tools"
}

main() {
    check_step "update_system" || update_system
    check_step "install_all_tools" || install_all_tools
    echo "[✓] Hicks setup complete."
}

main
