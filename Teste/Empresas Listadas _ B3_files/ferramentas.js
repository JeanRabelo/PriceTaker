//window.onload = InicializarJavaScript;

if (!window.sstchur) { window.sstchur = {}; }
if (!sstchur.web) { sstchur.web = {}; }
if (!sstchur.web.xb) { sstchur.web.xb = {}; }

sstchur.web.xb.getComputedStyle = function(_elem, _style) {
    var computedStyle;

    if (typeof _elem.currentStyle != 'undefined') {
        computedStyle = _elem.currentStyle;
    }
    else {
        computedStyle = document.defaultView.getComputedStyle(_elem, null);
    }

    return computedStyle[_style];
}

function InicializarJavaScript() {
    if (document.getElementById && document.getElementsByTagName) {
        var botaoAumentoFonte = document.getElementById("botaoAumentoFonte");
        var botaoReducaoFonte = document.getElementById("botaoReducaoFonte");

        botaoAumentoFonte.onclick = function() { return AlterarTamanhoFonte("conteudo", "classe") };
        botaoReducaoFonte.onclick = function() { return AlterarTamanhoFonte("conteudo", 1) };
    }
}





function AlterarTamanhoFonte(idObjetoAgrupadorConteudo, nomeClasseCSS) {
    var objetoAgrupador = document.getElementById(idObjetoAgrupadorConteudo);

    for (i = 0; i < objetoAgrupador.childNodes.length; i++) {
        if (objetoAgrupador.childNodes[i].nodeType == 1) {

            alert(computedStyles)

            if (objetoAgrupador.childNodes[i].style.fontSize != "") {
                //alert(objetoAgrupador.childNodes[i].style.fontSize);
                objetoAgrupador.childNodes[i].style.fontSize = AlterarValorPropriedadeComUnidade(objetoAgrupador.childNodes[i].style.fontSize, 1, "px");
            }
        }
    }
}

function AlterarValorPropriedadeComUnidade(valorComUnidade, tipoAlteracao, unidadeSaida) {
    var vetorValorUnidade = valorComUnidade.toString().split(unidadeSaida);
    return (new String(new Number(vetorValorUnidade[0]) + tipoAlteracao) + unidadeSaida)
}


/******************************************************************************
/ Objetivo  : Acessar endereço existente em combo
/ Premissas : Nenhuma
/ Entradas  : objCombo - Instância do objeto combo
/ Retorno   : 
/******************************************************************************/
function AcessarEnderecoCombo(objCombo) {

    if (objCombo.value.length > 0) {
        if (objCombo.value.indexOf("javascript") > -1) {
            eval(objCombo.value);
        }
        else if (objCombo.value.indexOf("http://") > -1) {
            window.open(objCombo.value)
        }
        else {
            location.href = objCombo.value;
        }
    }
    objCombo.options[0].selected = true;
}


/******************************************************************************
/ Objetivo  : Aumentar tamanho da altura do iframe disponível em página
/ Premissas : Nenhuma
/ Entradas  : numeroInteiro - Tamanho em pixels a ser atribuído ao iframe
/ Retorno   : nenhum
/ desenv    : Marcelo Pereira Cavalini (p-mcavalini@bvmf.com.br | mpcavalini@gmail.com)
/ Como usar:
/ A chamada para função deve ser feita por meio da tag <script>,
/ <script type="text/javascript">this.parent.aumentadorDeAlturaDoIframe(6000);</script>
/ e ser o último elemento antes da tag </body>
/******************************************************************************/
function aumentadorDeAlturaDoIframe(numeroInteiro) {
    var numeroInteiro = numeroInteiro;
    document.getElementById(idIframe).style.height = (numeroInteiro + 10) + 'px';
}

/******************************************************************************
/ Objetivo  : Mostrar div selecionada em combo
/ Premissas : Nenhuma
/ Entradas  : 
/ Retorno   : 
/******************************************************************************/


function mostraDivSelecionada(objSelect) {
    var sel = objSelect;

    if (objSelect.value.toString() != '') {
        for (var i = 1; i < sel.length; i++) {
            document.getElementById(sel[i].value).style.display = 'none';
        }
        document.getElementById(objSelect.value).style.display = 'block';
    }
}




