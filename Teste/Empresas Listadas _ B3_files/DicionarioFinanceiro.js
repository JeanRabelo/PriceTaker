function WebForm_CallbackComplete_SyncFixed() {
    // SyncFix: the original version uses "i" as global thereby resulting in javascript errors when "i" is used elsewhere in consuming pages
    for (var i = 0; i < __pendingCallbacks.length; i++) {
        callbackObject = __pendingCallbacks[i];
        if (callbackObject && callbackObject.xmlRequest && (callbackObject.xmlRequest.readyState == 4)) {
            if (!__pendingCallbacks[i].async) {
                __synchronousCallBackIndex = -1;
            }
            __pendingCallbacks[i] = null;

            var callbackFrameID = "__CALLBACKFRAME" + i;
            var xmlRequestFrame = document.getElementById(callbackFrameID);
            if (xmlRequestFrame) {
                xmlRequestFrame.parentNode.removeChild(xmlRequestFrame);
            }

            // SyncFix: the following statement has been moved down from above;
            WebForm_ExecuteCallback(callbackObject);
        }
    }
}

window.onload = function Onloaad() {
    if (typeof (WebForm_CallbackComplete) == "function") {
        // set the original version with fixed version
        WebForm_CallbackComplete = WebForm_CallbackComplete_SyncFixed;
    }
}

var PREFIXO_AUTOCOMPLETAR = "AC";
var PREFIXO_CONSULTADICIONARIO = "CD";
var PREFIXO_CONSULTAVERBETE = "CV";
var LINK_TAG_INICIO = "[dsverbete]";
var LINK_TAG_FIM = "[/dsverbete]";
var PATH_IMG_ENFIN = "https://bcj.com.br/wsenfin/files/";
var termoConsulta = "";
var consultaEmAndamento = false;

$(document).ready(function() {
   /*
   $("head").append("<link>");
    css = $("head").children(":last");
    css.attr({
        rel: "stylesheet",
        type: "text/css",
        href: "/aspnet_client/system_web/2_0_50727/Themes/SiteBmfBovespa/thickbox.css"
    });
*/
    $("#divDicionario").hide();
    $("#DicResult").hide();
    $(".dicionario").click(function() {
        $("#resAutoCompletar").hide();
        $(this).toggleClass("dicionarioAtivo");
        $("#divDicionario").slideToggle("fast");
        $.getScript("/shared/js/thickbox.js");
        $("head").append("<link>");
        css = $("head").children(":last");
        css.attr({
            rel: "stylesheet",
            type: "text/css",
            href: "/aspnet_client/system_web/2_0_50727/Themes/SiteBmfBovespa/thickbox.css"
        });

    });
    $(".closeDic").click(function() {
        $("#divDicionario").hide();
        $("#resAutoCompletar").hide();
        $("#DicResult").hide();
        $('#resAutoCompletar').html('');
        $('#resAutoCompletar').hide();
        $("input.campoBuscaDic:text").val('')
        $("#divDicionario").css("height", "50px");
      
    });

    //Faz a consulta ao dicionário quando o usuário digita um termo.
		$("#txtCampoBuscaDicionarioFinanceiro").keypress(function(e) {
		var termoAConsultar =  $("#txtCampoBuscaDicionarioFinanceiro").val();
        //var termoAConsultar = document.getElementById('txtCampoBuscaDicionarioFinanceiro').value;
        var pressedKeyCode = (e.keyCode ? e.keyCode : e.which);
        if (!consultaEmAndamento) {
            if (Number(termoAConsultar.length) > 2) {
                consultaEmAndamento = true;
                termoConsulta = termoAConsultar;

                if (pressedKeyCode == 13) {
                    prefixoConsulta = PREFIXO_CONSULTADICIONARIO;
                }
                else {
                    prefixoConsulta = PREFIXO_AUTOCOMPLETAR;
                }

                try {
                    ConsultaServicoDicionario(prefixoConsulta + "||" + termoAConsultar);
                }
                catch (err) {
                    alert(err.description);
                }
            }
            else {
                var termoAConsultarNada = '';
            }
        }
        else {
            var consultaEmAndamentoNada = '';
        }
    });
});

