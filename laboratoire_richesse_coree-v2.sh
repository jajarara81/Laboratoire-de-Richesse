#!/bin/bash

# 🚀 Laboratoire de Richesse Ultime - Automatisation Complète 💰
# Auteur : Fabregal Vincent
# Version : 2025

# 🔧 Définition des Variables
GITHUB_USER="jajarara81"
GITHUB_REPO="Laboratoire-de-Richesse"
GITHUB_SSH="git@github.com:$GITHUB_USER/$GITHUB_REPO.git"
LOCAL_DIR="$HOME/$GITHUB_REPO"
SCRIPT_DIR="$LOCAL_DIR/scripts"
LOG_FILE="$LOCAL_DIR/richesse.log"

# 🔄 Mise à jour du système et installation des outils nécessaires
echo "🔄 Mise à jour du système..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl wget python3-venv nodejs npm jq

# 🔗 Vérifier et cloner le dépôt GitHub sans recréer de clé SSH
if [ ! -d "$LOCAL_DIR" ]; then
    echo "📥 Clonage du dépôt GitHub..."
    git clone "$GITHUB_SSH" "$LOCAL_DIR"
else
    echo "🔄 Mise à jour du dépôt GitHub..."
    cd "$LOCAL_DIR"
    git pull origin main || git branch -M main
fi

# 📂 Création des dossiers nécessaires
mkdir -p "$SCRIPT_DIR"

# 🔄 Vérifier et corriger la branche principale
cd "$LOCAL_DIR"
git checkout -B main
git branch --set-upstream-to=origin/main main || echo "🚨 La branche main est créée."

git remote remove origin
git remote add origin "$GITHUB_SSH"

# 🔄 Forcer Git à utiliser SSH
git config --global user.name "Fabregal Vincent"
git config --global user.email "fabregalvincent43@gmail.com"
ssh -T git@github.com || echo "❌ Problème de connexion SSH avec GitHub."

# 🖥️ Installation et configuration de l'environnement virtuel
if [ ! -d "$LOCAL_DIR/venv" ]; then
    echo "📦 Création d'un environnement virtuel Python..."
    python3 -m venv "$LOCAL_DIR/venv"
fi
source "$LOCAL_DIR/venv/bin/activate"
pip install --upgrade pip
pip install flask

deactivate

# 🚀 Exécution du script de richesse
echo "📌 Démarrage du script de richesse..."
"$SCRIPT_DIR/richesse_auto.sh"

echo "✅ Laboratoire de Richesse installé et en cours d'exécution ! 🚀💰"
