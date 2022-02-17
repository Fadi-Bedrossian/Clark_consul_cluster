#!/bin/bash

#install consul server pkg

yum update -y
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
yum install -y consul nginx tmux

#Move consul executable to /usr/bin directory to be accessible system-wide.
sudo mv consul /usr/bin/

#Create consul config server directory
cd ~; sudo mkdir -p consul-config/server

#Create consul config jason file
sudo touch consul-config/server/config.json

#get node_name in variable then assign it in config.jason file
nodename=$(hostname)
ipaddr=$(hostname -i)
#add config to jason file
cat << EOF > consul-config/server/config.json
{
"bootstrap": true,
"server": true,
"log_level": "DEBUG",
"enable_syslog": true,
"datacenter": "server1",
"addresses" : {
"http": "0.0.0.0"
},
"bind_addr": "$ipaddr",
"node_name": "$nodename",
"data_dir": "/home/k/consuldata",
"ui_dir": "/home/k/consul-ui",
"acl_datacenter": "server1",
"acl_default_policy": "allow",
"encrypt": "5KKufILrf186BGlilFDNig=="
}

EOF


sudo touch /etc/nginx/conf.d/consul.conf

#add config to jason file
cat << EOF > /etc/nginx/conf.d/consul.conf

server
{
listen 80 ;
server_name YourServerIP;
root /home/k/consul-ui;
location / {
proxy_pass http://127.0.0.1:8500;
proxy_set_header   X-Real-IP $remote_addr;
proxy_set_header   Host      $http_host;
}
}
EOF

#Reload system daemon & start consul-client
sudo systemctl daemon-reload
sudo systemctl enable nginx
sudo systemctl restart nginx

consul agent -config-dir ~/consul-config/server -ui-dir ~/consul-ui -bootstrap
true -client=0.0.0.0
