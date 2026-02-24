#!/bin/bash

set -e

echo "=========================================="
echo "         Script de Rollback              "
echo "=========================================="
echo ""
echo "ATENÇÃO: Isso removerá todas as configurações"
echo "do Apache e certificados SSL."
echo ""

read -p "Continuar? (s/N): " confirm

if [ "$confirm" != "s" ] && [ "$confirm" != "S" ]; then
    echo "Rollback cancelado."
    exit 0
fi

echo "[1/5] Removendo sites configurados..."
a2dissite default-ssl 2>/dev/null || true
rm -f /etc/apache2/sites-available/*-ssl.conf 2>/dev/null || true
rm -f /etc/apache2/sites-enabled/*-ssl.conf 2>/dev/null || true

echo "[2/5] Desabilitando módulos..."
a2dismod ssl 2>/dev/null || true
a2dismod headers 2>/dev/null || true

echo "[3/5] Removendo certificados Let's Encrypt..."
certbot delete --non-interactive --agree-up 2>/dev/null || true

echo "[4/5] Parando Apache..."
systemctl stop apache2 2>/dev/null || true
apt-get remove -y apache2 2>/dev/null || true

echo "[5/5] Limpando arquivos temporários..."
rm -rf /var/www/html/site1
rm -rf /var/www/html/siteecho "=========================================="
echo "2

echo ""
  Rollback concluído com sucesso!        "
echo "=========================================="
