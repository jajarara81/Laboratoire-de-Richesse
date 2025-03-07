#!/bin/bash

# Variables
DUCKDNS_DOMAIN="vic34"
DUCKDNS_TOKEN="TON_TOKEN_DUCKDNS" # Remplace par ton vrai token DuckDNS
EMAIL="fabregalvincent43@gmail.com"

echo "🔄 Mise à jour du système..."
sudo apt update -y

echo "🔧 Installation des dépendances pour TA-Lib..."
sudo apt install -y build-essential libatlas-base-dev
sudo apt install -y libta-lib0 libta-lib-dev

echo "📥 Vérification et installation de TA-Lib..."
if ! python3 -c "import talib" &> /dev/null; then
    echo "📦 Installation de TA-Lib depuis les sources..."
    cd /tmp || exit
    git clone https://github.com/mrjbq7/ta-lib.git
    cd ta-lib || exit
    ./configure
    make
    sudo make install
    cd ..
    rm -rf ta-lib
    echo "✅ TA-Lib installé avec succès."
else
    echo "✅ TA-Lib est déjà installé."
fi

echo "🐍 Installation du package Python TA-Lib..."
pip install --upgrade pip
pip install TA-Lib

echo "🌍 Mise à jour de l'IP sur DuckDNS..."
DUCKDNS_RESPONSE=$(curl -s "https://www.duckdns.org/update?domains=$DUCKDNS_DOMAIN&token=$DUCKDNS_TOKEN&ip=")

if [[ "$DUCKDNS_RESPONSE" == "OK" ]]; then
    echo "✅ DuckDNS mis à jour avec succès."
else
    echo "❌ Échec de la mise à jour DuckDNS. Vérifie ton token et domaine."
    exit 1
fi

echo "🔎 Vérification de la résolution DNS..."
if dig "$DUCKDNS_DOMAIN.duckdns.org" | grep -q "SERVFAIL"; then
    echo "❌ Problème de résolution DNS détecté."
    exit 1
else
    echo "✅ DNS fonctionne correctement."
fi

echo "🛠 Redémarrage de Nginx..."
sudo systemctl restart nginx
sudo systemctl status nginx --no-pager

echo "🔑 Demande du certificat SSL avec Certbot..."
sudo certbot --nginx -d "$DUCKDNS_DOMAIN.duckdns.org" --non-interactive --agree-tos --email "$EMAIL"

if [[ $? -ne 0 ]]; then
    echo "❌ Échec de la demande de certificat SSL."
    cat /var/log/letsencrypt/letsencrypt.log
    exit 1
else
    echo "✅ Certificat SSL installé avec succès."
fi

echo "🚀 Tout est terminé !"
exit 0
	
