#!/bin/bash

# 🔑 Charger la clé API en mémoire sans l'afficher
API_KEY=$(cat ~/.api_key_secure)

# Vérifier si la clé est bien chargée
if [ -z "$API_KEY" ]; then
    echo "❌ Erreur : Impossible de charger la clé API !"
    exit 1
fi

# 🌐 Exemple : Utiliser la clé API pour une requête sécurisée
echo "🔐 Utilisation sécurisée de la clé API..."

curl -X POST "https://api.exemple.com/request" \
    -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json" \
    -d '{"data": "exemple"}'

# 🚀 Fin du script
echo "✅ Requête envoyée avec succès !"
