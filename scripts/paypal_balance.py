import paypalrestsdk
import json

paypalrestsdk.configure({
  "mode": "live",  # Remplacez par "sandbox" pour les tests
  "client_id": "VOTRE_CLIENT_ID",
  "client_secret": "VOTRE_CLIENT_SECRET"
})

def get_balance():
    try:
        account_info = paypalrestsdk.Payment.all({"count": 1})
        print("💳 Dernière transaction PayPal :", json.dumps(account_info.to_dict(), indent=2))
    except Exception as e:
        print("❌ Erreur de récupération du solde PayPal :", str(e))

get_balance()
