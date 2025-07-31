#!/usr/bin/with-contenv bashio

mkdir -p /etc/soju
echo "listen irc+insecure://localhost" >>/etc/soju/config
echo "accept-proxy-ip localhost" >>/etc/soju/config

/usr/bin/soju
