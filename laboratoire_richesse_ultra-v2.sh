#!/bin/bash

# 🚀 Configuration des variables
TRANSACTION_FILE="transactions.csv"
SERVER_SCRIPT="server.py"

# 🔄 Mise à jour du système
echo "🔄 Mise à jour du système..."
apt update && apt install -y python3 python3-pip sqlite3

# 🛠 Vérification et installation des dépendances
if ! command -v flask &>/dev/null; then
    echo "🔧 Installation de Flask..."
    pip3 install flask
fi

# 🗃 Création du fichier CSV s'il n'existe pas
if [ ! -f "$TRANSACTION_FILE" ]; then
    echo "📄 Création du fichier transactions.csv..."
    echo "Date,Source,Montant" > "$TRANSACTION_FILE"
fi

# 💰 Ajout d'une transaction fictive (100€ de gains)
echo "$(date '+%Y-%m-%d %H:%M:%S'), PayPal, 100€" >> "$TRANSACTION_FILE"
echo "✅ Transaction ajoutée : 100€"

# 📈 Calcul du solde total
TOTAL=$(awk -F ',' 'NR>1 {sum += $3+0} END {print sum}' "$TRANSACTION_FILE")
echo "💰 Solde total : $TOTAL€"

# 🖥 Vérification du script serveur
if [ ! -f "$SERVER_SCRIPT" ]; then
    echo "📄 Création du serveur Flask..."
    cat <<EOF > "$SERVER_SCRIPT"
from flask import Flask, jsonify
import csv

app = Flask(__name__)

def get_balance():
    total = 0
    try:
        with open("transactions.csv", "r") as f:
            reader = csv.reader(f)
            for row in reader:
                if row and len(row) >= 3:
                    total += float(row[2].replace("€", ""))
    except FileNotFoundError:
        total = 0
    return total

@app.route("/")
def index():
    return f"<h1>💰 Balance totale : {get_balance()}€</h1>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF
fi

# 🚀 Démarrage du serveur Flask
echo "🔄 Redémarrage du serveur Flask..."
sudo kill -9 $(sudo lsof -t -i :5000) 2>/dev/null
python3 "$SERVER_SCRIPT" &
echo "✅ Serveur disponible sur http://127.0.0.1:5000"

exit 0
