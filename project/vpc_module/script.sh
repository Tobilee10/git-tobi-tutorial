#!bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo " This is an app server in AWS Region US-WEST-2 " > /var/www/html/index.html