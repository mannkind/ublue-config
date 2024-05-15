#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

### Install 1Password
onepassword () {
  mkdir -p /var/opt # -p just in case it exists
  # for some reason...
  
  # Setup repo
  cat << EOF > /etc/yum.repos.d/1password.repo
  [1password]
  name=1Password ${RELEASE_CHANNEL^} Channel
  baseurl=https://downloads.1password.com/linux/rpm/${RELEASE_CHANNEL}/\$basearch
  enabled=1
  gpgcheck=1
  repo_gpgcheck=1
  gpgkey=https://downloads.1password.com/linux/keys/1password.asc
  EOF
  
  # Import signing key
  rpm --import https://downloads.1password.com/linux/keys/1password.asc
  
  # Now let's install the packages.
  rpm-ostree install 1password 1password-cli
  
  # Clean up the yum repo (updates are baked into new images)
  rm /etc/yum.repos.d/1password.repo -f
  
  # And then we do the hacky dance!
  mv /var/opt/1Password /usr/lib/1Password # move this over here
  
  # Create a symlink /usr/bin/1password => /opt/1Password/1password
  rm /usr/bin/1password
  ln -s /opt/1Password/1password /usr/bin/1password
}
onepassword

#### Example for enabling a System Unit File

systemctl enable podman.socket
