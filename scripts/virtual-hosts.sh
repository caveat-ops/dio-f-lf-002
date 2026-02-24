#!/bin/bash

set -e

if [ -f .env ]; then
    source .env
fi

SITE_NAME=${1:-${SITE1_NAME:-site1.localhost}}
DOC_ROOT=${2:-/var/www/html/site1}

echo "=========================================="
echo "  Configurando Virtual Host: $SITE_NAME  "
echo "=========================================="

VHOST_FILE="/etc/apache2/sites-available/${SITE_NAME}.conf"

cat > "$VHOST_FILE" <<EOF
<VirtualHost *:80>
    ServerName $SITE_NAME
    ServerAlias www.$SITE_NAME
    DocumentRoot $DOC_ROOT

    <Directory $DOC_ROOT>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/${SITE_NAME}_error.log
    CustomLog \${APACHE_LOG_DIR}/${SITE_NAME}_access.log combined
</VirtualHost>
EOF

a2ensite "${SITE_NAME}.conf"
systemctl reload apache2

echo ""
echo "Virtual Host '$SITE_NAME' criado com sucesso!"
echo "DocumentRoot: $DOC_ROOT"
