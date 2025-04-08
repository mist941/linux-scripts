#! /bin/bash

set -euo pipefail

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[0;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

print_error() {
  echo -e "${RED}ERROR: ${NC}$1" >&2
}

print_success() {
  echo -e "${GREEN}SUCCESS: ${NC}$1"
}

print_warning() {
  echo -e "${YELLOW}WARNING: ${NC}$1"
}

print_info() {
  echo -e "${BLUE}INFO: ${NC}$1"
}

check_if_package_is_installed() {
  if dpkg -s "$1" &>/dev/null; then
    true
  else
    false
  fi
}

ask_for_reboot() {
  while true; do
    read -rp "Do you want to reboot the system now? (y/n): " answer
    case ${answer:0:1} in
    y | Y)
      return 0
      ;;
    n | N)
      return 1
      ;;
    *)
      print_warning "Please enter 'y' for yes or 'n' for no"
      ;;
    esac
  done
}
