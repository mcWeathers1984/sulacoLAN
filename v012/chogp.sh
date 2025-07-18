#!/bin/bash
# chogp: Change owner, group, and permissions for a file or directory

# Check for root
if [[ "$EUID" -ne 0 ]]; then
  echo "[!] Please run as root (sudo required)"
  exit 1
fi

# Function to prompt interactively
interactive_mode() {
  read -rp "Enter full path to file or directory: " target
  read -rp "Enter owner (user): " owner
  read -rp "Enter group: " group
  read -rp "Enter permissions (e.g., 0754): " perms

  chown "$owner:$group" "$target"
  chmod "$perms" "$target"

  echo "[✓] Updated: $target"
  echo "      Owner: $owner"
  echo "      Group: $group"
  echo " Permissions: $perms"
}

# Main logic
if [[ $# -eq 0 ]]; then
  interactive_mode
elif [[ $# -eq 1 ]]; then
  target="$1"
  chown mikew:developers "$target"
  chmod 0754 "$target"
  echo "[✓] Set mikew:developers and 0754 on: $target"
elif [[ $# -eq 4 ]]; then
  target="$1"
  owner="$2"
  group="$3"
  perms="$4"

  chown "$owner:$group" "$target"
  chmod "$perms" "$target"
  echo "[✓] Updated: $target"
  echo "      Owner: $owner"
  echo "      Group: $group"
  echo " Permissions: $perms"
else
  echo "Usage:"
  echo "  sudo chogp                    # interactive mode"
  echo "  sudo chogp /path/to/item      # uses mikew:developers and 0754"
  echo "  sudo chogp /path owner group permissions"
  exit 1
fi
