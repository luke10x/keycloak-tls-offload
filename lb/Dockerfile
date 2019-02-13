FROM nginx:latest

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./conf.d /etc/nginx/conf.d
COPY ./www/mitm /var/www/mitm

COPY ./certs /etc/ssl/certs

RUN ls /etc/ssl/certs -las


