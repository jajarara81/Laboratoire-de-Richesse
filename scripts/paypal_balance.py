import paypalrestsdk
import json

paypalrestsdk.configure({
  "mode": "live",  # Remplacez par "sandbox" pour les tests
  "client_id": "VOTRE_CLIENT_ID",
  "client_secret": "VOTRE_CLIENT_SECRET"
})

balance = paypalrestsdk.Balance()
print("💳 Solde PayPal actuel :", json.dumps(balance.to_dict(), indent=2))
