import requests
import time
import socks
import socket

# 🚀 Configuration du proxy Tor pour naviguer sur le Darknet
TOR_SOCKS_PROXY = "socks5h://127.0.0.1:9050"

print("🚀 Bot de trading Darknet en cours d'exécution...")

while True:
    try:
        proxies = {"http": TOR_SOCKS_PROXY, "https": TOR_SOCKS_PROXY}
        response = requests.get("http://darkmarketxyz.onion/api/prices", proxies=proxies, timeout=30)
        darknet_prices = response.json()
        print(f"📈 Prix des cryptos sur le Darknet : {darknet_prices}")
    except Exception as e:
        print(f"❌ Erreur de connexion Darknet : {e}")
    time.sleep(60)

