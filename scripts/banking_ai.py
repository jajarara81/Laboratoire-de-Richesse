import requests
import time

print("🏦 Bot bancaire AI en cours d'exécution...")

while True:
    try:
        invest = requests.get("https://api.banking-platform.com/roi?user_id=123456").json()
        print(f"📊 Rendement mensuel estimé : {invest['roi']}%")
    except Exception as e:
        print(f"❌ Erreur d'accès aux banques : {e}")
    time.sleep(3600)
