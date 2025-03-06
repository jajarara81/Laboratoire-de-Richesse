import requests
import time

print("🎁 Collecteur d'airdrops actif...")

while True:
    try:
        response = requests.get("https://airdrops.io/").text
        if "NEW AIRDROP" in response:
            print("🎁 Nouveau airdrop détecté ! Participation automatique...")
        else:
            print("🔎 Aucun nouveau airdrop.")
    except Exception as e:
        print(f"❌ Erreur : {e}")
    time.sleep(3600)  # Vérification toutes les heures
