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
ufw status
echo "[✔] Firewall setup"
