#!/bin/bash

echo "🚀 Démarrage du Laboratoire de Richesse..."

# 💰 Récupération de cashbacks automatiques
echo "💰 Activation des cashbacks..."
curl -s https://api.ebates.com/activate?user=$USER_ID

# 🔗 Mining de cryptomonnaies automatique
echo "⛏️ Démarrage du minage en arrière-plan..."
nohup xmrig --donate-level 1 -o pool.supportxmr.com:3333 -u $WALLET_ADDRESS --background &

# 🤖 Exécution d'un bot de trading automatique
echo "📈 Lancement du bot de trading..."
python3 /root/Laboratoire-de-Richesse/scripts/bot_trading.py &

# 📤 Synchronisation avec GitHub
echo "🔄 Sauvegarde des gains sur GitHub..."
cd "/root/Laboratoire-de-Richesse"
git add .
git commit -m "🔄 Mise à jour des revenus - $(date)"
git push origin main

echo "✅ Processus de richesse terminé !"
