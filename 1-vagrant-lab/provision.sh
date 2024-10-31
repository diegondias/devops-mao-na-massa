#!/usr/bin/env bash

echo "instalando Apache e configurando..."
yum install -y httpd
cp -r /vagrant/html/* /var/www/html/
service httpd start