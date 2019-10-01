# simonenkoan_infra
simonenkoan Infra repository

## HW3. GCP: Bastion Host, Pritunl VPN.

### Bastion-host
bastion_IP = 34.89.137.173 someinternalhost_IP = 10.156.0.4

### SSH Forwarding:
$ ssh-add -L

### Key:
$ ssh-add ~/.ssh/id_ed25519

### SSH Connection:
$ ssh -i ~/.ssh/id_ed25519 -A sansim@34.89.137.173
$ ssh 10.156.0.4

Чтобы подключиться одной строкой к someinternalhost:
$ ssh -i ~/.ssh/id_ed25519 -A sansim@34.89.223.37 -tt ssh 10.156.0.4

Чтобы подключиться к someinternalhost через команду - ssh someinternalhost - добавлены .ssh/config:

Host bastion
  Hostname 34.89.137.173
  User sansim
  IdentityFile ~/.ssh/id_ed25519

Host someinternalhost
  Hostname 10.156.0.4
  User sansim
  ProxyCommand ssh -W %h:%p bastion
  IdentityFile ~/.ssh/id_ed25519

# VPN
Для сервера на VPC настроено правило для Firewall , разрешаюшее входящий трафик 11498/udp
Файл setupvpn.sh описывает установку VPN-сервера, устанавливает mongod и pritunl
Файл cloud-bastion.ovpn - конф файл для настройки OpenVPN клиента
