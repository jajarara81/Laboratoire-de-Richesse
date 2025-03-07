from flask import Flask, jsonify
import csv

app = Flask(__name__)

def get_balance():
    total = 0
    try:
        with open("transactions.csv", "r") as f:
            reader = csv.reader(f)
            next(reader)  # Skip header
            for row in reader:
                if row and len(row) >= 3:
                    total += float(row[2].replace("€", ""))
    except FileNotFoundError:
        total = 0
    return total

@app.route("/")
def index():
    return f"<h1>💰 Balance totale : {get_balance()}€</h1> <br> <h2>🚀 Wallet BTC : 3E1WQ5rATe3yM232ehAETraCMYisNaeifM</h2>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
