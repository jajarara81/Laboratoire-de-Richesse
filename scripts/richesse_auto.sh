#!/bin/bash

echo "🚀 Démarrage du Laboratoire de Richesse avec PayPal et Technologies 2025..."

# 🏦 Vérifier le solde PayPal automatiquement
echo "💳 Vérification du solde PayPal..."
pip3 install paypalrestsdk
python3 /root/Laboratoire-de-Richesse/scripts/paypal_balance.py

# 💰 Récupération automatique des revenus PayPal
python3 /root/Laboratoire-de-Richesse/scripts/paypal_auto_transfer.py &

# 📤 Synchronisation avec GitHub
echo "🔄 Sauvegarde des gains sur GitHub..."
cd "/root/Laboratoire-de-Richesse"
git add .
git commit -m "🔄 Mise à jour des revenus PayPal et Projets - $(date)"
git push origin main

echo "✅ Processus de richesse terminé !"
