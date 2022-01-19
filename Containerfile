FROM docker://nginx:mainline-alpine

USER root
WORKDIR /var/www/html

COPY . /usr/share/nginx/html