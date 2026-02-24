#!/bin/bash

set -e

DOMAIN=${1}
EMAIL=${2:-admin@localhost}

if [ -z "$DOMAIN" ]; then
    echo "Uso: $0 <dominio> <email>"
    echo "Exemplo: $0 exemplo.com admin@exemplo.com"
    exit 1
fi

if [ -f .env ]; then
    source .env
fi

echo "=========================================="
echo "  Configurando SSL/HTTPS para $DOMAIN  "
echo "=========================================="

echo "[1/3] Parando Apache..."
systemctl stop apache2

echo "[2/3] Gerando certificado Let's Encrypt..."
certbot certonly --standalone \
    --agree-tos \
    --email "$EMAIL" \
    -d "$DOMAIN" \
    -d "www.$DOMAIN"

echo "[3/3] Configurando Apache com SSL..."
SSL_CONF="/etc/apache2/sites-available/${DOMAIN}-ssl.conf"

cat > "$SSL_CONF" <<EOF
<VirtualHost *:443>
    ServerName $DOMAIN
    ServerAlias www.$DOMAIN
    DocumentRoot /var/www/html

    SSLEngine on
    SSLCertificateFile /etc/letsencrypt/live/$DOMAIN/fullchain.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/$DOMAIN/privkey.pem

    <Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/${DOMAIN}_ssl_error.log
    CustomLog \${APACHE_LOG_DIR}/${DOMAIN}_ssl_access.log combined
</VirtualHost>
EOF

a2enmod ssl
a2ensite "${DOMAIN}-ssl.conf"
systemctl restart apache2

echo ""
echo "=========================================="
echo "  SSL/HTTPS configurado com sucesso!     "
echo "=========================================="
echo ""
echo "Acesse: https://$DOMAIN"
echo ""
echo "Certificado válido por 90 dias."
echo "Renove com: certbot renew"
