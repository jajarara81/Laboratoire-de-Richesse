import requests
import time
import os

print("🚀 Bot de trading Darknet en cours d'exécution...")

while True:
    try:
        darknet_prices = requests.get("http://darkmarketxyz.onion/api/prices", proxies={"http": "socks5h://127.0.0.1:9050"}).json()
        print(f"📈 Prix des cryptos sur le Darknet : {darknet_prices}")
    except Exception as e:
        print(f"❌ Erreur de connexion Darknet : {e}")
    time.sleep(60)
