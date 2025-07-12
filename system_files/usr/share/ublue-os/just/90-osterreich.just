[private]
default:
    @just --list

# Install flatpaks
[group('Install')]
osterreich-install: osterreich-install-flatpaks

[group('Install')]
osterreich-install-flatpaks:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Installing flatpaks..."
    xargs -a <(curl --retry 3 -sL https://raw.githubusercontent.com/hknsh/osterreich/main/repo_files/flatpaks) flatpaks --system -y install
    echo "Installation complete."

[group('Install')]
osterreich-install-brews:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Installing homebrews..."
    xargs -a <(curl --retry 3 -sL https://raw.githubusercontent.com/hknsh/osterreich/main/repo_files/brews) brew install
    echo "Installation complete."

[group('Setup')]
osterreich-configure-ufw:
    #!/usr/bin/env bash
    set -euo pipefail

    systemctl stop firewalld
    systemctl disable firewalld
    systemctl mask firewalld

    systemctl enable ufw
    systemctl start ufw
    ufw enable

    ufw default deny incoming
    ufw default allow outgoing

    ufw deny 22/tcp
    ufw allow out dns
    ufw allow out ntp

    ufw allow from 192.168.0.0/24 to any port 3000
    ufw allow from 192.168.0.0/24 to any port 3001
    ufw allow from 192.168.0.0/24 to any port 8080
    ufw allow from 192.168.0.0/24 to any port 8443
    ufw allow from 192.168.0.0/24 to any port 5173

    ufw allow 1714:1764/tcp
    ufw allow 1714:1764/udp

    ufw allow in on lo to any port 22 proto tcp comment 'SSH/localhost'
    ufw allow from 192.168.0.0/24 to any port 22 proto tcp comment 'SSH/LAN'
    ufw allow in on lo to any port 9090 proto tcp comment 'Cockpit/localhost'
    ufw allow from 192.168.0.0/24 to any port 9090 proto tcp comment 'Cockpit/LAN'