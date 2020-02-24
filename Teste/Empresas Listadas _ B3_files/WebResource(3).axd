
function LoadCompareValidators()
{
   for (var i = 0; i < _bovCompareParams.length; i++){
     
      var controls = _bovCompareParams[i].split(";");
      var clientInputID = controls[0];
      var controlToCompare = controls[1];
      
      if (controlToCompare != "")
      {
        EnsureCompareValidator(clientInputID.replace("_text", "_Compare"), controlToCompare)
      }
   }
}

function EnsureCompareValidator(compareValidator, id){

   for (var i = 0; i < _bovControlsInPage.length; i++){
 
      var controlsCompare = _bovControlsInPage[i].split(";");
      
      if (controlsCompare[0] == id)
      {
         document.getElementById(controlsCompare[1]).onblur = function(){ValidatorValidate(eval(compareValidator));}
         document.getElementById(controlsCompare[1]).onclick = function(){document.getElementById(compareValidator).style.display = "none";} 
      }
   }
}

//-----------------------------------------------------------------------
//Objetivo: Fecha mensagem de erro
//Entradas: Identificador da mensagem de erro
//-----------------------------------------------------------------------        
function CloseError(obj){

    var Control_Validators =  new Array(document.getElementById("div_" + obj + "_GroupRequired"),
                                     document.getElementById("div_" + obj + "_Required"), 
                                     document.getElementById("div_" + obj + "_Script"), 
                                     document.getElementById("div_" + obj + "_Range"), 
                                     document.getElementById("div_" + obj + "_Compare"), 
                                     document.getElementById("div_" + obj + "_Expression"),
                                     document.getElementById(obj + '_Range'),
                                     document.getElementById(obj + '_Expression'),
                                     document.getElementById(obj + '_GroupRequired'),
                                     document.getElementById(obj + '_Required'),
                                     document.getElementById(obj + '_Script'),
                                     document.getElementById(obj + '_Compare'));
                                        
    for (var i=0; i<Control_Validators.length; i++)
    {
        if(Control_Validators[i] != null)
            Control_Validators[i].style.display = 'none';
    }
}

//-----------------------------------------------------------------------
//Objetivo: Posicionar cursor no final do texto
//Entradas: Código ASCII do caracter
//-----------------------------------------------------------------------
function SetEnd (textField)
{
    for(iChar=textField.value.length;iChar>=0;iChar--){
        if(textField.value.substring(iChar-1,iChar)!= "/" &&
        textField.value.substring(iChar-1,iChar)!= "_" &&
        textField.value.substring(iChar-1,iChar)!= "-"){
           iPos=iChar;
           break;
        }  
    }
    if (textField.createTextRange){
        var FieldRange = textField.createTextRange();
        FieldRange.moveStart('character', iPos);
        FieldRange.collapse();
        FieldRange.select();
    }
}

//-----------------------------------------------------------------------
//Objetivo: Mostra/Fecha mensagem de erro no grid
//Entradas: Identificador da mensagem de erro
//----------------------------------------------------------------------- 
function ShowErrorInGrid(obj, show)
{
    var controlId = "";
    
    if((typeof obj.id) != "undefined" || obj.id != null)
    {
        controlId = obj.id.replace("_text", "");
    }
    else
    {
        controlId = obj.ClientID;
    }
    
    var _display;
    
    var Grid_Control_Validators = new Array(document.getElementById(controlId + '_Required'),
                                     document.getElementById(controlId + '_Compare'),
                                     document.getElementById(controlId + '_Script'),
                                     document.getElementById(controlId + '_Expression'), 
                                     document.getElementById(controlId + '_Range'),
                                     document.getElementById('div_' + controlId));
    
    if(show)
    { _display = "block"; }
    else
    { _display = "none"; }        
                                        
    for (var i=0; i<Grid_Control_Validators.length; i++)
    {
        if(Grid_Control_Validators[i] != null && Grid_Control_Validators[i].style.display != 'none')
            document.getElementById('div_' + Grid_Control_Validators[i].id).style.display = _display;
    }
}

//-----------------------------------------------------------------------
//Objetivo: Validar somente o campo de comparação
//Entradas: Lista de validadores
//----------------------------------------------------------------------- 
function ValidatorCompareOnly(evt)
{
    var vals = evt.srcElement.Validators;

    if (vals != undefined)
    {
        var i;

        for (i = 0; i < vals.length; i++)
        {
            if (vals[i].id.substring(vals[i].id.length - 8, vals[i].id.length) == '_Compare')
            {
               ValidatorValidate(vals[i]);
            }
        }
        ValidatorUpdateIsValid();    
    }
}

