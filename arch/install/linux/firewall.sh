#
# Uncomplicated firewall
# pacman -S ufw --noconfirm
#
systemctl enable ufw
systemctl start ufw
systemctl status ufw
#
ufw enable
ufw default deny outgoing
ufw default deny incoming
ufw default deny routed
#
ufw allow out http
ufw allow out https
ufw allow out dns
ufw allow out ssh
ufw allow out on docker0
#
ufw allow 51413/tcp comment 'transmission-cli / peer-port'
ufw allow 51413/udp comment 'transmission-cli / peer-port'
ufw allow 6881/udp comment  'transmission-cli / DHT protocol (finding peers more quickly)'
ufw status
echo "[✔] Firewall setup"
