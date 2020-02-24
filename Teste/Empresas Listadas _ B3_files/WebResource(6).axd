/// <Summary>
/// 
/// </Summary>
function ShowHideFilterPopUp(force){
    if (typeof(Page_ClientValidate) == 'function')
    {
        Page_ClientValidate();
    }

    if((force == null || force == false) && (typeof(Page_IsValid)=="undefined" || !Page_IsValid))
        return;

    var div = document.getElementById('divPesquisa');
    var divSeta = document.getElementById('divSetaPesquisa');

    if(div.style.display == 'none')
    {
        divSeta.className = 'divPesquisaPopUpSetaAberto';
        div.style.display = 'block';
    }
    else
    {
        divSeta.className = 'divPesquisaPopUpSetaFechado';
        div.style.display = 'none';
    }

    RebindFooterPage();
}

/// <Summary>
/// 
/// </Summary>
function ManualShowHideFilterPopUp(force, show){
    if (typeof(Page_ClientValidate) == 'function')
    {
        Page_ClientValidate();
    }

    if((force == null || force == false) && (typeof(Page_IsValid)=="undefined" || !Page_IsValid))
        return;
        
    var div = document.getElementById('divPesquisa');
    var divSeta = document.getElementById('divSetaPesquisa');
    
    if(show)
    {
        divSeta.className = 'divPesquisaPopUpSetaAberto';
        div.style.display = 'block';
    }
    else
    {
        divSeta.className = 'divPesquisaPopUpSetaFechado';
        div.style.display = 'none';    
    }
    
    RebindFooterPage();
}

/// <Summary>
/// 
/// </Summary>
function ShowHideFilter(force){

    //Testa se o ajax está em execução
    if (AjaxNS == null || AjaxNS.IsInRequest == false)
    {

        if (typeof(Page_ClientValidate) == 'function')
        {
            Page_ClientValidate();
        }

        if((force == null || force == false) && (typeof(Page_IsValid)=="undefined" || !Page_IsValid))
            return;
            
        var div = document.getElementById('divPesquisa');
        var divSeta = document.getElementById('divSetaPesquisa');
        
        if(div.style.display == 'none')
        {
            divSeta.className = 'divNovaPesquisaSetaAberto';
            div.style.display = 'block';
        }
        else
        {
            divSeta.className = 'divNovaPesquisaSetaFechado';
            div.style.display = 'none';    
        }
        
        RebindFooterPage();
    }
}

/// <Summary>
/// 
/// </Summary>
function ManualShowHideFilter(force, show){

    //Testa se o ajax está em execução
    if (AjaxNS == null || AjaxNS.IsInRequest == false)
    {

        if (typeof(Page_ClientValidate) == 'function')
        {
            Page_ClientValidate();
        }

        if((force == null || force == false) && (typeof(Page_IsValid)=="undefined" || !Page_IsValid))
            return;
            
        var div = document.getElementById('divPesquisa');
        var divSeta = document.getElementById('divSetaPesquisa');
        
        if(show)
        {
            divSeta.className = 'divNovaPesquisaSetaAberto';
            div.style.display = 'block';
        }
        else
        {
            divSeta.className = 'divNovaPesquisaSetaFechado';
            div.style.display = 'none';    
        }
        
        RebindFooterPage();
    }
}


var controlFocus;

/// <Summary>
/// 
/// </Summary>
function SetControlFocus(radWindow, returnValue)
{
    try
    {
        if (controlFocus != undefined)
        {
            document.getElementById(controlFocus).focus();
        }
    }catch(e){
        TryInDivSearch();
    }
}

/// <Summary>
/// 
/// </Summary>
function TryInDivSearch()
{
    try
    {
        var ctrl = document.getElementById(controlFocus);
            
        while (ctrl.parentElement!=null)
        {
	        if(ctrl.id == 'divPesquisa' && ctrl.style.display == 'none')
	        {
	            ShowHideFilter(true);
	            document.getElementById(controlFocus).focus();
	            return;
	        }
	        ctrl = ctrl.parentElement;
        }
    }catch(e){}
}


