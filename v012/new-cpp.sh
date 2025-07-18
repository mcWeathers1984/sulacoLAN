#!/bin/bash
# new-cpp: Create a new C++ source file with permissions and ownership

# Check for root
if [[ "$EUID" -ne 0 ]]; then
  echo "[!] Please run as root (sudo required)"
  exit 1
fi

# Function to prompt for user input
prompt_file_info() {
  read -rp "Enter full path for new C++ file: " filepath
  if [[ "$use_defaults" == false ]]; then
    read -rp "Enter owner (user): " owner
    read -rp "Enter group: " group
    read -rp "Enter permissions (e.g., 0754): " perms
  else
    owner="root"
    group="root"
    perms="0754"
  fi
}

# Function to create and populate file
create_cpp_file() {
  mkdir -p "$(dirname "$filepath")"
  cat <<EOF > "$filepath"
#include <iostream>

int main() {
    std::cout << "Hello from C++!" << std::endl;
    return 0;
}
EOF

  chown "$owner:$group" "$filepath"
  chmod "$perms" "$filepath"
  echo "[✓] Created: $filepath"
  echo "      Owner: $owner"
  echo "      Group: $group"
  echo " Permissions: $perms"
}

# Flags and logic
use_defaults=false

while [[ "$1" != "" ]]; do
  case $1 in
    -f|--file) shift; filepath="$1" ;;
    -d|--default) use_defaults=true ;;
    -h|--help)
      echo "Usage: new-cpp [-f FILEPATH] [--default]"
      exit 0 ;;
    *) echo "[!] Unknown option: $1"; exit 1 ;;
  esac
  shift
done

# If filepath not provided, use interactive
if [[ -z "$filepath" ]]; then
  echo "[*] Interactive mode"
  read -rp "Use default owner/group/permissions (0754)? [y/n]: " yn
  [[ "$yn" =~ ^[Yy]$ ]] && use_defaults=true
  prompt_file_info
fi

create_cpp_file
