from flask import Flask, jsonify
app = Flask(__name__)

@app.route('/')
def index():
    return jsonify({"status": "Laboratoire de Richesse en cours d'exécution"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
