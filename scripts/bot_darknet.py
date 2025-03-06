import requests
import time

# 🚀 Configuration du proxy Tor
TOR_SOCKS_PROXY = "socks5h://127.0.0.1:9050"
DARKNET_URL = "http://duckduckgogg42xjoc72x3sjasowoarfbgcmvfimaftt6twagswzczad.onion"


print("🚀 Bot de trading Darknet en cours d'exécution...")

while True:
    try:
        proxies = {"http": TOR_SOCKS_PROXY, "https": TOR_SOCKS_PROXY}
        print("🔍 Vérification de la connexion au Darknet...")

        # Vérifier la connexion avec DuckDuckGo en premier
        test_url = "http://duckduckgogg42xjoc72x3sjasowoarfbgcmvfimaftt6twagswzczad.onion"
        test_response = requests.get(test_url, proxies=proxies, timeout=15)
        if test_response.status_code == 200:
            print("✅ Connexion Tor établie avec succès !")

            # Tenter de récupérer les prix des cryptos sur le Darknet
            response = requests.get(DARKNET_URL, proxies=proxies, timeout=30)
            darknet_prices = response.json()
            print(f"📈 Prix des cryptos sur le Darknet : {darknet_prices}")
        else:
            print("⚠️ Le Darknet semble inaccessible. Vérifiez votre connexion Tor.")

    except requests.exceptions.RequestException as e:
        print(f"❌ Erreur de connexion Darknet : {e}")

    time.sleep(60)
