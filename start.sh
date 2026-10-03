#!/bin/sh
PORT="${PORT:-80}"
sed "s/__PORT__/${PORT}/" /etc/nginx/default.conf.template > /etc/nginx/http.d/default.conf

cat > /usr/local/etc/php-fpm.d/zz-env.conf <<EOF
[www]
clear_env = no
env[MYSQLHOST] = "${MYSQLHOST}"
env[MYSQLPORT] = "${MYSQLPORT}"
env[MYSQLUSER] = "${MYSQLUSER}"
env[MYSQLPASSWORD] = "${MYSQLPASSWORD}"
env[MYSQLDATABASE] = "${MYSQLDATABASE}"
EOF

php-fpm -D
exec nginx -g 'daemon off;'
