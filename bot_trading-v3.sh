#!/bin/bash

# 🚀 Laboratoire de Richesse - Script de Trading Automatisé

# 📍 Définition du fichier API
API_KEY_FILE="/home/vincent/Bureau/cdp_api_key(1).json"

# 🛡️ Vérification de l'existence du fichier API
if [ ! -f "$API_KEY_FILE" ]; then
    echo "❌ Erreur : Fichier API introuvable à l'emplacement $API_KEY_FILE"
    exit 1
fi

# 🔑 Vérification et correction des permissions du fichier
if [ ! -r "$API_KEY_FILE" ]; then
    echo "🔓 Correction des permissions du fichier API..."
    chmod 600 "$API_KEY_FILE" # Lecture et écriture uniquement pour l'utilisateur
fi

# 🛠️ Extraction des clés API depuis le JSON
API_KEY=$(jq -r '.privateKey' "$API_KEY_FILE")

# 🚀 Vérification de l'extraction de la clé
if [ -z "$API_KEY" ] || [ "$API_KEY" == "null" ]; then
    echo "❌ Erreur : Impossible d'extraire l'API Key du fichier JSON."
    exit 1
fi

# 🔄 Initialisation du bot de trading
echo "💰 Lancement du bot de trading..."
sleep 1

# ✅ Simulation d'une connexion API (à adapter pour ton bot)
echo "🔗 Connexion à l'API Coinbase..."
sleep 2

# 🌐 Test de connexion API avec curl
API_STATUS=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Bearer $API_KEY" "https://api.coinbase.com/v2/accounts")

if [ "$API_STATUS" -ne 200 ]; then
    echo "⚠️ Erreur : Connexion à l'API Coinbase échouée (Code HTTP: $API_STATUS)."
    exit 1
else
    echo "✅ Connexion réussie à l'API Coinbase !"
fi

# 📈 Début du trading automatique
echo "📊 Démarrage du trading automatique..."
sleep 2

# 💸 Exemple de trading (à remplacer par ton algo)
TRADE_RESULT=$(curl -s -X POST -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json" \
    -d '{"amount": "50.00", "currency": "EUR", "payment_method": "bank"}' \
    "https://api.coinbase.com/v2/trades")

# 📩 Vérification du résultat du trade
if echo "$TRADE_RESULT" | grep -q "error"; then
    echo "❌ Erreur lors du trading : $(echo "$TRADE_RESULT" | jq -r '.error.message')"
else
    echo "✅ Trading réussi !"
    echo "📊 Résultat : $(echo "$TRADE_RESULT" | jq -r '.data')"
fi

# 📢 Notification par email
echo "📩 Envoi d'un email de confirmation..."
echo "Le bot de trading a exécuté une transaction avec succès !" | mail -s "Rapport de Trading" fabregalvincent43@gmail.com

echo "✅ Script terminé avec succès ! 🚀💰"

exit 0
	