/// <Summary>
/// 
/// </Summary>
window.showMessage = function(title, message, focusControlID, CallBackFn)
{

    var obj = radalert(message, 450, 150, title);
    
    if ((focusControlID != undefined) && (focusControlID != ''))
    {
        obj.OnClientClose = function() 
        {
            document.getElementById(focusControlID).focus(); 
            if (CallBackFn != undefined) {
                CallBackFn();
            } else if (__callBackMessage != undefined) {
                __callBackMessage();
            }
        };
    }
    else
    {
        if (CallBackFn != undefined)
        {
            obj.OnClientClose = CallBackFn;
        }
        else if (__callBackMessage != undefined)
        {
            obj.OnClientClose = __callBackMessage;
        }
    }
    
    obj.AttachClientEvent("onactivate", function(oWnd)   
    {
       obj.BrowserWindow.focus();
        
        for (i = obj.BrowserWindow.frames.length - 1; i >= 0; i--)
        {
            if (typeof(obj.BrowserWindow.frames[i].name) == "string" && obj.BrowserWindow.frames[i].document.getElementsByTagName('button').length == 1)
                {
                obj.BrowserWindow.frames[i].document.getElementsByTagName('button')(0).focus();
                break;
                }
        }
    });  

    obj.BrowserWindow.focus();

    return false;
}

/// <Summary>
/// 
/// </Summary>
var __callBackMessage;
var __action;

function showConfirm(title, message, CallBackFn)
{

    if (CallBackFn == undefined){
        radconfirm(message, __callBackMessage, 450, 150, null, title);
    }
    else {
        radconfirm(message, CallBackFn, 450, 150, null, title);
    }
}

var objAjaxManager;
var methodCall;
var parameters = new Array()

/// <Summary>
/// 
/// </Summary>  
function confirmCallBackFn(arg)
{
    // if this callback was called by showConfirm, the arg value will be true or false,
    // based on which button the user clicked.
    // if this callback was called by a showMessage, the arg will be an object representing the 
    // radWindow_Alert so it will be forced to 'true'.
    if (arg != false)
    {
        arg = true;
    }
     
    parameters[0] = arg;
    parameters[1] = __action;
    parameters[2] = methodCall;
    parameters[3] = 'BovespaAlert';
        
    objAjaxManager.AjaxRequest(parameters);
}


/// <Summary>
/// 
/// </Summary>  
function CancelRowSelection(eventArgs)              
{   
    if(eventArgs.srcElement)   
    {   
      eventArgs.cancelBubble = true;   
    }   
    else if(e.target)   
    {   
      eventArgs.preventDetault();   
    }   
} 

/// <Summary>
/// 
/// </Summary> 
function RebindFooterPage()
{
    var divRodape = document.getElementById('divRodape');
    
    if (divRodape != null && typeof(divRodape)!="undefined")
    {
        divRodape.className = "divRodape";
    }
}

/// <Summary>
/// 
/// </Summary> 
function RequestExportExcelStarted(bovGrid)
{
   bovGrid.EnableAjax = false;
}

/// <Summary>
/// Open url in modal popup with fixed size
/// </Summary> 
function ShowPopUp(url)
{
   	return window.showModalDialog(url,window,'dialogWidth:600px;dialogHeight:570px;status:0;help:0;scroll:0;close:0');
}

function changecss(theClass, element, value) {

    var cssRules;

    var added = false;
    for (var S = 0; S < document.styleSheets.length; S++) {

        if (document.styleSheets[S]['rules']) {
            cssRules = 'rules';
        } else if (document.styleSheets[S]['cssRules']) {
            cssRules = 'cssRules';
        } else {
            //no rules found... browser unknown
        }

        for (var R = 0; R < document.styleSheets[S][cssRules].length; R++) {
            if (document.styleSheets[S][cssRules][R].selectorText == theClass) {
                if (document.styleSheets[S][cssRules][R].style[element]) {
                    document.styleSheets[S][cssRules][R].style[element] = value;
                    added = true;
                    break;
                }
            }
        }
        if (!added) {
            if (document.styleSheets[S].insertRule) {
                document.styleSheets[S].insertRule(theClass + ' { ' + element + ': ' + value + '; }', document.styleSheets[S][cssRules].length);
            } else if (document.styleSheets[S].addRule) {
                document.styleSheets[S].addRule(theClass, element + ': ' + value + ';');
            }
        }
    }
    
}