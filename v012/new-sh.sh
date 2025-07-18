#!/bin/bash
# bash-wrapper-template.sh
# Generic CLI script wrapper with full flag parsing support
# Supports: short options, long options, combined flags, and key-value args

show_help() {
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "  -a VALUE     Short option with value"
  echo "  -b           Short flag (no value)"
  echo "  -c           Another short flag"
  echo "  -h, --help   Show this help message"
  echo "  --all VALUE  Long option with value"
  echo "  --break      Long flag (no value)"
  echo "  -xyz         Combined short flags (-x -y -z)"
  echo
  echo "Example:"
  echo "  $0 -a alpha -b --all /some/file --break"
  exit 0
}

# Default values
opt_a=""
flag_b=false
flag_c=false
long_all=""
flag_break=false

# Parse long options and shift out values
while [[ $# -gt 0 ]]; do
  case "$1" in
    -a)
      opt_a="$2"
      shift 2
      ;;
    -b)
      flag_b=true
      shift
      ;;
    -c)
      flag_c=true
      shift
      ;;
    --all)
      long_all="$2"
      shift 2
      ;;
    --break)
      flag_break=true
      shift
      ;;
    -h|--help)
      show_help
      ;;
    --*)
      echo "[!] Unknown long option: $1"
      show_help
      ;;
    -*)
      # Handle combined short flags like -abc
      opt_str="${1:1}"
      for (( i=0; i<${#opt_str}; i++ )); do
        case "${opt_str:$i:1}" in
          a) ;; # handled above
          b) flag_b=true ;;
          c) flag_c=true ;;
          h) show_help ;;
          *) echo "[!] Unknown flag: -${opt_str:$i:1}"; show_help ;;
        esac
      done
      shift
      ;;
    *)
      echo "[!] Unrecognized argument: $1"
      show_help
      ;;
  esac
done

# === DEBUG/LOGGING OUTPUT ===
echo "[DEBUG] Option -a: $opt_a"
echo "[DEBUG] Flag -b: $flag_b"
echo "[DEBUG] Flag -c: $flag_c"
echo "[DEBUG] Long --all: $long_all"
echo "[DEBUG] Flag --break: $flag_break"

# === PLACE YOUR SCRIPT LOGIC BELOW THIS LINE ===
# Example:
# if $flag_b; then echo "Option -b was set"; fi
