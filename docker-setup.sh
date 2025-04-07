#!/bin/bash

set -euo pipefail

source common.sh

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

if ! check_if_package_is_installed docker "Docker"; then
  print_error "Docker is not installed"
  exit 1
fi

if ! check_if_package_is_installed docker-compose "Docker Compose"; then
  print_error "Docker Compose is not installed"
  exit 1
fi

print_success "Docker and Docker Compose are installed"
