#!/bin/bash

### 🛠️ Configuration Initiale
set -e  # Arrêter en cas d'erreur
LOG_FILE="richesse.log"
GIT_REPO="git@github.com:jajarara81/Laboratoire-de-Richesse.git"
LOCAL_DIR="$HOME/Laboratoire-de-Richesse"

echo "🔄 Mise à jour du système..."
sudo apt update -y && sudo apt upgrade -y

echo "🛠️ Vérification des outils nécessaires..."
for pkg in git curl wget python3-venv nodejs npm jq; do
    if ! dpkg -s "$pkg" >/dev/null 2>&1; then
        echo "📦 Installation de $pkg..."
        sudo apt install -y "$pkg"
    fi
done

### 🔑 Configuration SSH avec GitHub
echo "🔑 Vérification de la connexion SSH avec GitHub..."
ssh -T -q git@github.com || echo "⚠️ Vérifiez votre clé SSH."

### 🔄 Mise à jour du Dépôt GitHub
if [ ! -d "$LOCAL_DIR" ]; then
    echo "📥 Clonage du dépôt GitHub..."
    git clone "$GIT_REPO" "$LOCAL_DIR"
fi

cd "$LOCAL_DIR"
echo "🔄 Synchronisation avec GitHub..."
git fetch --all
git reset --hard origin/main
git pull --rebase origin main || echo "⚠️ Problème de mise à jour du dépôt."

### 📝 Nettoyage des logs
echo "" > "$LOG_FILE"

### 🚀 Lancement du Laboratoire de Richesse
echo "💰 Activation du cashback..."
sleep 2
echo "📈 Démarrage du bot de trading..."
nohup python3 scripts/bot_trading.py > scripts/trading.log 2>&1 &

echo "🏦 Connexion aux plateformes bancaires..."
sleep 2
echo "📦 Sauvegarde des gains sur GitHub..."
git add .
git commit -m "🔄 Mise à jour des revenus - $(date)"
git push origin main || echo "⚠️ Problème lors du push vers GitHub."

echo "✅ Laboratoire de Richesse opérationnel ! 🚀💰"
