import cbpro
import os

api_key = os.getenv("COINBASE_API_KEY", "VOTRE_COINBASE_API_KEY")
api_secret = os.getenv("COINBASE_API_SECRET", "VOTRE_COINBASE_API_SECRET")
api_passphrase = "VOTRE_COINBASE_API_PASSPHRASE"

client = cbpro.AuthenticatedClient(api_key, api_secret, api_passphrase)

def get_balance():
    accounts = client.get_accounts()
    for account in accounts:
        if float(account['balance']) > 0:
            print(f"💰 {account['currency']}: {account['balance']} {account['hold']} HOLD")

get_balance()
