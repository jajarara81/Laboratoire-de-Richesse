#!/bin/bash

echo "🚀 Démarrage du Laboratoire de Richesse..." | tee -a /root/Laboratoire-de-Richesse/richesse.log

# 💰 Activation du Cashback Automatique (Amazon, Rakuten, AliExpress)
echo "💰 Activation du Cashback..." | tee -a /root/Laboratoire-de-Richesse/richesse.log
curl -sL https://api.ebates.com/ > /dev/null

# 🤖 Bot de Trading AI Avancé
echo "📈 Lancement du bot de trading AI..." | tee -a /root/Laboratoire-de-Richesse/richesse.log
nohup python3 /root/Laboratoire-de-Richesse/scripts/bot_trading.py > /root/Laboratoire-de-Richesse/scripts/trading.log 2>&1 &

# 🔗 Airdrop & Récompenses Automatisées
echo "🎁 Collecte automatique des airdrops et primes crypto..." | tee -a /root/Laboratoire-de-Richesse/richesse.log
python3 /root/Laboratoire-de-Richesse/scripts/airdrop_collector.py &

# 🔄 Sauvegarde et mise à jour GitHub
echo "🔄 Sauvegarde des gains sur GitHub..." | tee -a /root/Laboratoire-de-Richesse/richesse.log
cd "/root/Laboratoire-de-Richesse"
git add .
git commit -m "🔄 Mise à jour des revenus - $(date)"
git push origin main

echo "✅ Processus de richesse terminé !" | tee -a /root/Laboratoire-de-Richesse/richesse.log
