#!/bin/bash

#install consul client pkg

yum update -y
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
yum install -y consul

#Move consul executable to /usr/bin directory to be accessible system-wide.
sudo mv consul /usr/bin/

#Create consul config directories.
sudo mkdir -p /etc/consul.d/client
sudo mkdir /var/consul

#Create consul config jason file
sudo touch /etc/consul.d/client/config.json

#add config to jason file
cat << EOF > /etc/consul.d/client/config.json
{
    "server": false,
    "datacenter": "us-east-1",
    "data_dir": "/var/consul",
    "encrypt": "gsdfHJ3KZvpC/Zsdf9JZSTQQ==",
    "log_level": "INFO",
    "enable_syslog": true,
    "leave_on_terminate": true,
    "start_join": [
        "10.128.0.3"
    ]
}

EOF

#Create a consul client service file.
sudo touch /etc/systemd/system/consul-client.service

#add config
cat << EOF > etc/systemd/system/consul-client.service
[Unit]
Description=Consul Startup process
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash -c '/usr/bin/consul agent -config-dir /etc/consul.d/client'
TimeoutStartSec=0

[Install]
WantedBy=default.target
EOF

#Reload system daemon & start consul-client
sudo systemctl daemon-reload
sudo systemctl start consul-client
