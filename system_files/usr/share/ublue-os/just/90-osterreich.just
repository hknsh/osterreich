[private]
default:
    @just --list

# Install flatpaks and brews
[group('Install')]
osterreich-install: osterreich-install-flatpaks osterreich-install-brews

[group('Install')]
osterreich-install-flatpaks:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Installing flatpaks..."
    xargs -a <(curl --retry 3 -sL https://raw.githubusercontent.com/hknsh/osterreich/main/repo_files/flatpaks) flatpak --system -y install
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

    if [ ! -f /var/lib/ufw/user.rules ]; then
        echo "Adding default files..."
        mkdir -p /var/lib/ufw
        cp /usr/share/ufw/iptables/user.rules /var/lib/ufw/user.rules
        cp /usr/share/ufw/iptables/user6.rules /var/lib/ufw/user6.rules
    fi

    systemctl stop firewalld
    systemctl disable firewalld
    systemctl mask firewalld

    systemctl enable ufw
    systemctl start ufw
    ufw enable

    ufw default deny incoming
    ufw default allow outgoing

    ufw delete allow SSH
    ufw deny 22/tcp
    ufw allow out dns
    ufw allow out ntp

    ufw allow from 192.168.0.0/24 to any port 3000 comment 'Web Server (LAN)'
    ufw allow from 192.168.0.0/24 to any port 3001 comment 'Web Server (LAN)'
    ufw allow from 192.168.0.0/24 to any port 8080 comment 'Web Server (LAN)'
    ufw allow from 192.168.0.0/24 to any port 8443 comment 'Web Server (LAN)'
    ufw allow from 192.168.0.0/24 to any port 5173 comment 'Web Server (LAN)'

    ufw allow from 192.168.0.0/24 to any port 1714:1764 proto tcp comment 'KDE Connect/tcp (LAN)'
    ufw allow from 192.168.0.0/24 to any port 1714:1764 proto udp comment 'KDE Connect/udp (LAN)'

    ufw allow in on lo to any port 22 proto tcp comment 'SSH/localhost'
    ufw allow from 192.168.0.0/24 to any port 22 proto tcp comment 'SSH/LAN'
    ufw allow in on lo to any port 9090 proto tcp comment 'Cockpit/localhost'
    ufw allow from 192.168.0.0/24 to any port 9090 proto tcp comment 'Cockpit/LAN'