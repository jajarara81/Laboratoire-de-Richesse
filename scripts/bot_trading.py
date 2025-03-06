import requests
import time

print("🚀 Bot de trading en cours d'exécution...")

while True:
    # Simulation de trading
    price = requests.get("https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT").json()["price"]
    print(f"📈 Prix actuel du BTC : {price}")
    time.sleep(60)
