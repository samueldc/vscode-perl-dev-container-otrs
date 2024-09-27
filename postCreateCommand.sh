#!/usr/bin/bash
#echo 'vscode ALL=(root) NOPASSWD:ALL' > /etc/sudoers.d/vscode && sudo chmod 0440 /etc/sudoers.d/vscode
#sudo -- bash -c "groupadd -g 5051 otrs && usermod -aG 5051 www-data && useradd -g 5051 -G 33 -u 5051 -M otrs && usermod -aG otrs,www-data vscode"
git config --global --add safe.directory ${PWD}