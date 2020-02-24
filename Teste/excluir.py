from bs4 import BeautifulSoup as BS
from pprint import pprint

path_arquivo = r'BuscaEmpresaListada.html'

file = open(path_arquivo,'r')
soup = BS(file.read(), 'html.parser')
soup_lista_empresas = soup.find(id="ctl00_contentPlaceHolderConteudo_BuscaNomeEmpresa1_grdEmpresa_ctl01").find('tbody')
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

pprint(lista_empresas)
# print(soup_lista_empresas)
