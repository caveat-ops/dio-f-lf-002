FROM debian:stable-slim

LABEL maintainer="seu-usuario@email.com"
LABEL description="Apache Web Server with Virtual Hosts and SSL support"

RUN apt-get update && apt-get install -y \
    apache2 \
    openssl \
    curl \
    certbot \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html/site1 /var/www/html/site2 \
    /var/log/apache2 \
    /var/run/apache2

COPY config/html/ /var/www/html/

RUN a2enmod ssl rewrite headers socache_shmcb

COPY config/apache2/ports.conf /etc/apache2/ports.conf

RUN sed -i 's|/var/www/html|/var/www/html|g' /etc/apache2/sites-available/000-default.conf || true
RUN cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.bak

COPY config/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY config/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

RUN a2ensite default-ssl 2>/dev/null || true

EXPOSE 80 443

CMD ["apache2ctl", "-D", "FOREGROUND"]
