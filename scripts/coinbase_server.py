from flask import Flask, jsonify
import subprocess

app = Flask(__name__)

@app.route('/solde', methods=['GET'])
def solde():
    result = subprocess.run(['python3', '/root/Laboratoire-de-Richesse/scripts/coinbase_balance.py'], capture_output=True, text=True)
    return jsonify({"solde": result.stdout})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
