#Passo 1: Abrir o site
#Passo 2: Encontrar os anexos(links que levam a pdfs)
#Passo 3: Realizar o Download dos anexos
#Passo 4: Compactar os anexos em um arquivo .ZIP

import requests
from bs4 import BeautifulSoup
import zipfile
import os

def download_pdfs():
    try:
        BASE_DIR = os.path.dirname(os.path.abspath(__file__))
        os.chdir(BASE_DIR)
        
        OUTPUT_DIR = "pdf_anexos"
        os.makedirs(OUTPUT_DIR, exist_ok=True)
        
        #Passo 1
        print("Acessando página web")
        page = requests.get('https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos')
        page.raise_for_status()
        
        soup = BeautifulSoup(page.content, 'html.parser')

        #Passo 2
        print("Localizando anexos")
        anexos = {}
        for link in soup.find_all('a', href=True):
            text = link.get_text(strip=True).lower()
            url = link['href']
            
            if 'anexo i' in text and 'Anexo_I.pdf' not in anexos:
                anexos['Anexo_I.pdf'] = url if url.startswith('http') else f'https://www.gov.br{url}'
            elif 'anexo ii' in text and 'Anexo_II.pdf' not in anexos:
                anexos['Anexo_II.pdf'] = url if url.startswith('http') else f'https://www.gov.br{url}'
        
        #Passo 3
        print("Iniciando download dos arquivos")
        for filename, url in anexos.items():
            print(f'Baixando {filename}')
            response = requests.get(url)
            response.raise_for_status()
            
            with open(os.path.join(OUTPUT_DIR, filename), 'wb') as f:
                f.write(response.content)

        #Passo 4
        print("Criando arquivo ZIP")
        with zipfile.ZipFile('anexos.zip', 'w') as zipf:
            for filename in anexos.keys():
                filepath = os.path.join(OUTPUT_DIR, filename)
                zipf.write(filepath, filename)
        
        print(f"Download concluído: {len(anexos)} arquivos baixados e compactados")
        return True

    except requests.exceptions.RequestException as e:
        print(f'Falha na requisição HTTP: {e}')
    except Exception as e:
        print(f'Ocorreu um erro: {e}')
    
    return False

if __name__ == '__main__':
    download_pdfs()