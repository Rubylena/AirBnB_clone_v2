#!/usr/bin/env bash
#set up your web servers for the deployment of web_static

if [ 'dpkg -l | grep -c nginx' eq 0 ]
then
	apt-get update -y
	apt-get install -y nginx
fi

mkdir -p /data/web_static/releases/test/index.html
mkdir -p /data/web_static/shared/
ln -s -f /data/web_static/releases/test/ /data/web_static/current
chown -R $USER:$USER /data/
echo 'Hello there!!!' > /data/web_static/releases/test/index.html
echo "server {
    listen 80;
    listen [::]:80;
    
    location / {
        alias /data/web_static/current
    }

    location / {
    	proxy_pass http://graceeffiong.tech:80;
    }
}" > /etc/nginx/sites-available/hbnb
sed -i
service nginx restart
