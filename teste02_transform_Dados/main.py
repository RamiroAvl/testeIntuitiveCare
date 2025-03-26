#Passo 1: Localizar o Anexo_1 dentro da pasta que criei no teste 1
#Passo 2: Extrair a tabela de dentro do PDF
#Passo 3: Realizar a substituação das colunas OD e AMB para "Seg. Odontológica" e "Seg. Ambulatorial"
#Passo 4: Salvar a tabela em um arquivo CSV
#Passo 5: Compactar o arquivo CSV em um arquivo .ZIP com o nome "Teste_Ramiro_Avila.zip"

import os
import zipfile
import pdfplumber
import pandas as pd

def process_pdf():
    try:
        BASE_DIR = os.path.dirname(os.path.abspath(__file__))
        os.chdir(BASE_DIR)
        
        INPUT_DIR = "pdf_anexos"
        OUTPUT_DIR = "arquivo_csv"
        os.makedirs(OUTPUT_DIR, exist_ok=True)
        
        #Passo 1
        pdf_path = os.path.join(INPUT_DIR, "/teste01_webScraping/pdf_anexos/Anexo_I.pdf")
        if not os.path.exists(pdf_path):
            raise FileNotFoundError(f"Arquivo PDF não encontrado em: {pdf_path}")
        
        #Passo 2
        print("Extraindo tabelas do PDF")
        tables = []
        
        with pdfplumber.open(pdf_path) as pdf:
            for page in pdf.pages:
                table = page.extract_table()
                if table:
                    df = pd.DataFrame(table[1:], columns=table[0])
                    tables.append(df)
        
        if not tables:
            raise ValueError("Nenhuma tabela encontrada no PDF")
            
        final_df = pd.concat(tables)
        print("Tabelas extraídas com sucesso")

        #Passo 3
        print("Processando dados")
        final_df = final_df.map(lambda x: "Seg. Odontológica" if x == "OD" else 
                               "Seg. Ambulatorial" if x == "AMB" else x)
        
        #Passo 4
        csv_path = os.path.join(OUTPUT_DIR, "Anexo_I_Alterado.csv")
        final_df.to_csv(csv_path, index=False)
        print(f"CSV salvo em {csv_path}")

        #Passo 5
        print("Criando arquivo ZIP")
        zip_path = 'Teste_Ramiro_Avila.zip'
        with zipfile.ZipFile(zip_path, 'w') as zipf:
            for file in os.listdir(OUTPUT_DIR):
                file_path = os.path.join(OUTPUT_DIR, file)
                zipf.write(file_path, file)
        
        print(f"Processamento concluído. Arquivo ZIP criado: {zip_path}")
        return True

    except Exception as e:
        print(f'Ocorreu um erro: {e}')
        return False

if __name__ == '__main__':
    process_pdf()