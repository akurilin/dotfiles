#!/bin/bash

export BUILD_DIR=`pwd`
export NGINX_INSTALLDIR=/usr/local/nginx
export VAR_DIR=/home/www/tmp

# some of these can be removed since we're not using those modules
# !!not specifying openssl folder here, will that work?
./configure \
  --prefix=${NGINX_INSTALLDIR} \
  --user=www \
  --group=www \
  --http-client-body-temp-path=${VAR_DIR}/client_body_temp \
  --http-proxy-temp-path=${VAR_DIR}/proxy_temp \
  --http-fastcgi-temp-path=${VAR_DIR}/fastcgi_temp \
  --without-http_uwsgi_module \
  --without-http_scgi_module \
  --without-http_browser_module \
  --without-mail_pop3_module \
  --without-mail_imap_module \
  --without-mail_smtp_module \
  --with-http_ssl_module \
  --with-http_realip_module \
  --with-http_stub_status_module \
