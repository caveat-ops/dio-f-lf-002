#!/bin/bash

set -e

echo "=========================================="
echo "  Provisionador de Servidor Web Apache  "
echo "=========================================="
echo ""

if [ -f .env ]; then
    source .env
else
    echo "Erro: Arquivo .env não encontrado"
    exit 1
fi

echo "[1/5] Atualizando sistema..."
apt-get update -qq

echo "[2/5] Instalando Apache2..."
apt-get install -y apache2

echo "[3/5] Habilitando módulos necessários..."
a2enmod ssl rewrite headers socache_shmcb

echo "[4/5] Configurando Virtual Hosts..."
cp config/apache2/sites-available/000-default.conf /etc/apache2/sites-available/
cp config/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/
a2ensite default-ssl

echo "[5/5] Iniciando Apache..."
systemctl restart apache2
systemctl enable apache2

echo ""
echo "=========================================="
echo "  Servidor Apache provisionado com sucesso!"
echo "=========================================="
echo ""
echo "Acesse: http://${SERVER_NAME:-localhost}"
echo "Sites:  http://${SITE1_NAME:-site1.localhost}"
echo "        http://${SITE2_NAME:-site2.localhost}"
