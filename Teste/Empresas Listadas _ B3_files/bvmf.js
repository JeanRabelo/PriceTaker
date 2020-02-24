$(document).ready(function(e) {
    $('a[href$=".pdf"]').attr('download', '');  
	$('a[href$=".txt"]').attr('download', '');  
});

function getQuotSymbCurrDate(urlTarget, cdTarget, quotTarget){
	var finalSymb;
	$.ajax({
		url: urlTarget + quotTarget,
		async: false
	}).then(function(data) {
		var quot = [];
		for(var x in data.Scty)
			if(data.Scty[x].mkt.cd === cdTarget)
				quot.push(data.Scty[x]);
		quot.sort(function(a, b){return new Date(Date.parse(a.asset.AsstSummry.mtrtyCode)).getTime() - new Date(Date.parse(b.asset.AsstSummry.mtrtyCode)).getTime()});
		for(var x in quot)
			if(new Date().getTime() <= new Date(Date.parse(quot[x].asset.AsstSummry.mtrtyCode))){
				finalSymb = quot[x].symb;
				break;
			}
	});
	if (finalSymb === undefined)
		return '';
	var y = finalSymb.substring(finalSymb.length - 2, finalSymb.length);
	finalSymb = finalSymb.replace(y, parseInt(y) + 2000);//ANO ATUAL
	return finalSymb;
}

function get_lang() {
    return g_LumisLocale.substring(0,2);
 }

function htmlDecode(text)
	{
		if ( typeof( text ) != "string" )
			text = text.toString() ;
	
		text = text.split("&amp;").join("&");
		text = text.split("&quot;").join("\"");
		text = text.split( "&lt;").join("<");
		text = text.split("&gt;").join(">");
		text = text.split("&#39;").join("'");
	
		return text ;
	}

function bvmf_resizeIframe(URL) 
{
		
	try 
	{
		window.addEventListener("message", bvmf_resize, false);

		function bvmf_resize(event) {
			
			if (URL!=null)
			{
				var arr = URL.split("/");
				var dominio = arr[0] + "//" + arr[2];
			}
            else {
                dominio = "http://bvmf.bmfbovespa.com.br";
            }		
				
			if (event.origin != dominio) 
		    {
		        return;
		    }
			
		    //do something
			var bvmf_iframe = document.getElementById('bvmf_iframe');
			
			if (bvmf_iframe) 
			{ 
				bvmf_iframe.style.height = event.data + "px";
			}
		    
		}
	} 
	catch (ex)
	{
		alert(ex.Message());
	}
}
function get_param(name) {if(name=(new RegExp('[?&]'+encodeURIComponent(name)+'=([^&]*)')).exec(location.search)) var decoded_param = decodeURIComponent(name[1]); if (decoded_param) return decoded_param; return ""; }
function get_param(name, default_value) {if(name=(new RegExp('[?&]'+encodeURIComponent(name)+'=([^&]*)')).exec(location.search)) var decoded_param = decodeURIComponent(name[1]); if (decoded_param) return decoded_param; return default_value; }

/*
function setIframeSrc() {var parameter = ""; var src = document.getElementById("bvmf_iframe").src; var parameterName = document.getElementById("parameterName"); if(parameterName) { parameter = get_param(parameterName.value); } if(parameter == "") return; var redirect = document.getElementById("redirect"); if(redirect) { src = redirect.value; } if(src == "") return; var newSrc = src + parameter; document.getElementById("bvmf_iframe").src = newSrc; }
*/
function setIframeSrc() {
    var parameter = "";
    var src = document.getElementById("bvmf_iframe").src;
    var parameterName = document.getElementById("parameterName");
    if (parameterName != undefined && parameterName != null) {
        parameter = get_param(parameterName.value);
    }
    if (parameter === undefined || parameter === null || parameter === "") return;
    var redirect = document.getElementById("redirect");
    if (redirect != undefined && redirect != null) {
        src = redirect.value;
    }
    if (src === undefined || src === null || src === "") return;
    var newSrc = src + parameter;
    document.getElementById("bvmf_iframe").src = newSrc;
}