//-----------------------------------------------------------------------
//Objetivo: Validar o preechimento do radio button
//----------------------------------------------------------------------- 
function ValidatorRadio(source, args)
{
    var valid = false
    var radiobto = document.all(document.all(source.id.substr(0, source.id.length - 14)).name);
    
    for (var i = 0; i < radiobto.length && !valid; i++)
    {
        valid = radiobto[i].checked
    }
    
    if (!valid)
    {
        source.style.left = radiobto[radiobto.length - 1].offsetWidth;
        source.style.top = 1;
    }

    args.IsValid=valid;
}

//-----------------------------------------------------------------------
//Objetivo: Atribuir true ou false na propriedade readonly 
//Entradas: Controle e boleano que será atribuido na propriedade readonly
//----------------------------------------------------------------------- 
function setReadOnlyValue(control, value)
{
    
    if (typeof(control) != 'object')
    {
        alert('the first parameter is not a object.');
        return;
    }

    if (typeof(value) != 'boolean')
    {
        alert('the second parameter is not a boolean.');
        return;
    }
 
    if (!(control.tagName == 'TEXTAREA' || (control.tagName == 'INPUT' && (control.type == 'text' || control.type == 'password'))))
    {
        alert("Property readOnly not exist in this control.");
        return;
    }

    if (window[control.id.substring(0, control.id.length - 5)] != undefined)
    {
        window[control.id.substring(0, control.id.length - 5)].ReadOnly=value;
    }

    control.readOnly=value;
}

//-----------------------------------------------------------------------
//Objetivo: Atribuir true ou false na propriedade enable
//Entradas: Controle e boleano que será atribuido na propriedade enable
//----------------------------------------------------------------------- 
function setEnableValue(control, value)
{
    
    if (typeof(control) != 'object')
    {
        alert('the first parameter is not a object.');
        return;
    }

    if (typeof(value) != 'boolean')
    {
        alert('the second parameter is not a boolean.');
        return;
    }
    
    if (window[control.id.substring(0, control.id.length - 5)] != undefined)
    {
        window[control.id.substring(0, control.id.length - 5)].Enable=value;
    }

    control.disabled=!value;
}

//-----------------------------------------------------------------------
//Objetivo: Atribuir um valor na propriedade value 
//Entradas: Controle e o valor que será atribuido na propriedade value
//----------------------------------------------------------------------- 
function setValue(control, value, onlyclient)
{
    
    if (control == null || typeof(control) != 'object')
    {
        alert('the first parameter is not a object.');
        return;
    }

    if (value == null || value == undefined)
    {
        alert('the second parameter is null or undefined.');
        return;
    }

    if (onlyclient == undefined)
    {
        onlyclient = true;
    }
 
    if (window[control.id.substring(0, control.id.length - 5)] != undefined)
    {

        if (onlyclient)
        {
            oldAutoPostBack=window[control.id.substring(0, control.id.length - 5)].AutoPostBack;
            window[control.id.substring(0, control.id.length - 5)].AutoPostBack = false;
        }

        window[control.id.substring(0, control.id.length - 5)].SetValue(value);

        if (onlyclient)
        {
            window[control.id.substring(0, control.id.length - 5)].AutoPostBack=oldAutoPostBack;
        }

    }

    control.value=value;
}

/// <Summary>
/// Fix Bug IE6
/// </Summary> 
function RebindFooterPage()
{
    var divRodape = document.getElementById('divRodape');
    
    if (divRodape != null && typeof(divRodape)!="undefined")
    {
        divRodape.className = "divRodape";
    }
}

var tabControl;

//-----------------------------------------------------------------------
//Objetivo: Validar campos da aba selecionada
//Entradas: nenhuma
//----------------------------------------------------------------------- 
function BovespaValidClientTabSelected(tab)
{
    var tabStripBovespa = window[tab];
    var tabSelected = tabStripBovespa.SelectedTab;
    //var innerValue = tabSelected.DomElement.firstChild.firstChild.innerHTML;
    var outerHTML = tabSelected.DomElement.firstChild.firstChild.outerHTML;
    
    //if (innerValue.indexOf('Error') > -1)
    if(outerHTML.indexOf('BORDER-TOP') > -1)
        Page_ClientValidate();
}

