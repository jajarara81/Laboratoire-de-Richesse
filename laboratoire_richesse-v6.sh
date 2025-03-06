#!/bin/bash

# ==============================
# ⚡ Laboratoire de Richesse ⚡
# Script Bash Automatique
# ==============================

# 🛠️ Mise à jour du système
echo "🔄 Mise à jour du système..."
apt update && apt upgrade -y

# 🔑 Vérification de la connexion SSH avec GitHub
echo "🔑 Vérification de la connexion SSH avec GitHub..."
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github_richesse
ssh -T git@github.com

# 🔄 Synchronisation avec GitHub
echo "🔄 Synchronisation avec GitHub..."
cd "$HOME/Laboratoire-de-Richesse" || exit
git pull origin main || git clone git@github.com:jajarara81/Laboratoire-de-Richesse.git "$HOME/Laboratoire-de-Richesse"

# 🛠️ Installation des outils nécessaires
echo "🛠️ Installation des outils nécessaires..."
apt install -y git curl wget python3-venv python3-pip nodejs npm jq

# 🖥️ Configuration du serveur Web Flask
echo "🖥️ Configuration du serveur Web Flask..."
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install flask requests
cat > server.py <<EOF
from flask import Flask
app = Flask(__name__)
@app.route('/')
def home():
    return "<h1>🚀 Laboratoire de Richesse en cours d'exécution !</h1>"
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF
nohup python3 server.py > server.log 2>&1 &
echo "✅ Serveur Web disponible sur http://localhost:5000"

# 📈 Lancement du bot de trading
echo "📈 Lancement du bot de trading..."
cat > trading_bot.py <<EOF
import requests
print("🚀 Bot de trading en cours d'exécution...")
EOF
nohup python3 trading_bot.py > trading.log 2>&1 &

# 💰 Activation du cashback
echo "💰 Activation du cashback..."
curl -X GET "https://api.ebates.com/activate"

# 🏦 Connexion aux plateformes bancaires
echo "🏦 Connexion aux plateformes bancaires..."
curl -X GET "https://api.banque.com/connect"

# 🔄 Sauvegarde des gains sur GitHub
echo "🔄 Sauvegarde des gains sur GitHub..."
git add .
git commit -m "🔄 Mise à jour des revenus - $(date)"
git push origin main

# ✅ Fin du script
echo "✅ Laboratoire de Richesse opérationnel ! 🚀💰"
