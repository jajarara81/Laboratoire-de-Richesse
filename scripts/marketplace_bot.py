import requests
import json

print("🛒 Bot AI Marketplace en ligne...")

while True:
    try:
        offres = requests.get("https://api.ebay.com/buy/browse/v1/item_summary/search?q=laptop").json()
        for offre in offres["itemSummaries"][:3]:
            print(f"💻 Offre trouvée : {offre['title']} - {offre['price']['value']} {offre['price']['currency']}")
    except Exception as e:
        print(f"❌ Erreur API eBay : {e}")
    time.sleep(300)
