#!/bin/bash

set -euo pipefail

readonly BLUE='\033[0;34m'
readonly GREEN='\033[0;32m'
readonly NC='\033[0m'

print_success() {
  echo -e "${GREEN}SUCCESS: ${NC}$1"
}

print_info() {
  echo -e "${BLUE}INFO: ${NC}$1"
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

# Uninstall all conflicting packages:
print_info "Uninstalling all conflicting packages"
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
  sudo apt-get remove $pkg
done
print_success "Uninstalled all conflicting packages"

# Add Docker's official GPG key:
print_info "Adding Docker's official GPG key"
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
print_success "Added Docker's official GPG key"

# Add the repository to Apt sources:
print_info "Adding the repository to Apt sources"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt-get update
print_success "Added the repository to Apt sources"

# Install Docker Engine, containerd, and Docker Compose:
print_info "Installing Docker Engine, containerd, and Docker Compose"
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
print_success "Docker and Docker Compose are installed"

# Add the current user to the docker group
if ! groups "$USER" | grep -q "docker"; then
  print_info "Adding current user to the docker group"
  sudo groupadd docker
  sudo usermod -aG docker $USER
  print_success "Added current user to the docker group"
fi

# Enable and start Docker service
print_info "Enabling and starting Docker service"
sudo systemctl enable docker
sudo systemctl start docker
print_success "Docker service is enabled and started"

# Reboot the system
if ask_for_reboot; then
  print_info "Rebooting the system..."
  sudo reboot
  print_success "System rebooted"
fi
