FROM debian:bullseye

RUN apt update && apt upgrade -y && \
    apt install -y \
    inetutils-ping \
    nginx \
    openssl \
    curl && \
    mkdir -p /var/www/html \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

COPY tools/nginx.conf /etc/nginx/nginx.conf

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/cert.key -out /etc/ssl/certs/cert.crt \
    -subj "/C=CA/ST=QC/L=Levis/O=42/OU=42/CN=mkramer.42.fr"

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
