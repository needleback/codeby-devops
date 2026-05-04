echo '192.168.56.104 lesson8.local www.lesson8.local' >> /etc/hosts

sudo apt update
sudo apt install -y openssl

sudo cp /vagrant/lesson8.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
