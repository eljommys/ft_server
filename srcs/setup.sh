service mysql start

chown www-data:www-data /var/www/html/ -R


echo -e "\033[1;32m____ ____ ___ ___ _ _  _ ____    ___  ____ ____ ____ _  _ _    ___ \033[0m"
echo -e "\033[1;32m[__  |___  |   |  | |\ | | __    |  \ |___ |___ |__| |  | |     |  \033[0m"
echo -e "\033[1;32m___] |___  |   |  | | \| |__]    |__/ |___ |    |  | |__| |___  |  \033[0m"
echo -e "\033[1;32m                                                                   \033[0m"
echo -e "\033[1;32m____ ____ _  _ ____ _ ____ _  _ ____ ____ ___ _ ____ _  _          \033[0m"
echo -e "\033[1;32m|    |  | |\ | |___ | | __ |  | |__/ |__|  |  | |  | |\ |          \033[0m"
echo -e "\033[1;32m|___ |__| | \| |    | |__] |__| |  \ |  |  |  | |__| | \|          \033[0m"
echo -e "\033[1;32m                                                                   \033[0m"

rm /etc/nginx/sites-enabled/default
mv default.conf /etc/nginx/conf.d/

mv info.php /var/www/html/


#phpMyAdmin
mkdir /var/www/html/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/html/phpmyadmin
rm /var/www/html/phpmyadmin/config.inc.php
mv /config.inc.php /var/www/html/phpmyadmin/config.inc.php
rm /phpMyAdmin-4.9.0.1-all-languages.tar.gz

#Databases
mysql -u root -p -e "CREATE DATABASE admins;"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON admins.* TO 'jserrano'@'localhost' IDENTIFIED BY '123';"
mysql -u root -p -e "FLUSH PRIVILEGES;"

mysql -u root -p -e "CREATE DATABASE wordpress;"
mysql -u root -p -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'jserrano'@'localhost' IDENTIFIED BY '123';"
mysql -u root -p -e "FLUSH PRIVILEGES;"

#Installing wordpress
mv /wordpress.tar.gz /var/www/html/
cd /var/www/html/
tar -xvzf wordpress.tar.gz
rm wordpress.tar.gz
cd /
mv /wp-config.php /var/www/html/wordpress
chown -R www-data:www-data /var/www/html/wordpress
mv /wordpress.conf /etc/nginx/sites-available/wordpress.conf
ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled/

#SSL
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/jserrano.pem -keyout /etc/nginx/ssl/jserrano.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=rchallie/CN=jserrano"

rm /var/www/html/index.nginx-debian.html

service php7.3-fpm start
service nginx start

bash
