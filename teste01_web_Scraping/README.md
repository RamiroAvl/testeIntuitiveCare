# Teste 01 - Teste de Web Scraping

# Download e Compactação de Anexos da ANS

Este script automatiza o processo de **extração**, **download** e **compactação** de anexos em PDF do site da **ANS (Agência Nacional de Saúde Suplementar)**.

##  Como funciona:
O script executa as seguintes etapas:

1. **Acessa a página da ANS** onde estão os anexos de interesse.
2. **Localiza os links** dos PDFs correspondentes aos anexos "Anexo I.pdf" e "Anexo II.pdf".
3. **Faz o download** dos arquivos e os armazena localmente dentro da pasta pdf_anexos.
4. **Compacta** os PDFs em um arquivo `anexos.zip` para facilitar o armazenamento.

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

`python main.py`