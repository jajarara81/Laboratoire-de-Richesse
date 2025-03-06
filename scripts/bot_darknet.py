import requests
import time
import socks
import socket

# 🚀 Configuration du proxy Tor pour naviguer sur le Darknet
socks.set_default_proxy(socks.SOCKS5, "127.0.0.1", 9050)
socket.socket = socks.socksocket

print("🚀 Bot de trading Darknet en cours d'exécution...")

while True:
    try:
        proxies = {"http": "socks5h://127.0.0.1:9050", "https": "socks5h://127.0.0.1:9050"}
        response = requests.get("http://darkmarketxyz.onion/api/prices", proxies=proxies, timeout=30)
        darknet_prices = response.json()
        print(f"📈 Prix des cryptos sur le Darknet : {darknet_prices}")
    except Exception as e:
        print(f"❌ Erreur de connexion Darknet : {e}")
    time.sleep(60)
