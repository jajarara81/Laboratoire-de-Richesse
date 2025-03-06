import paypalrestsdk
import time

paypalrestsdk.configure({
  "mode": "live",  # Remplacez par "sandbox" pour les tests
  "client_id": "VOTRE_CLIENT_ID",
  "client_secret": "VOTRE_CLIENT_SECRET"
})

def transfer_funds():
    print("💰 Vérification du solde et transfert automatique...")
    # Ici, insérez votre logique de transfert de fonds automatique

while True:
    transfer_funds()
    time.sleep(86400)  # Vérification toutes les 24h
