import requests
from bs4 import BeautifulSoup as BS
from pegar_nomesAux import definir_dicionarioAspnet
from pprint import pprint
import json

url_inicial = r'http://bvmf.bmfbovespa.com.br/cias-listadas/empresas-listadas/BuscaEmpresaListada.aspx?idioma=pt-br'
url_lista_empresas = r'http://bvmf.bmfbovespa.com.br/cias-listadas/empresas-listadas/BuscaEmpresaListada.aspx?idioma=pt-br'

s = requests.Session()

response_inicial = s.get(url_inicial)

soup_inicial = BS(response_inicial.content, 'html.parser')

dictAspnet = definir_dicionarioAspnet(soup_inicial)

response_lista = s.post(url_lista_empresas, dictAspnet)

soup_resposta_lista_empresas = BS(response_lista.content, 'html.parser')

soup_lista_empresas = soup_resposta_lista_empresas.find(id="ctl00_contentPlaceHolderConteudo_BuscaNomeEmpresa1_grdEmpresa_ctl01").find('tbody')
soups_linha_empresa = soup_lista_empresas.find_all('tr')

lista_empresas = []

for soup_linha_empresa in soups_linha_empresa:
    soups_caracteristica_empresa = soup_linha_empresa.find_all('td')

    empresa = {}
    empresa['razaoSocial'] = soups_caracteristica_empresa[0].find('a').get_text()
    empresa['nomeDePregao'] = soups_caracteristica_empresa[1].find('a').get_text() #['text'] .get_text()
    empresa['segmento'] = soups_caracteristica_empresa[2].get_text()
    empresa['linkAspNet'] = soups_caracteristica_empresa[1].find('a')['href']
    lista_empresas.append(empresa)


s = json.dumps(lista_empresas)
open("lista_empresas.json","w").write(s)

pprint(lista_empresas)
