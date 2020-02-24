
def definir_dicionarioAspnet(soup):
    # print(soup)
    dictAspnet = {}
    dictAspnet['__EVENTTARGET'] = r'ctl00:contentPlaceHolderConteudo:BuscaNomeEmpresa1:btnTodas'
    # dictAspnet['__EVENTARGUMENT'] = soup.find(id='__EVENTARGUMENT')['value']
    # 2ª possibilidade:
    dictAspnet['__EVENTARGUMENT'] = ''
    dictAspnet['__VIEWSTATE'] = soup.find(id='__VIEWSTATE')['value']
    dictAspnet['__VIEWSTATEGENERATOR'] = soup.find(id='__VIEWSTATEGENERATOR')['value']
    dictAspnet['__EVENTVALIDATION'] = soup.find(id='__EVENTVALIDATION')['value']
    dictAspnet['ctl00_contentPlaceHolderConteudo_AjaxPanelBuscaPostDataValue'] = r'ctl00_contentPlaceHolderConteudo_AjaxPanelBusca,ActiveElement,ctl00_contentPlaceHolderConteudo_BuscaNomeEmpresa1_btnTodas;'
    dictAspnet['ctl00$contentPlaceHolderConteudo$tabMenuEmpresaListada'] = r'{"State":{},"TabState":{"ctl00_contentPlaceHolderConteudo_tabMenuEmpresaListada_tabNome":{"Selected":true}}}'
    dictAspnet['ctl00$contentPlaceHolderConteudo$BuscaNomeEmpresa1$txtNomeEmpresa$txtNomeEmpresa'] = ''
    dictAspnet['ctl00$contentPlaceHolderConteudo$mpgPaginas_Selected'] = '0'
    dictAspnet['RadAJAXControlID'] = r'ctl00_contentPlaceHolderConteudo_AjaxPanelBusca'
    dictAspnet['httprequest'] = 'true'

    return dictAspnet
