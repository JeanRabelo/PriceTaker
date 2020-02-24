import requests
from bs4 import BeautifulSoup as BS

url_1 = r'https://www.infomoney.com.br/cotacoes/petrobras-petr4/historico/'
url_2 = r'https://www.infomoney.com.br/wp-admin/admin-ajax.php'

soup = BS()
