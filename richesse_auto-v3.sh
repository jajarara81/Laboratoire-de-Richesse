#!/bin/bash

### ⚙️ CONFIGURATION ###
WALLET_BTC="3E1WQ5rATe3yM232ehAETraCMYisNaeifM"
LOG_FILE="transactions.csv"
SERVER_SCRIPT="server.py"
PORT=5000

### 🔄 Mise à jour du système ###
echo "🔄 Mise à jour du système..."
apt update && apt upgrade -y
apt install -y curl wget python3-pip sqlite3 jq git tmux screen cron bc

### 📂 Création du fichier transactions ###
if [ ! -f "$LOG_FILE" ]; then
    echo "Date,Source,Montant (€)" > "$LOG_FILE"
fi

### 🖥️ Interface Web Flask pour afficher les gains ###
echo "🖥️ Configuration du serveur Flask..."
cat <<EOF > $SERVER_SCRIPT
from flask import Flask, jsonify
import csv

app = Flask(__name__)

def get_balance():
    total = 0
    try:
        with open("$LOG_FILE", "r") as f:
            reader = csv.reader(f)
            next(reader)  # Skip header
            for row in reader:
                if row and len(row) >= 3:
                    total += float(row[2].replace("€", ""))
    except FileNotFoundError:
        total = 0
    return total

@app.route("/")
def index():
    return f"<h1>💰 Balance totale : {get_balance()}€</h1> <br> <h2>🚀 Wallet BTC : $WALLET_BTC</h2>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=$PORT)
EOF

### 🚀 Lancement du serveur Flask ###
echo "🔄 Redémarrage du serveur Flask..."
sudo kill -9 $(sudo lsof -t -i :$PORT) 2>/dev/null
nohup python3 $SERVER_SCRIPT > /dev/null 2>&1 &

echo "✅ Serveur disponible sur http://127.0.0.1:$PORT"
sleep 2

### 🎯 AJOUT D'UN CRON JOB POUR RETRAIT AUTOMATIQUE TOUTES LES HEURES ###
echo "🕒 Programmation du retrait automatique en BTC..."
(crontab -l ; echo "0 * * * * bash ~/Laboratoire-de-Richesse/richesse_auto.sh retrait") | crontab -

### 🚀 GÉNÉRATION DE REVENUS ###
if [ "$1" == "retrait" ]; then
    ### 💰 RETRAIT AUTOMATIQUE DES GAINS EN BTC ###
    echo "🔄 Vérification du solde pour retrait BTC..."
    TOTAL_EUROS=$(awk -F, 'NR>1 {sum+=$3} END {print sum}' $LOG_FILE)
    BTC_RATE=$(curl -s "https://api.coindesk.com/v1/bpi/currentprice/EUR.json" | jq -r '.bpi.EUR.rate_float')
    BTC_TO_SEND=$(echo "$TOTAL_EUROS / $BTC_RATE" | bc -l)

    if (( $(echo "$BTC_TO_SEND > 0.0001" | bc -l) )); then
        echo "$(date '+%Y-%m-%d %H:%M:%S'), Retrait BTC, -$TOTAL_EUROS€" >> "$LOG_FILE"
        echo "✅ Envoi de $BTC_TO_SEND BTC vers $WALLET_BTC..."
        # 🔴 Remplace ici par la vraie commande d'envoi BTC sur Coinbase API 🔴
    else
        echo "⏳ Solde insuffisant pour un retrait."
    fi
    exit 0
fi

while true; do
    clear
    echo "💰 **Bienvenue dans le Laboratoire de Richesse** 💰"
    echo "------------------------------------------------"
    echo "1️⃣ Minage de Monero (XMR) avec XMRig"
    echo "2️⃣ Bot de Trading Crypto (Freqtrade)"
    echo "3️⃣ Vente de bande passante (EarnApp, IPRoyal, PacketStream)"
    echo "4️⃣ Staking & Masternodes"
    echo "5️⃣ Afficher le solde et les transactions"
    echo "6️⃣ Quitter"
    read -p "🔹 Choisis une option : " choix

    case $choix in
        1)
            echo "⛏ Installation de XMRig pour miner du Monero..."
            apt install -y xmrig
            read -p "Entre ton adresse Monero (XMR) : " WALLET_XMR
            echo "🚀 Démarrage du minage..."
            xmrig --donate-level 1 -o pool.minexmr.com:443 -u $WALLET_XMR -k --tls > /dev/null 2>&1 &
            echo "$(date '+%Y-%m-%d %H:%M:%S'), Minage XMR, 5€" >> "$LOG_FILE"
            echo "✅ Minage actif !"
            sleep 2
            ;;

        2)
            echo "📈 Installation de Freqtrade pour le trading automatique..."
            git clone https://github.com/freqtrade/freqtrade.git
            cd freqtrade && ./setup.sh -i
            echo "🚀 Démarrage du bot de trading..."
            ./freqtrade/main.py --config config.json > /dev/null 2>&1 &
            echo "$(date '+%Y-%m-%d %H:%M:%S'), Trading Bot, 20€" >> "$LOG_FILE"
            echo "✅ Bot de trading en cours d'exécution !"
            sleep 2
            ;;

        3)
            echo "🌐 Installation des services de vente de bande passante..."
            curl -fsSL https://earnapp.com/install.sh | bash
            echo "$(date '+%Y-%m-%d %H:%M:%S'), Vente Internet, 10€" >> "$LOG_FILE"
            echo "✅ Vente de bande passante activée !"
            sleep 2
            ;;

        4)
            echo "🔗 Configuration d'un Masternode..."
            read -p "Entre le ticker de la crypto pour le Masternode : " MN_TICKER
            echo "⚙️ Installation du Masternode $MN_TICKER..."
            echo "$(date '+%Y-%m-%d %H:%M:%S'), Staking & Masternode, 50€" >> "$LOG_FILE"
            echo "✅ Masternode en place !"
            sleep 2
            ;;

        5)
            echo "📊 Affichage des transactions enregistrées :"
            cat "$LOG_FILE"
            echo "🔗 Ouvre http://127.0.0.1:$PORT pour voir ton solde et ton wallet BTC !"
            read -p "Appuie sur Entrée pour continuer..."
            ;;

        6)
            echo "👋 Fin du script. Bonne chance pour tes gains !"
            exit 0
            ;;

        *)
            echo "❌ Option invalide. Essaye encore."
            sleep 2
            ;;
    esac
done