//-----------------------------------------------------------------------
//Objetivo: Criar icone de erro no controle de abas
//Entradas: nenhuma
//----------------------------------------------------------------------- 
window.CreateTabErrorImage = function()
{
    var errorImage = document.createElement("img");
    errorImage.src = "img/error.gif";
    errorImage.style.marginTop = "2px";
    errorImage.style.position = "relative";
    errorImage.style.right = "-10px";
    errorImage.alt = "Error";
    return errorImage;
}

//-----------------------------------------------------------------------
//Objetivo: Adicionar icone de erro na aba
//Entradas: nenhuma
//----------------------------------------------------------------------- 
AttachTabErrorImage = function(pageViewID)
{
    for(var x=0; x < tabControl.Tabs.length; x++)
    {
        if(tabControl.Tabs[x].PageViewID != null && tabControl.Tabs[x].PageViewID == pageViewID)
        {
            //var outerHtml;
            var tab = tabControl.Tabs[x];
            //var errorImage = CreateTabErrorImage();
            //errorImage.AssociatedTab = tab; 
            //tab.DomElement.firstChild.firstChild.innerHTML = "<span style='float:left'>" + tab.Text + "</span>";
            outerHtml = tab.DomElement.firstChild.firstChild.outerHTML;
            outerHtml = outerHtml.replace("<SPAN class=innerWrap>", "<SPAN class='innerWrap' style='border-top:solid 2px #FF0000;'>");
            tab.DomElement.firstChild.firstChild.outerHTML = outerHtml;
            //tab.DomElement.firstChild.firstChild.appendChild(errorImage);
        }
    }
}

//-----------------------------------------------------------------------
//Objetivo: Remover icone de erro do controle de abas
//Entradas: nenhuma
//----------------------------------------------------------------------- 
DettachTabErrorImage = function()
{
    for(var x=0; x < tabControl.Tabs.length; x++)
    {
        var outerHtml;
        var tab = tabControl.Tabs[x];
        //tab.DomElement.firstChild.firstChild.innerHTML = tab.Text;
        outerHtml = tab.DomElement.firstChild.firstChild.outerHTML;
        outerHtml = outerHtml.replace("<SPAN class=innerWrap style=\"BORDER-TOP: #ff0000 2px solid\">", "<SPAN class=innerWrap>");
        tab.DomElement.firstChild.firstChild.outerHTML = outerHtml;
    }
}

//-----------------------------------------------------------------------
//Objetivo: Validar as abas do controle tabstrip
//Entradas: nenhuma
//----------------------------------------------------------------------- 
function ValidateBovespaTabStrip()
{
    DettachTabErrorImage();
    
    for (var i = 0; i < Page_Validators.length; i++) {
        ValidatorValidate(Page_Validators[i]);
        
        if(Page_Validators[i].isvalid == false)
        {
            if (typeof(Page_Validators[i].ParentPageView)!="undefined")
            {
                AttachTabErrorImage(Page_Validators[i].ParentPageView);
            }
        }
    }
}

//-----------------------------------------------------------------------
//Objetivo: Obter a propriedade readonly 
//Entradas: Controle para obter a propriedade readonly
//----------------------------------------------------------------------- 
function getReadOnly(control)
{

    if (typeof(control) != 'object')
    {
        alert('the first parameter is not a object.');
        return;
    }
    
    if (control.tagName == 'TEXTAREA' || (control.tagName == 'INPUT' && (control.type == 'text' || control.type == 'password')))
    {
        return control.readOnly;
    }
    else
    {
        return false;
    }
    
}

//-----------------------------------------------------------------------
//Objetivo: Obter o valor do controle conforme a propriedade 
//          style.textTransform
//Entradas: ID do Controle
//----------------------------------------------------------------------- 
function getTextTransform(idcontrol)
{
    var obj = document.getElementById(idcontrol)
    var value = obj.value;
    
    if (obj.style.textTransform.toLowerCase() == 'uppercase' || obj.style.textTransform.toLowerCase() == 'capitalize' && value.length < 2)
    {
        value = value.toUpperCase();
    }
    else if (obj.style.textTransform.toLowerCase() == 'lowercase')
    {
        value = value.toLowerCase();
    }
    else if (obj.style.textTransform.toLowerCase() == 'capitalize')
    {
        value = value.substr(0, 1).toUpperCase() + value.substr(1).toLowerCase();
    }

    return value;
}