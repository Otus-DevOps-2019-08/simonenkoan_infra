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

## HW4 GCP testapp
Установка Google Cloud SDK и создание нового инстанса reddit-app

gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure

### reddit-app-host
testapp_IP = 34.89.173.213 testapp_port = 9292

### Подключение к серверу ssh appuser@reddit-app

### Установка Ruby и Bundler

$ sudo apt update 
$ sudo apt install -y ruby-full ruby-bundler build-essential

ruby 2.3.1p112 (2016-04-26) [x86_64-linux-gnu] 
Bundler version 1.11.2

Установка MongoDB

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list' 
sudo apt update 
sudo apt install -y mongodb-org 
sudo systemctl start mongod 
sudo systemctl enable mongod

### Деплой приложения

### Выполнить в домашней директории 
appuser git clone -b monolith https://github.com/express42/reddit.git 
### Устанавливаем зависимости приложения 
cd reddit && bundle install 

### Запуск СП 
puma -d 

### Проверка порта 
ps aux | grep puma 9292

### Открываем порт в файрволе (GPC) Для проверки перейти http://34.89.173.213:9292/

Создаем исполняемые скрипты для запуска команд выше (*.sh) Копируем на наш инстанс все необходимые файлы scp install_ruby.sh appuser@reddit-app:/home/appuser/
Создание инстансов и установка необходимого ПО
gcloud compute instances create reddit-app
--boot-disk-size=10GB
--image-family ubuntu-1604-lts
--image-project=ubuntu-os-cloud
--machine-type=g1-small
--tags puma-server
--restart-on-failure --metadata-from-file startup-script-url=/home/appuser/startup_script.sh
Работа с правилами
default-puma-server
gcloud compute firewall-rules create default-puma-server
--allow=tcp:9292
--source-ranges="0.0.0.0/0"
--target-tags=puma-server \