//Refaz a consulta ao dicionário quando for verificado que a chave de pesquisa mudou
function RefazConsultaDicionario() {
    //var termoAConsultar = $('input.campoBuscaDic:text').val();
    var termoAConsultar = $('#txtCampoBuscaDicionarioFinanceiro').val();
    if (termoAConsultar.length > 2) {
        consultaEmAndamento = true;
        termoConsulta = termoAConsultar;
        try {
            ConsultaServicoDicionario(PREFIXO_AUTOCOMPLETAR + "||" + termoAConsultar);
        }
        catch (err) {
            alert(err.message);
        }
    }
    else {
        consultaEmAndamento = false;
        $("#resAutoCompletar").hide();
    }
}

//Faz a consulta à definição do verbete
function ProcessaConsultaVerbete(termo, codigo) {
    if (codigo != null) {
        if (parseInt(codigo) == 0) return;
    }
    $('#txtCampoBuscaDicionarioFinanceiro').val(termo);
    ConsultaServicoDicionario(PREFIXO_CONSULTAVERBETE + "||" + termo);
}

function ResultadoExecucaoClientCallBack(result, context) {
    //var termoConsultaAtualizado = $("input.campoBuscaDic:text").val();
    var termoConsultaAtualizado = $('#txtCampoBuscaDicionarioFinanceiro').val();

    //VERIFICO O TIPO DE CONSULTA
    var resultados = result.split('##');

    //É AC
    if (resultados[0].toUpperCase() == PREFIXO_AUTOCOMPLETAR || resultados[0].toUpperCase() == PREFIXO_CONSULTADICIONARIO) {
        //VERIFICO SE MUDOU O TERMO DE PESQUISA
        if (termoConsultaAtualizado != termoConsulta) {
            //MUDOU
            //REFAÇO A CONSULTA
            consultaEmAndamento = false;
            RefazConsultaDicionario();
        }
        //NÃO MUDOU
        else {
            //APRESENTA RESULTADO
            ApresentaResultadoAutoCompletar(resultados[1], termoConsulta);
            //LIBERA FLAG
            consultaEmAndamento = false; //Esta variável é declarada na classe Bovespa.SiteBmfBovespa.Web.DicionarioFinancas.DicionarioFinancas.Page_Load()
        }
    }
    //NÃO É AC
    else {
        //EXIBE CONSULTA
        ApresentaDefinicaoVerbete(resultados[1])
        //LIBERA FLAG
        consultaEmAndamento = false; //Esta variável é declarada na classe Bovespa.SiteBmfBovespa.Web.DicionarioFinancas.DicionarioFinancas.Page_Load()
    }
}

function ApresentaResultadoAutoCompletar(texto, chavePesquisada) {
    var elementos, codidoTermo, codigo, termo;
    var retorno = "";

    elementos = texto.split("||");
    for (var chave in elementos) {
        codigoTermo = elementos[chave].split("%%");
        codigo = codigoTermo[0];
        termo = codigoTermo[1];
        retorno = retorno.concat("<p><a href=\"javascript:;\" onclick=\"javascript:ProcessaConsultaVerbete('", termo, "', ", codigo, ");\">", termo.replace(chavePesquisada, "<b>" + chavePesquisada + "</b>"), "</a></p>");
    }
    $("#divDicionario").animate({ 'height': '50px' }, 700);
    $("#DicResult").hide();
    $('#resAutoCompletar').html(retorno);
    $('#resAutoCompletar').show();
}

function ApresentaDefinicaoVerbete(definicaoVerbete) {
    $("#painelResultadoConsultaVerbete").html(FormataLinksVerbetes(definicaoVerbete));
    $('#resAutoCompletar').html('');
    $("#resAutoCompletar").hide();
    $("#divDicionario").animate({ 'height': '412px' }, 700);
    $("#painelResultadoConsultaVerbete").animate({ 'height': '305px' }, 700);
    $("#DicResult").show();
	$("b:contains('Veja também')").append("<br />").next().nextAll().addClass("verbeteLista");
	$("b:contains('Ver')").append("<br />").next().nextAll().addClass("verbeteLista");
}

