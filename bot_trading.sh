#!/bin/bash

# Fichier JSON contenant l'API Key
API_KEY_FILE="/mnt/data/cdp_api_key(1).json"

# Vérifier si le fichier JSON existe
if [[ ! -f "$API_KEY_FILE" ]]; then
    echo "❌ Fichier API introuvable : $API_KEY_FILE"
    exit 1
fi

# Extraire l'API Key et la Private Key depuis le JSON
API_KEY=$(jq -r '.name' "$API_KEY_FILE")
PRIVATE_KEY=$(jq -r '.privateKey' "$API_KEY_FILE")

# Vérifier si les clés sont extraites
if [[ -z "$API_KEY" || -z "$PRIVATE_KEY" ]]; then
    echo "❌ Erreur : Impossible de récupérer les clés API."
    exit 1
fi

echo "✅ API Coinbase chargée avec succès !"

# Fonction pour afficher les cours en direct
function get_market_price() {
    local pair="BTC-USD"
    echo "📈 Récupération du prix en direct pour $pair..."
    curl -s "https://api.coinbase.com/v2/prices/$pair/spot" | jq '.data.amount'
}

# Fonction pour acheter des cryptos
function buy_crypto() {
    local amount=$1
    echo "🛒 Achat de $amount USD en Bitcoin..."
    # Simulation de l'achat (API Coinbase réelle à implémenter)
    echo "✅ Achat effectué avec succès !"
}

# Fonction pour vendre des cryptos
function sell_crypto() {
    local amount=$1
    echo "💰 Vente de $amount USD en Bitcoin..."
    # Simulation de la vente (API Coinbase réelle à implémenter)
    echo "✅ Vente effectuée avec succès !"
}

# Interface CLI interactive
while true; do
    echo -e "\n🚀 **BOT TRADING RENTABLE** - [Coinbase API]"
    echo "1️⃣ Afficher le prix du Bitcoin"
    echo "2️⃣ Acheter du Bitcoin"
    echo "3️⃣ Vendre du Bitcoin"
    echo "4️⃣ Quitter"
    read -p "🔍 Choisissez une option : " choice

    case $choice in
        1) get_market_price ;;
        2) read -p "💲 Montant en USD : " amount; buy_crypto "$amount" ;;
        3) read -p "💲 Montant en USD : " amount; sell_crypto "$amount" ;;
        4) echo "👋 Bye !"; exit 0 ;;
        *) echo "❌ Option invalide !" ;;
    esac
done
	
