#!/bin/bash

# keep in mind that /var/nginx needs to be created before setup
export BUILD_DIR=`pwd`
export NGINX_INSTALLDIR=/usr/local/nginx
export VAR_DIR=/var/nginx

# some of these can be removed since we're not using those modules
./configure \
  --prefix=${NGINX_INSTALLDIR} \
  --user=www-data \
  --group=www-data \
  --http-client-body-temp-path=${VAR_DIR}/client_body_temp \
  --http-proxy-temp-path=${VAR_DIR}/proxy_temp \
  --without-http_uwsgi_module \
  --without-http_scgi_module \
  --without-http_browser_module \
  --without-mail_pop3_module \
  --without-mail_imap_module \
  --without-mail_smtp_module \
  --with-http_ssl_module \
  --with-http_realip_module \
  --with-http_stub_status_module \
