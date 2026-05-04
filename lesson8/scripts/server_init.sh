sudo apt update
sudo apt install -y apache2 openssl

sudo cp /vagrant/openssl.cnf .
openssl req -newkey rsa:2048 -nodes -keyout /etc/ssl/private/lesson8.key \
	-x509 -days 365 -out /etc/ssl/certs/lesson8.crt \
	--config openssl.cnf -extensions v3_req
sudo cp /etc/ssl/certs/lesson8.crt /vagrant/

sudo mkdir -p /opt/apache2/www/lesson8.local/
sudo cp /vagrant/apache2/lesson8.html /opt/apache2/www/lesson8.local/
sudo chown -R www-data:www-data /opt/apache2/www/lesson8.local/
sudo chmod -R 755 /opt/apache2/www/lesson8.local/

sudo cp /vagrant/apache2/lesson8.conf /etc/apache2/sites-available/
sudo a2dissite 000-default.conf
sudo a2ensite lesson8.conf

sudo a2enmod ssl
sudo systemctl reload apache2
