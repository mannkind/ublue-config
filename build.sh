#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages
bash /tmp/1password.sh

#### Example for enabling a System Unit File

systemctl enable podman.socket
