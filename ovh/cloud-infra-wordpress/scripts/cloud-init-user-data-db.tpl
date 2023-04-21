#!/bin/bash
install_dir="/var/www/html"

#Creating Random WP Database Credenitals
db_name="wp`date +%s`"
db_user=$db_name
db_password=`date |md5sum |cut -c '1-12'`
sleep 1
mysqlrootpass=`date |md5sum |cut -c '1-12'`
sleep 1

# Update
sudo apt update -y

# Install for mysql
sudo apt -y install mysql-server

#### Start mysql and set root password
sudo systemctl enable mysql
sudo systemctl start mysql

sudo mysql -e "USE mysql;"
sudo mysql -e "UPDATE user SET Password=PASSWORD($mysqlrootpass) WHERE user='root';"
sudo mysql -e "FLUSH PRIVILEGES;"
sudo touch /root/.my.cnf
sudo chmod 640 /root/.my.cnf
echo "[client]">>/root/.my.cnf
echo "user=root">>/root/.my.cnf
echo "password="$mysqlrootpass>>/root/.my.cnf

sudo mysql -u root -e "CREATE DATABASE $db_name"
sudo mysql -u root -e "CREATE USER '$db_name'@'localhost' IDENTIFIED WITH mysql_native_password BY '$db_password';"
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'localhost';"
 
######Display generated passwords to log file.
echo "Database Name: " $db_name
echo "Database User: " $db_user
echo "Database Password: " $db_password
echo "Mysql root password: " $mysqlrootpass

sudo useradd -m ebenchekroun
echo "ebenchekroun:ebenchekroun" | chpasswd
sudo usermod -aG sudo ebenchekroun
sudo usermod -aG sudo ebenchekroun