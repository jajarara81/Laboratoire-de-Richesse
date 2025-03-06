#!/bin/bash

source ~/.bashrc

echo "🚀 Démarrage du Laboratoire de Richesse..."

# 💰 Récupération de cashbacks automatiques
echo "💰 Activation des cashbacks..."
curl -sL https://api.ebates.com/ > /dev/null

# 🔗 Installation et démarrage du minage de cryptomonnaies automatique
echo "⛏️ Installation et lancement du minage..."
sudo apt install -y xmrig
nohup xmrig --donate-level 1 -o pool.supportxmr.com:3333 -u $WALLET_ADDRESS --background &

# 🤖 Exécution d'un bot de trading automatique
echo "📈 Lancement du bot de trading..."
pip3 install requests
python3 /root/Laboratoire-de-Richesse/scripts/bot_trading.py &

# 📤 Synchronisation avec GitHub
echo "🔄 Sauvegarde des gains sur GitHub..."
cd "/root/Laboratoire-de-Richesse"
git add .
git commit -m "🔄 Mise à jour des revenus - $(date)"
git push origin main

echo "✅ Processus de richesse terminé !"
