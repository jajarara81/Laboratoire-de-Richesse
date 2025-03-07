#!/bin/bash

# 🚀 Laboratoire de Richesse - Bot de Trading Coinbase

# 📍 Définition du fichier API
API_KEY_FILE="/home/vincent/Bureau/cdp_api_key(1).json"

# 🛡️ Vérification de l'existence du fichier API
if [ ! -f "$API_KEY_FILE" ]; then
    echo "❌ Erreur : Fichier API introuvable à l'emplacement $API_KEY_FILE"
    exit 1
fi

# 🔑 Extraction correcte de la clé API
API_KEY=$(jq -r '.privateKey' "$API_KEY_FILE")

# ✅ Vérification de l'extraction
if [ -z "$API_KEY" ] || [ "$API_KEY" == "null" ]; then
    echo "❌ Erreur : Impossible d'extraire la clé API du fichier JSON."
    exit 1
fi

# 🌐 Vérification de la connexion Internet
echo "🔍 Test de connexion à Internet..."
ping -c 2 api.coinbase.com &> /dev/null
if [ $? -ne 0 ]; then
    echo "⚠️ Erreur : Impossible de joindre l'API Coinbase. Vérifie ta connexion."
    exit 1
fi

# 🔄 Vérification du statut de l'API
echo "🔗 Connexion à l'API Coinbase..."
API_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "https://api.coinbase.com/v2/accounts")

if [ "$API_STATUS" -ne 200 ]; then
    echo "⚠️ Erreur : Connexion à l'API Coinbase échouée (Code HTTP: $API_STATUS)."
    echo "📢 Vérifie si l'API est active sur https://status.coinbase.com/"
    exit 1
else
    echo "✅ Connexion réussie à l'API Coinbase !"
fi

# 📈 Démarrage du trading automatique
echo "📊 Exécution du bot de trading..."
TRADE_RESPONSE=$(curl -s -X POST "https://api.coinbase.com/v2/accounts"
    -H "Authorization: Bearer $API_KEY"
    -H "Content-Type: application/json"
    -d '{"amount": "50.00", "currency": "EUR", "payment_method": "bank"}')

# 🔍 Vérification du résultat
if echo "$TRADE_RESPONSE" | grep -q "error"; then
    ERROR_MSG=$(echo "$TRADE_RESPONSE" | jq -r '.error.message')
    echo "❌ Erreur lors du trading : $ERROR_MSG"
    exit 1
else
    echo "✅ Trading réussi !"
    echo "📊 Résultat : $(echo "$TRADE_RESPONSE" | jq -r '.data')"
fi

# 📢 Envoi d'un rapport par e-mail
echo "📩 Envoi du rapport de trading..."
echo "Le bot de trading a exécuté une transaction avec succès !" | mail -s "Rapport de Trading" fabregalvincent43@gmail.com

echo "✅ Script terminé avec succès ! 🚀💰"
exit 0
	
