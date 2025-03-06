#!/bin/bash

### CONFIGURATION ###
GITHUB_USER="jajarara81"
GITHUB_REPO="Laboratoire-de-Richesse"
BOT_TOKEN="TON_TELEGRAM_BOT_TOKEN"
CHAT_ID="TON_CHAT_ID"
FLASK_PORT=5000

### MISE À JOUR DU SYSTÈME ###
echo "🔄 Mise à jour du système..."
sudo apt update -y && sudo apt upgrade -y

### INSTALLATION DES DÉPENDANCES ###
echo "🛠️ Installation des outils nécessaires..."
sudo apt install -y git curl wget python3-venv python3-pip nodejs npm jq

### CONFIGURATION GIT ###
echo "🔑 Vérification de la connexion SSH avec GitHub..."
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github_richesse

### SYNCHRONISATION GITHUB ###
echo "🔄 Synchronisation avec GitHub..."
cd "$HOME/Laboratoire-de-Richesse" || git clone git@github.com:$GITHUB_USER/$GITHUB_REPO.git "$HOME/Laboratoire-de-Richesse"
cd "$HOME/Laboratoire-de-Richesse" || exit 1
git pull origin main || echo "⚠️ Avertissement : Impossible de synchroniser avec GitHub."

### CRÉATION DU SERVEUR WEB (FLASK) ###
echo "🖥️ Configuration du serveur Web..."
python3 -m venv venv
source venv/bin/activate
pip install flask requests
cat <<EOL > server.py
from flask import Flask, jsonify
app = Flask(__name__)

@app.route('/')
def index():
    return jsonify({"status": "Laboratoire de Richesse en cours d'exécution"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=$FLASK_PORT)
EOL
nohup python3 server.py > server.log 2>&1 &

echo "✅ Serveur Web disponible sur http://localhost:$FLASK_PORT"

### BOT TELEGRAM ###
function send_telegram() {
    MESSAGE="🚀 Mise à jour du Laboratoire de Richesse : $1"
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d chat_id="$CHAT_ID" -d text="$MESSAGE"
}

send_telegram "Le Laboratoire de Richesse vient d'être lancé !"

### BOT DE TRADING ###
echo "📈 Lancement du bot de trading..."
cat <<EOL > trading_bot.py
import requests
def get_price():
    url = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd"
    response = requests.get(url).json()
    return response["bitcoin"]["usd"]

print(f"📈 Prix actuel du BTC : {get_price()} $")
EOL
nohup python3 trading_bot.py > trading.log 2>&1 &

send_telegram "Bot de trading lancé avec succès !"

### SAUVEGARDE SUR GITHUB ###
echo "🔄 Sauvegarde des gains sur GitHub..."
git add .
git commit -m "🔄 Mise à jour des revenus - $(date)"
git push origin main
send_telegram "Les gains ont été sauvegardés sur GitHub."

echo "✅ Laboratoire de Richesse opérationnel ! 🚀💰"
