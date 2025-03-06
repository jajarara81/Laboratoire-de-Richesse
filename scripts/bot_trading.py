import requests
import time

print("🚀 Bot de trading AI en cours d'exécution...")

while True:
    try:
        price = requests.get("https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT").json()["price"]
        print(f"📈 Prix actuel du BTC : {price}")
    except Exception as e:
        print(f"❌ Erreur de connexion API : {e}")
    time.sleep(60)
