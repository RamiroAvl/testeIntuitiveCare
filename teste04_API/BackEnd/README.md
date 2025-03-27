# Teste 04 - Teste de API

# API de Busca de Operadoras ANS

Esta aplicação Flask fornece uma API para buscar informações sobre operadoras de planos de saúde a partir de um arquivo CSV. O arquivo CSV contém dados sobre diversas operadoras, e o usuário pode buscar informações utilizando um termo específico. 

## Como funciona:

1. **Leitura de Arquivo CSV**: O script lê o arquivo `Relatorio_cadop.csv` para buscar as informações sobre as operadoras.
2. **Busca de Termos**: A API permite buscar qualquer termo nas colunas do arquivo CSV. A busca é realizada de forma insensível a maiúsculas e minúsculas via search params na rota GET `/busca`.
3. **Tratamento de Erros**: Caso ocorra um erro ao carregar o arquivo ou se o termo de busca não for fornecido, a API retorna mensagens de erro apropriadas.
4. **Substituição de Valores**: Após a busca, o script substitui valores `NaN` por `None` para garantir uma resposta adequada no formato JSON.
5. **Resposta JSON**: Os resultados da busca são retornados no formato JSON, que será consumido pelo front-end ou postman.

## Como rodar localmente:
1 - Crie um ambiente virtual (venv): 

 `python -m venv venv` 

2 - Acesse a venv utilizando (no windows):

`venv/scripts/activate`

No Linux/Mac:

`source venv/scripts/activate`

3 - Baixe as bibliotecas:

`pip install -r requirements.txt`

4 - Execute o arquivo utilizando:

`python app.py`