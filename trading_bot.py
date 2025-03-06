import requests
def get_price():
    url = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd"
    response = requests.get(url).json()
    return response["bitcoin"]["usd"]

print(f"📈 Prix actuel du BTC : {get_price()} $")
