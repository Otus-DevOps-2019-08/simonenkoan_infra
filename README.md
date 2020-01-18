# simonenkoan_infra
simonenkoan Infra repository

## HW3. GCP: Bastion Host, Pritunl VPN.

### Bastion-host
  bastion_IP = 34.89.137.173  
  someinternalhost_IP = 10.156.0.4

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
Файл cloud-bastion.ovpn -  конф файл для настройки OpenVPN клиента



# ДЗ 5 "Модели управления инфраструктурой."
Ветка packer-base содержит реализацию тестового задания к уроку "Модели управления инфраструктурой."

### Установлен packer и go
### Установлено ADC для управления ресурсами GCP через API
### Создан и проверен на валидность шаблон для packer
### С помощью packer создан образ в GCP
### C помощью packer-образа создана ВМ и развернуто приложение
### Добавлен файл с примерами использования других переменных
### В  gitignore добавлен variables.json

