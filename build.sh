#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1
cat > /etc/yum.repos.d/1password.repo << EOF
[1password]
name=1Password Stable Channel
baseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=0
#gpgkey="https://downloads.1password.com/linux/keys/1password.asc"
gpgkey=file:///etc/pki/rpm-gpg/1password.asc
EOF
wget https://downloads.1password.com/linux/keys/1password.asc -O /etc/pki/rpm-gpg/1password.asc

# this installs a package from fedora repos
rpm-ostree install screen

# this would install a package from rpmfusion
# rpm-ostree install vlc
rpm-ostree install 1password

#### Example for enabling a System Unit File

systemctl enable podman.socket
