import requests
import time

print("🚀 Bot de trading avancé en cours d'exécution...")

while True:
    try:
        price = requests.get("https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT").json()["price"]
        print(f"📈 Prix du BTC : {price}")
    except Exception as e:
        print(f"❌ Erreur API : {e}")
    time.sleep(30)
