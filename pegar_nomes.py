import requests
from bs4 import BeautifulSoup as BS
from pegar_nomesAux import definir_dicionarioAspnet

url_inicial = r'http://bvmf.bmfbovespa.com.br/cias-listadas/empresas-listadas/BuscaEmpresaListada.aspx?idioma=pt-br'
url_lista_empresas = r'http://bvmf.bmfbovespa.com.br/cias-listadas/empresas-listadas/BuscaEmpresaListada.aspx?idioma=pt-br'

s = requests.Session()

response_inicial = s.get(url_inicial)

soup_inicial = BS(response_inicial.content, 'html.parser')

dictAspnet = definir_dicionarioAspnet(soup_inicial)

response_lista = s.post(url_lista_empresas, dictAspnet)

soup_lista_empresas = BS(response_lista.content, 'html.parser')

print(soup_lista_empresas)