/******************************************************************************
/ Objetivo  : Abrir página popUp com altura e largura fixa
/ Premissas : Nenhuma
/ Entradas  : Url = Caminho da página que deverá ser aberta
Nome = Nome da Janela que será aberta, concatenando com a constante "BMFBOVESPA"
/ Retorno   : nenhum
/ desenv    : Marcelo Pereira Cavalini (p-mcavalini@bvmf.com.br | mpcavalini@gmail.com)
/******************************************************************************/
function abreJanelaPop(url, nome) {

    // altura e largura fixo
    var largura = 780;
    var altura = 460;
    var lado = (screen.width - largura) / 2;
    var topo = (screen.height - altura) / 2;
    window.open(url, 'BMFBOVESPA' + nome, 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=' + largura + ',height=' + altura + ',top=' + topo + ',left=' + lado);
}

/******************************************************************************
/ Objetivo  : Abrir página popUp com altura e largura customizada
/ Premissas : Exemplo de uso da função dentro do sitemap
/		javascript:abreJanelaPopCustomizada(&amp;#39;URL,&amp;#39;&amp;#39;NOME JANELA,&amp;#39; LARGURA &amp;#39;,&amp;#39;ALTURA;#39;);
/ Entradas  : Url = Caminho da página que deverá ser aberta
/	      Nome = Nome da Janela que será aberta, concatenando com a constante "BMFBOVESPA"
/	      largura = largura da janela
/	      altura = altura da janela
/ Retorno   : nenhum
/ desenv    : Marcelo Pereira Cavalini (p-mcavalini@bvmf.com.br | mpcavalini@gmail.com)
/******************************************************************************/
function abreJanelaPopCustomizada(url, nome, largura, altura) {

    var largura = largura
    var altura = altura

    var lado = (screen.width - largura) / 2;
    var topo = (screen.height - altura) / 2;
    window.open(url, 'BMFBOVESPA' + nome, 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=' + largura + ',height=' + altura + ',top=' + topo + ',left=' + lado);
}


/******************************************************************************
/ Objetivo  : Abrir página popUp com altura e largura dinamica (conforme resolução do usuário)
/ Premissas : Nenhuma
/ Entradas  : Url = Caminho da página que deverá ser aberta
Nome = Nome da Janela que será aberta, concatenando com a constante "BMFBOVESPA"
/ Retorno   : nenhum
/ desenv    : Marcelo Pereira Cavalini (p-mcavalini@bvmf.com.br | mpcavalini@gmail.com)
/******************************************************************************/
function abreJanelaPopDinamica(url, nome) {
    // altura e largura proporcional a 85% do tamanho da tela do usuário
    var largura = screen.width * 0.90;
    var altura = screen.height * 0.90;

    var lado = (screen.width - largura) / 2;
    var topo = (screen.height - altura) / 2;
    window.open(url, 'BMFBOVESPA' + nome, 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=' + largura + ',height=' + altura + ',top=' + topo + ',left=' + lado);
}


/******************************************************************************
/ Objetivo  : Abrir Layer(div) e fechar todas as outras que se encontram na página
/ Premissas : O layer é preciso ter a classe(css) divEsconde e divMostra
/ Entradas  : Nome do Layer(div), isto é, o ID
/ Retorno   : nenhum
/ desenv    : Marcelo Pereira Cavalini (p-mcavalini@bvmf.com.br | mpcavalini@gmail.com)
/******************************************************************************/
function divMostra(div) {
    var divs = document.getElementsByTagName('div'); //acumula em memória todas as divs da página
    for (var i = 0; i < divs.length; i++) {         //loop de varredura pelas divs
        if (divs[i].className == "divMostra") { divs[i].className = "divEsconde"; } //verifica se há alguma div aberta e então esta é fechada
    } document.getElementById(div).className = "divMostra";  // mostra a div passada como parametro para a função
}
/******************************************************************************
/ Objetivo  : Carregar Layer(div) "sites do grupo"
/ Premissas : pagina deve possuir framework jquery 1.3.2 ou mais recente
/ Entradas  : idioma do site "i"
/ desenv    : Marcelo Pereira Cavalini (p-mcavalini@bvmf.com.br | mpcavalini@gmail.com)
/******************************************************************************/
function SitesDoGrupo(idioma) {
    $(function() {
        $('#carregar').ajaxStart(function() { $(this).show(); }).ajaxStop(function() { $(this).hide(); });
        $('#contLinkSitesGrp').addClass('sitesAtivo');
        $.get('/shared/sitesDoGrupo' + idioma + '.htm', function(data) {
            $('#sitesGrupo').html(data);
            $('#sitesGrupo').show();
            $('#sitesGrupo').mouseleave(function() { $(this).hide(); $('#contLinkSitesGrp').removeClass('sitesAtivo'); });
            return false;
        });
    });
}


/************************************************************************************************************************
/ Objetivo  : Carregar itens do CEI para o combo - retorna XML Agente Corretoras por ordem de código ou por ordem alfabética
/ Premissas : Nenhuma
/ desenv    : Alan Akamine & Marcelo Pacheco 
/**************************************************************************************************************************/

function CarregarAgenteCorretora(intOrdenacao, objCombo) {

    var vetorOrdenado = new Array(0);      //Variavel que recebe código ordenado
    var codigoCorretoras;                //Variavel que recebe o código das corretoras do xml
    var nomeCorretoras;                //Variavel que recebe o nome das corretoras do xml
    var objRaiz;
    var objAgentesCoretoras;
    var objElement;
    var objFragment;
    var objElementNome;
    var objElementCodigo;
    var i;
    var xmlhttp;
    var eSelect
    var eOption
    var textoOption
    var Aux2; // variavel que recebe o nome em ordem alfabética 
    var Aux1; // variavel de comparação da primeira letra
    var h
    var NodeNameNome
    var NodeNameCodigo

    try {
        if (objCombo.length <= 1) {
            if (window.XMLHttpRequest)          // code for IE7+, Firefox, Chrome, Opera, Safari
            {
                xmlhttp = new XMLHttpRequest();

            }
            else                                // code for IE6, IE5
            {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");

            }
            xmlhttp.open("GET", "/Shared/xml/AgenteCorretora.xml", false);
            xmlhttp.send(null);
            xmlDoc = xmlhttp.responseXML;

            codigoCorretoras = xmlDoc.getElementsByTagName("codigo");
            nomeCorretoras = xmlDoc.getElementsByTagName("nome");


            // retorna codigo por ordem alfabética
            if (intOrdenacao == 0 || intOrdenacao == 3) {

                for (var i = 0; i < codigoCorretoras.length; i++) {
                    vetorOrdenado.push(new Number(codigoCorretoras[i].childNodes[0].nodeValue));
                }

               // vetorOrdenado.sort(CompararValores); // manda para função ordenar em ordem crescente os códigos

                if (window.XMLHttpRequest)          // code for IE7+, Firefox, Chrome, Opera, Safari
                {
                    objRaiz = new XMLHttpRequest();
                }
                else                                // code for IE6, IE5
                {
                    objRaiz = new ActiveXObject("Microsoft.XMLHTTP");
                }

                objRaiz = loadXMLString("<AgentesCorretoras />")
                objAgentesCoretoras = objRaiz.getElementsByTagName("AgentesCorretoras")[0];

                //preenche xml por ordem de código
                for (i = 0; i < vetorOrdenado.length; i++) {
                    try {
                        xmlDoc.setProperty("SelectionLanguage", "XPath")
                        codigoCorretoras = xmlDoc.getElementsByTagName("AgenteCorretora[codigo='" + vetorOrdenado[i] + "']");
                        codigoCorretoras = codigoCorretoras[0];
                    }
                    catch (objExXpath) {
                        codigoCorretoras = xmlDoc.evaluate("//AgentesCorretoras/AgenteCorretora[codigo='" + vetorOrdenado[i] + "']", xmlDoc, null, XPathResult.ANY_TYPE, null);
                        codigoCorretoras = codigoCorretoras.iterateNext()
                    }

                    objElement = objRaiz.createElement("AgenteCorretora");

                    objElementNome = objRaiz.createElement("nome");

                    for (h = 0; h < codigoCorretoras.childNodes.length; h++) {

                        if (codigoCorretoras.childNodes[h].nodeName == "nome") {
                            NodeNameNome = codigoCorretoras.childNodes[h].childNodes[0].nodeValue
                        }
                        if (codigoCorretoras.childNodes[h].nodeName == "codigo") {
                            NodeNameCodigo = codigoCorretoras.childNodes[h].childNodes[0].nodeValue
                        }
                    }

                    objElementNome.appendChild(objRaiz.createTextNode(NodeNameNome));

                    objElementCodigo = objRaiz.createElement("codigo");
                    objElementCodigo.appendChild(objRaiz.createTextNode(NodeNameCodigo));

                    objElement.appendChild(objElementNome);
                    objElement.appendChild(objElementCodigo);


                    objRaiz.documentElement.insertBefore(objElement, objAgentesCoretoras[i]);

                }

                xmlDoc = objRaiz;  // xmlDoc Ordenado por Código
                PopularAgenteCorretora(xmlDoc, objCombo, intOrdenacao);   // manda xml para popular combo - ordem de acordo com sequencia arquivo XML

            }
            
            // ------------------------------------------ monta xml por ordem de código ---------------------------------- //     
            if (intOrdenacao == 1) {
                for (var i = 0; i < codigoCorretoras.length; i++) {
                    vetorOrdenado.push(new Number(codigoCorretoras[i].childNodes[0].nodeValue));
                }

                vetorOrdenado.sort(CompararValores); // manda para função ordenar em ordem crescente os códigos

                if (window.XMLHttpRequest)          // code for IE7+, Firefox, Chrome, Opera, Safari
                {
                    objRaiz = new XMLHttpRequest();
                }
                else                                // code for IE6, IE5
                {
                    objRaiz = new ActiveXObject("Microsoft.XMLHTTP");
                }

                objRaiz = loadXMLString("<AgentesCorretoras />")
                objAgentesCoretoras = objRaiz.getElementsByTagName("AgentesCorretoras")[0];

                //preenche xml por ordem de código
                for (i = 0; i < vetorOrdenado.length; i++) {
                    try {
                        xmlDoc.setProperty("SelectionLanguage", "XPath")
                        codigoCorretoras = xmlDoc.getElementsByTagName("AgenteCorretora[codigo='" + vetorOrdenado[i] + "']");
                        codigoCorretoras = codigoCorretoras[0];
                    }
                    catch (objExXpath) {
                        codigoCorretoras = xmlDoc.evaluate("//AgentesCorretoras/AgenteCorretora[codigo='" + vetorOrdenado[i] + "']", xmlDoc, null, XPathResult.ANY_TYPE, null);
                        codigoCorretoras = codigoCorretoras.iterateNext()
                    }

                    objElement = objRaiz.createElement("AgenteCorretora");

                    objElementNome = objRaiz.createElement("nome");

                    for (h = 0; h < codigoCorretoras.childNodes.length; h++) {

                        if (codigoCorretoras.childNodes[h].nodeName == "nome") {
                            NodeNameNome = codigoCorretoras.childNodes[h].childNodes[0].nodeValue
                        }
                        if (codigoCorretoras.childNodes[h].nodeName == "codigo") {
                            NodeNameCodigo = codigoCorretoras.childNodes[h].childNodes[0].nodeValue
                        }
                    }

                    objElementNome.appendChild(objRaiz.createTextNode(NodeNameNome));

                    objElementCodigo = objRaiz.createElement("codigo");
                    objElementCodigo.appendChild(objRaiz.createTextNode(NodeNameCodigo));

                    objElement.appendChild(objElementNome);
                    objElement.appendChild(objElementCodigo);


                    objRaiz.documentElement.insertBefore(objElement, objAgentesCoretoras[i]);

                }

                xmlDoc = objRaiz;  // xmlDoc Ordenado por Código
                PopularAgenteCorretora(xmlDoc, objCombo, intOrdenacao);   // manda xml ordenado por código para popular combo

            }

        }


    }
    catch (objEx) {
        alert(objEx.message)

    }

}


/************************************************************************************************************************
/ Objetivo  : Popular itens do CEI para o combo - popula combo de acordo com xml CarregarAgenteCorretoras
/ Premissas : pagina deve possuir framework jquery 1.3.2 ou mais recente
/ desenv    : Alan Akamine & Marcelo Pacheco 
/**************************************************************************************************************************/

function PopularAgenteCorretora(xmlDoc, objCombo, intOrdenacao) {
    
    ElementoDadosCombo = xmlDoc.getElementsByTagName("AgenteCorretora")
    Aux1 = "";
    Aux2 = "";

    for (j = 0; j < ElementoDadosCombo.length; j++) {

        for (h = 0; h < ElementoDadosCombo[j].childNodes.length; h++) {
            if (ElementoDadosCombo[j].childNodes[h].nodeName == "nome") {
                NodeNameNome = ElementoDadosCombo[j].childNodes[h].childNodes[0].nodeValue

            }
            if (ElementoDadosCombo[j].childNodes[h].nodeName == "codigo") {
                NodeNameCodigo = ElementoDadosCombo[j].childNodes[h].childNodes[0].nodeValue

            }

        }

        Aux2 = NodeNameNome.substring(0, 1); ; // coloca primeira letra do nó nome XML
        eOption = document.createElement("option"); // Elemento Option

        if (intOrdenacao == 1) {

            textoOption = document.createTextNode(NodeNameCodigo + " - " + NodeNameNome); // Texto do option

        }
        else {
            textoOption = document.createTextNode(NodeNameNome + " - " + NodeNameCodigo); // Texto do option

        }

        eSelect = document.getElementsByTagName("Select")[0]; //Elemento Select


        if (Aux2 != Aux1 && intOrdenacao == 0) { // caso venha da home
            $('.loginCEIOrdemAlfabetica > select').append("<option value='#' class='Form2'>" + Aux2 + "</option>");
            Aux1 = Aux2;
        }
        if (Aux2 != Aux1 && intOrdenacao == 3) { //caso venha do canal eletronico do investidor ( página interna)
            $('.loginCEIOrdemAlfabeticaCanalEletronico > select').append("<option value='#' class='Form2'>" + Aux2 + "</option>");
            Aux1 = Aux2;
        }
        eOption.setAttribute("value", "https://cei.bmfbovespa.com.br/CEI/Shared/Login.aspx?inst=" + NodeNameCodigo);
        eOption.appendChild(textoOption);
        objCombo.appendChild(eOption);
    }

}


/******************************************************************************
/ Objetivo  : Abrir janela nova se tiver link
/ Premissas : nenhuma
/ desenv    : Alan Akamine  & Marcelo Pacheco
/******************************************************************************/

function SelecionarCombo(cboCombo) {

    if (cboCombo.options[cboCombo.selectedIndex].value == "#")
        window.location.href = cboCombo.options[cboCombo.selectedIndex].value;
    else
        window.open(cboCombo.options[cboCombo.selectedIndex].value)

}


/******************************************************************************
/ Objetivo  : Retorna valor ordenado
/ Premissas : nenhuma
/ desenv    : Alan Akamine 
/******************************************************************************/

function CompararValores(intValorA, intValorB) {
    if (intValorA < intValorB) { return -1; }
    else if (intValorA > intValorB) { return 1; }
    else { return 0; }
}


/******************************************************************************
/ Objetivo  : Retorna Objeto XML
/ Premissas : nenhuma
/ desenv    : Marcelo Pacheco

/******************************************************************************/
function loadXMLString(txt) {
    if (window.DOMParser) {
        parser = new DOMParser();
        xmlDoc1 = parser.parseFromString(txt, "text/xml");
    }
    else // Internet Explorer
    {
        xmlDoc1 = new ActiveXObject("Microsoft.XMLDOM");
        xmlDoc1.async = "false";
        xmlDoc1.loadXML(txt);
    }
    return xmlDoc1;
}


/******************************************************************************
/ Objetivo  : Abrir ou fechar camada (div|layer). Utilizado o conceito "toggle", se aberto, fecha e se fechado, abre.
/ Premissas : pagina deve possuir framework jquery 1.3.2 ou mais recente
/ Entradas  : idCamada = nome da camada a ser manipulada (abrir ou fechar), em caso de "<div id='X'>", passar como string= "#X"
/ Entradas  : intTempo = Número inteiro referente ao tempo da animação (em milisegundos)
/ desenv    : Marcelo Pereira Cavalini (p-mcavalini@bvmf.com.br | mpcavalini@gmail.com)
/******************************************************************************/



function camadaToggle(idCamada, intTempo) {
    $(idCamada).slideToggle(intTempo);
}


/***   DICIONARIO DE FINANÇAS   ***/
/***         [ INICIO ]         ***/
var caminhoDicionario = location.protocol + "\/\/" + location.host // Caminho do Dicionario

//Objetivo  : Fechar camadas do dicionário de finanças
//desenv    : Marcelo Pereira Cavalini (p-mcavalini@bvmf.com.br | mpcavalini@gmail.com)
function DicionarioFechar() {
    $("#divDicionario").hide();
    $("#DicResult").hide();
    $("#divDicionario").css("height", "50px");
    $(".dicionario").toggleClass("dicionarioAtivo");
}

//Objetivo  : Montar paragrafos de links vindos do serviço e deixar
//em negrito os caracteres digitados pelo usuário.
//@param    : texto=string concatenada por "||"
//@param    : termo=string de caracteres digitados pelo usuário
//@return   : retorno = string transformada em paragrafos e links
//desenv    : Marcelo Pereira Cavalini (p-mcavalini@bvmf.com.br | mpcavalini@gmail.com)
function MontaResultadoAutocompletar(texto, termo) {
    var vStrTermo = texto;
    var retorno = "";
    var tempItem = "";
    var array = new Array();
    if (vStrTermo != "Dados não encontrados") {
        array = texto.split("||");
        for (i = 0; i < array.length; i++) {
            tempItem = array[i].replace(termo, "<strong>" + termo + "</strong>");
            retorno += "<p><a href=\"javascript:;\" onclick=\"javascript:DicionarioVerSignificado('" + array[i] + "');\">" + tempItem + "</a></p>";
        }
    } else { retorno += "<p>" + vStrTermo + "</p>"; }

    return retorno;
}

//Objetivo  : Fazer chamada da camada do serviço para busca de bervetes em ajax
//@param    : valor= caracteres digitados pelo usuário no campo input
//desenv    : Marcelo Pereira Cavalini (p-mcavalini@bvmf.com.br | mpcavalini@gmail.com)
function DicionarioAutoCompletar(valor) {
    var vStrURL = window.location;
    $("#DicResult").hide();
    $("#divDicionario").animate({ 'height': '50px' }, 300);
    if (valor.length > 3) {
        $.get(caminhoDicionario + '/Dicionario/xml.aspx', { 'termo': $("input.campoBuscaDic:text").val() }, function(dadosXML) {
            $('#resAutoCompletar').html(MontaResultadoAutocompletar(dadosXML, $("input.campoBuscaDic:text").val()));
        });
        $("#resAutoCompletar").show();
        $("input.campoBuscaDic:text").bind("keypress", function(e) {
            if (e.keyCode == 13) { DicionarioVerSignificado($("input.campoBuscaDic:text").val()); }
        });
    }
}

//Objetivo  : Abrir e Fechar camadas do dicionário de finanças (qnd abre, adciona
//css para tela modal e apaga quaisquer caracter digitado no campo input)
//desenv    : Marcelo Pereira Cavalini (p-mcavalini@bvmf.com.br | mpcavalini@gmail.com)
function DicionarioInicioFim() {
    $("#resAutoCompletar").hide();
    $(".dicionario").toggleClass("dicionarioAtivo");
    $("#divDicionario").slideToggle("fast");
    $("input.campoBuscaDic:text").focus().val("");
    $.getScript(caminhoDicionario + "/shared/js/thickbox.js");
    $("head").append("<link>");
    css = $("head").children(":last");
    css.attr({
        rel: "stylesheet",
        type: "text/css",
        href: caminhoDicionario + "/aspnet_client/system_web/2_0_50727/Themes/SiteBmfBovespa/thickbox.css"
    });
}

//Objetivo  : Busca no serviço o significado do verbete (via ajax)
//@param    : verbete = palavra a ser procurada no serviço
//desenv    : Marcelo Pereira Cavalini (p-mcavalini@bvmf.com.br | mpcavalini@gmail.com)
function DicionarioVerSignificado(verbete) {
    var vStrURL = window.location;
    $.get(caminhoDicionario + '/xml.aspx', { 'significado': verbete }, function(dadosXML) {
        $(".interna").html(dadosXML);
    });
    $("#resAutoCompletar").hide();
    $("#divDicionario").animate({ 'height': '400px' }, 700);
    $(".interna").animate({ 'height': '305px' }, 700);
    $("#DicResult").show();
}
/***   DICIONARIO DE FINANÇAS   ***/
/***          [ FIM ]           ***/

// Autor: APSilva
// Data : 06/07/2010
// Funcionalidade : Realizar a passagem de parâmetros padronizado de Aba do componente Telerik para o WebTrend, em páginas onde existir .cs podendo utilizar para páginas estáticas tambem.
// objeto =  Aba utilizada para capturar os dados
// elemento = texto que deseja ser utlizado para para trocar por tag específica inserida no resource
// {tab} = trocar o texto {tab} por texto encontrado no span da tab atual
// {item} = trocar o texto {tabPrincipal}  pelo texto enviando atraves do elemento se for preenchido
// {titulodapagina} = trocar o texto {tabprincipal} pelo texto da tab superior

function executarWebTrands(objeto, elemento) {
    var wtti = objeto.wtti;
    var wtcg = objeto.wtcg
    var wtcgs = objeto.wtcgs
    var url = objeto.wturl
    var tabPrincipal = objeto.item;
    var texto = ""
    var substituir = ""
    if (elemento != null && elemento != undefined && elemento != "") {
        substituir = elemento;
    }

    var mylist = document.getElementById(objeto.id)
    var listitems = mylist.getElementsByTagName("SPAN")

    for (i = 0; i < listitems.length; i++) {
        if (listitems[i].className == "innerWrap") {
            var span_textnode = listitems[i].firstChild;
            texto = span_textnode.data;
        }
    }

    if (wtcg == null || wtcg == undefined)
        wtcg = "";
    if (wtti == null || wtti == undefined)
        wtti = "";
    if (wtcgs == null || wtcgs == undefined)
        wtcgs = "";

    // Trocar o Texto da tabAtual
    wtti = wtti.replace("{aba}", texto);
    wtcg = wtcg.replace("{aba}", texto);
    wtcgs = wtcgs.replace("{aba}", texto);

    // Substituir o Texto da tabPrincipal 
    wtti = wtti.replace("{item}", tabPrincipal);
    wtcg = wtcg.replace("{item}", tabPrincipal);
    wtcgs = wtcgs.replace("{item}", tabPrincipal);

    // Substituir texto do controle enviado na pagina  
    wtti = wtti.replace("{titulodapagina}", substituir);
    wtcg = wtcg.replace("{titulodapagina}", substituir);
    wtcgs = wtcgs.replace("{titulodapagina}", substituir);

    // chamada padrão do webtrend com  parâmetros fixos definidos pelo pessoal da infra, específico para o site
    //alert('url= ' + url + ' - wtti= ' + wtti +  ' - wtcg= ' + wtcg + ' - wtcgs= ' + wtcgs);
    dcsMultiTrack('DCS.dcssip', 'www.bmfbovespa.com.br', 'DCS.dcsuri', url, 'WT.ti', wtti, 'WT.cg_n', wtcg, 'WT.cg_s', wtcgs);
}