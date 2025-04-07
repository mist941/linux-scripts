#! /bin/bash

set -euo pipefail

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[0;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

print_error() {
  echo -e "${RED}ERROR: $1${NC}" >&2
}

print_success() {
  echo -e "${GREEN}SUCCESS: $1${NC}"
}

print_warning() {
  echo -e "${YELLOW}WARNING: $1${NC}"
}

print_info() {
  echo -e "${BLUE}INFO: $1${NC}"
}

check_if_package_is_installed() {
  if dpkg -s "$1" &>/dev/null; then
    echo "$2 is already installed"
  fi
}