function FormataLinksVerbetes(textoVerbete) {
    var indiceTagInicio, indiceTagFim, textoLink, textoPropriedade;
    var contadorImagem;
    contadorImagem = 0;
    //SUBSTITUIR "[dsverbete]termo[/dsverbete]" por <a href='x'>termo</a>
    while (textoVerbete.indexOf("[dsverbete]", 0) > -1) {
        indiceTagInicio = textoVerbete.indexOf("[dsverbete]", 0);
        indiceTagFim = textoVerbete.indexOf("[/dsverbete]", indiceTagInicio);
        textoLink = textoVerbete.substring(indiceTagInicio + "[/dsverbete]".length - 1, indiceTagFim);
        textoVerbete = textoVerbete.replace("[dsverbete]" + textoLink + "[/dsverbete]", "<a href=\"javascript:;\" onclick=\"javascript:ProcessaConsultaVerbete('" + textoLink + "');\" alt='Ver definição' title='Ver definição'>" + textoLink + "</a>")
    }

    //SUBSTITUIR [b] e [/b] por <b> e </b>
    while (textoVerbete.indexOf("[b]", 0) > -1) textoVerbete = textoVerbete.replace("[b]", "<b>");
    while (textoVerbete.indexOf("[/b]", 0) > -1) textoVerbete = textoVerbete.replace("[/b]", "</b>");

    //SUBSTITUIR [i] e [/i] por <i> e </i>
    while (textoVerbete.indexOf("[i]", 0) > -1) textoVerbete = textoVerbete.replace("[i]", "<i>");
    while (textoVerbete.indexOf("[/i]", 0) > -1) textoVerbete = textoVerbete.replace("[/i]", "</i>");

    //SUBSTITUIR \r\n por <br />
    while (textoVerbete.indexOf("\r\n", 0) > -1) textoVerbete = textoVerbete.replace("\r\n", "<br />");

    //SUBSTITUIR "[dsverbete=termo1]termo2[/dsverbete]" por <a href='funcao(termo1)'>termo2</a>
    while (textoVerbete.indexOf("[dsverbete=", 0) > -1) {
        indiceTagInicio = textoVerbete.indexOf("[dsverbete=", 0);
        indiceTagFim = textoVerbete.indexOf("]", indiceTagInicio);
        textoPropriedade = textoVerbete.substring(indiceTagInicio + "[/dsverbete=".length - 1, indiceTagFim);
        indiceTagFim = textoVerbete.indexOf("[/dsverbete]", indiceTagInicio);
        textoLink = textoVerbete.substring(indiceTagInicio + ("[dsverbete=" + textoPropriedade + "]").length, indiceTagFim);
        textoVerbete = textoVerbete.replace("[dsverbete=" + textoPropriedade + "]" + textoLink + "[/dsverbete]", "<a href=\"javascript:;\" onclick=\"javascript:ProcessaConsultaVerbete('" + textoPropriedade + "');\"  alt='Ver definição' title='Ver definição' >" + textoLink + "</a>")
    }

    //SUBSTITUIR "[img=nome.jpg]Termo[/img]" por "<p><a href="endereco/nome.jpg" class="cam thickbox">termo</a></p>"
    while (textoVerbete.indexOf("[img=", 0) > -1) {
        contadorImagem++;

        indiceTagInicio = textoVerbete.indexOf("[img=", 0);
        indiceTagFim = textoVerbete.indexOf("]", indiceTagInicio);
        textoPropriedade = textoVerbete.substring(indiceTagInicio + "[/img=".length - 1, indiceTagFim);
        indiceTagFim = textoVerbete.indexOf("[/img]", indiceTagInicio);
        textoLink = textoVerbete.substring(indiceTagInicio + ("[img=" + textoPropriedade + "]").length, indiceTagFim);
        textoVerbete = textoVerbete.replace("[img=" + textoPropriedade + "]" + textoLink + "[/img]", '<p class=\"cam\"><a href="javascript:;" onclick="janelaModal(\'' + PATH_IMG_ENFIN + textoPropriedade + '\',' + contadorImagem + ',\'' + textoLink + '\');" id="' + contadorImagem + '">' + textoLink + '</a></p>');
    }
    return textoVerbete;
}

function TeclaEspecial(e) 
{ 
    var charCode = e.keyCode || e.which; 
    if (charCode == 8 || charCode == 46){RefazConsultaDicionario();}
}