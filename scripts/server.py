from flask import Flask, jsonify
app = Flask(__name__)

@app.route('/status')
def status():
    return jsonify({
        "status": "🟢 Laboratoire de Richesse Actif",
        "profit": "Automatisation en cours...",
        "cashback": "Activé",
        "trading_bot": "Actif",
        "banking_ai": "Actif"
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
