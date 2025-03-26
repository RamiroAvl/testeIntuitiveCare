from flask import Flask, jsonify, request
import os
import pandas as pd

app = Flask(__name__)


try:
    operadoras_df = pd.read_csv('./Relatorio_cadop.csv', sep=';')
except Exception as e:
    print(f"Erro ao carregar o arquivo CSV: {e}")
    operadoras_df = pd.DataFrame()  

@app.route('/')
def index():
    termo = request.args.get('termo')
    if not termo:
        return jsonify({'error': 'Por favor, forneça um termo de busca.'}), 400

    resultados = operadoras_df[
        operadoras_df.apply(lambda row: row.astype(str).str.contains(termo, case=False).any(), axis=1)
    ]

    return jsonify(resultados.to_dict(orient='records'))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)