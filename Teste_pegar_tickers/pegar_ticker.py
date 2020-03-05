import requests
from bs4 import BeautifulSoup as BS
import json
from os import system
import time
import sys

def get_url_with_200(url, tentativa=1):
    s = requests.Session()
    response = s.get(url)
    if response.status_code == 200:
        return response
    else:
        if tentativa == 1:
            print('A url com problema é a seguinte:\n' + url)
        tempo_espera = pow(2,(tentativa-1))*10
        print('Tivemos uma resposta ' + str(response.status_code) + ' na ' + str(tentativa) + 'ª tentativa de pegar uma resposta 200. Esperando ' + str(tempo_espera) + ' segundos')
        time.sleep(tempo_espera)
        return get_url_with_200(url, tentativa + 1)

def get_url(url, tentativa=1):
    try:
        return get_url_with_200(url)
    except:
        if tentativa == 1:
            print('A url com problema é a seguinte:\n' + url)
        tempo_espera = pow(2,(tentativa-1))*10
        print('Tivemos um problema genérico na ' + str(tentativa) + 'ª tentativa. Esperando ' + str(tempo_espera) + ' segundos')
        time.sleep(tempo_espera)
        return get_url(url, tentativa + 1)

def tickers_da_empresa(str_codigoCvm):

    url_base = r'http://bvmf.bmfbovespa.com.br/cias-listadas/empresas-listadas/ResumoEmpresaPrincipal.aspx?codigoCvm='
    url_i = url_base + str_codigoCvm + r'&idioma=pt-br'
    s = requests.Session()

    print('tentando a 1ª url')

    response_i = get_url(url_i)

    print('1ª url ok')

    soup_i = BS(response_i.content, 'html.parser')

    # try:
    #     pass
    # except AttributeError:
    #     print('Houve um problema na response_i. status_code=' + str(response_i.status_code))
    #     sys.exit()

    str_doc = soup_i.find(id="ctl00_contentPlaceHolderConteudo_iframeCarregadorPaginaExterna")['src']
    url_ticker = str_doc.replace(r'../..',r'http://bvmf.bmfbovespa.com.br').replace(r'#a',r'')

    print('tentando a 2ª url')

    response_ticker = get_url(url_ticker)

    system('clear')
    print('2ª url ok')
    soup_pagina_ticker = BS(response_ticker.content, 'html.parser')

    soup_regiao_ticker = soup_pagina_ticker.find(id = 'divCodigosOculto').parent

    list_soup_tickers = soup_regiao_ticker.find_all('a', {'class': 'LinkCodNeg', 'href':r'javascript:;'})

    list_tickers = []
    for soup_ticker in list_soup_tickers:
        list_tickers.append(soup_ticker.get_text())

    return list_tickers

json_file_lista_empresas = open('lista_empresas.json', 'r')
lista_empresas = json.load(json_file_lista_empresas)
json_file_lista_empresas.close()

n_empresas = len(lista_empresas)
i = 1

json_file_lista_acoes = open('lista_acoes.json', 'r')
lista_acoes = json.load(json_file_lista_acoes)
json_file_lista_acoes.close()

for empresa in lista_empresas:
    if not empresa['importada']:
        url_swag = empresa['linkAspNet'][38:]
        tickers_empresa = tickers_da_empresa(url_swag)

        for ticker in tickers_empresa:
            acao = {}
            acao['ticker'] = ticker
            acao['razaoSocial'] = empresa['razaoSocial']
            acao['nomeDePregao'] = empresa['nomeDePregao']
            acao['segmento'] = empresa['segmento']
            lista_acoes.append(acao)

        with open('lista_acoes.json', 'w') as json_file_lista_acoes:
            json.dump(lista_acoes, json_file_lista_acoes)

        del empresa['importada']
        empresa['importada'] = True

        with open('lista_empresas.json', 'w') as json_file_lista_empresas:
            json.dump(lista_empresas, json_file_lista_empresas)

        system('clear')
        print(str(i) + ' de ' + str(n_empresas) + ' empresas capturadas')
        print('tickers adicionados:')
        print(tickers_empresa)
    i = i + 1

print('Todas as empresas foram escaneadas!!!')
