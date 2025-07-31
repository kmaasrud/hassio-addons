#!/usr/bin/with-contenv bashio
set -e

ADMIN_USER=$(bashio::config 'admin_user')
ADMIN_PASS=$(bashio::config 'admin_password')
IRC_PORT=$(bashio::config 'irc_port')
IRCS_PORT=$(bashio::config 'ircs_port')

CONFIG_FILE=/data/soju.conf
cat >"$CONFIG_FILE" <<EOF
listen unix+admin://
listen irc+insecure://0.0.0.0:$IRC_PORT
${IRCS_PORT:+listen ircs://0.0.0.0:$IRCS_PORT}
db sqlite3 /data/soju.db
EOF

sojuctl -config /data/soju.conf user create -admin \
	-username "$ADMIN_USER" -password "$ADMIN_PASS"

exec soju -config /data/soju.conf
