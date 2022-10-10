#Time to practice configuring your server with Puppet! Just as 
#you did before, we’d like you to install and configure an Nginx
#server using Puppet instead of Bash.
#create web_static folder

$nginx_congf = "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By $HOSTNAME;
    root   /var/www/html;
    index  index.html index.htm index.nginx-debian.html;
    server_name _;
    
    location /hbnb_static/ {
        alias /data/web_static/current/;
	index index.html index.htm;
	autoindex off;
    }
    location /redirect_me {
        return 301 http://graceeffiong.tech;
    }
    error_page 404 /404.html;
    location /404 {
      root /var/www/error;
      internal;
    }
}"

package { 'nginx':
  ensure   => 'present',
  provider => 'apt',
} ->

file { '/data':
  ensure  => 'directory'
} ->

file { '/data/web_static':
  ensure  => 'directory'
} ->

file { '/data/web_static/releases':
  ensure  => 'directory'
} ->

file { '/data/web_static/releases/test':
  ensure  => 'directory'
} ->

file{ '/data/web_static/shared':
  ensure  => 'directory'
} ->

file { '/data/web_static/releases/test/index.html':
  ensure  => 'present',
  content => "School puppet content\n"
} ->

file { '/data/web_static/current':
  ensure   => 'link',
  target   => '/data/web_static/releases/test'
} ->

exec { 'chown -R ubuntu:ubuntu /data/':
  path    => '/usr/bin/:/usr/local/bin/:/bin/'
}

file { '/var/www':
  ensure => 'directory'
} ->

file { '/var/www/html':
  ensure => 'directory'
} ->

file { '/var/www/html/index.html':
  ensure  => 'present',
  content => "Holberton School Nginx\n"
} ->

file { '/var/www/html/404.html':
  ensure  => 'present',
  content => "Ceci n'est pas une page\n"
} ->

file { '/etc/nginx/sites-available/default':
  ensure  => 'present',
  content => '$nginx_congf
} ->

exec { 'service ginx restart':
  path    => '/etc/init.d/nginx'
}
