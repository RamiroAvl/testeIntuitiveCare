# Teste 02 - Teste de Transformação de Dados

# Processamento de PDF e Compactação em ZIP

Este projeto automatiza o processo de extração de dados de um arquivo PDF, substitui valores em tabelas e compacta o arquivo resultante em um arquivo ZIP.

## Como funciona:

1. **Localiza o arquivo PDF**: O script procura o arquivo PDF chamado `Anexo_I.pdf` dentro da pasta `pdf_anexos` localizada no teste anterior.
2. **Extrai tabelas do PDF**: O script usa a biblioteca `pdfplumber` para extrair as tabelas do arquivo PDF.
3. **Substitui valores específicos**: O script substitui os valores "OD" por "Seg. Odontológica" e "AMB" por "Seg. Ambulatorial" nas colunas da tabela.
4. **Salva o arquivo modificado em CSV**: A tabela modificada é salva como `Anexo_I_Alterado.csv` dentro da pasta `arquivo_csv`.
5. **Compacta o CSV em um arquivo ZIP**: O arquivo CSV gerado é compactado em um arquivo chamado `Teste_Ramiro_Avila.zip`.

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