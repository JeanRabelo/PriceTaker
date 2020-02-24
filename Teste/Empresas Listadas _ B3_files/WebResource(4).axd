//----------------------------------------------------------------------------
// Objetivo: Retorna o texto com o tamanho especificado, inserindo ou 
//           removendo caracteres à esquerda, se necessário.
// Entradas: text - string inicial
//           char - caractere a ser inserido à esquerda.      
//           num - tamanho da string a ser retornada.
// Saída   : Texto preenchido com os caracteres à esquerda.
//----------------------------------------------------------------------------
function PadLeft(text, ch, num) {
    
    var re = new RegExp(".{" + num + "}$");
    var pad = "";
    if (!ch) ch = " ";
    do {
        pad += ch;
    } while(pad.length < num);
    
    return re.exec(pad + text);
}

//----------------------------------------------------------------------------
// Objetivo: Retorna o texto com o tamanho especificado, inserindo ou 
//           removendo caracteres à direita, se necessário.
// Entradas: text - string inicial
//           char - caractere a ser inserido à direita.      
//           num - tamanho da string a ser retornada.
// Saída   : Texto preenchido com os caracteres à direita.
//----------------------------------------------------------------------------
function PadRight(text, ch, num){
    
    var re = new RegExp("^.{" + num + "}");
    var pad = "";
    if (!ch) ch = " ";
    do {
        pad += ch;
    } while (pad.length < num);
    return re.exec(text + pad);
}

//----------------------------------------------------------------------------
// Objetivo: Remove todos os zeros à esquerda de um valor.
// Entradas: valor - valor com os zeros a esquerda a serem removidos.
// Saída   : Texto sem os zeros à esquerda.
//----------------------------------------------------------------------------
function RemoveLeadingZeros(value){
    return value.replace(/^[0]+/g,"");
}

//----------------------------------------------------------------------------
// Objetivo: Obter o texto selecionado.
//----------------------------------------------------------------------------
function GetSelText()
{
    var txt = '';
     if (window.getSelection)
    {
        txt = window.getSelection();
    }
    else if (document.getSelection)
    {
        txt = document.getSelection();
    }
    else if (document.selection)
    {
        txt = document.selection.createRange().text;
    }
    else return;

    return txt;
}

//----------------------------------------------------------------------------
// Returns the caret (cursor) position of the specified text field.
// Return value range is 0-oField.length.
// http://www.webdeveloper.com/forum/archive/index.php/t-74982.html
//----------------------------------------------------------------------------
function GetCaretPosition (source) {

    // Initialize
    var iCaretPos = 0;

    // IE Support
    if (document.selection) { 
        // Set focus on the element
        source.focus ();
        // To get cursor position, get empty selection range
        var oSel = document.selection.createRange ();
        // Move selection start to 0 position
        oSel.moveStart ('character', -source.value.length);
        // The caret position is selection length
        iCaretPos = oSel.text.length;
    }
    // Firefox support
    else if (source.selectionStart || source.selectionStart == '0')
        iCaretPos = source.selectionStart;

    // Return results
    return (iCaretPos);
}

//----------------------------------------------------------------------------
// Returns the caret (cursor) position of the specified text field.
// Return value range is 0-oField.length.
// http://www.webdeveloper.com/forum/archive/index.php/t-74982.html
// Changes: Returns the remaining position of the caret (relative to the end of the value).
//          Example: The pipe character (|) represents the cursor position
//                   123.|456,00  Before - Returns 4.
//                                Now    - Returns 6.  
//----------------------------------------------------------------------------
function GetInvertedCaretPosition (source) {

    // Initialize
    var iCaretPos = 0;

    // IE Support
    if (document.selection) { 
        // Set focus on the element
        source.focus();
        // To get cursor position, get empty selection range
        var oSel = document.selection.createRange ();
        // Move selection start to 0 position
        oSel.moveStart ('character', -source.value.length);
        // The caret position is selection length
        //iCaretPos = oSel.text.length;
    
        iCaretPos = source.value.length - oSel.text.length;
    }
    // Firefox support
    else if (source.selectionStart || source.selectionStart == '0')
        iCaretPos = source.selectionStart;

    // Return results
    return (iCaretPos);
}

//----------------------------------------------------------------------------
// Sets the caret (cursor) position of the specified text field.
// Valid positions are 0-oField.length.
// http://www.webdeveloper.com/forum/archive/index.php/t-74982.html
// Changed to set the position backwards. (See doGetCaretPosition)
//----------------------------------------------------------------------------
function SetInvertedCaretPosition (source, iCaretPos) {

    // IE Support
    if (document.selection) { 
        // Set focus on the element
        source.focus ();
        
        // Create empty selection range
        var oSel = document.selection.createRange ();
        
        iCaretPos = source.value.length - iCaretPos;

        // Move selection start and end to 0 position
        oSel.moveStart ('character', -source.value.length);
        // Move selection start and end to desired position
        oSel.moveStart ('character', iCaretPos);
        oSel.collapse();
        oSel.select ();
    }
    // Firefox support
    else if (source.selectionStart || source.selectionStart == '0') {
        source.selectionStart = iCaretPos;
        source.selectionEnd = iCaretPos;
        source.focus ();
    }
}

//----------------------------------------------------------------------------
// Format the value received.
// ----------------------------------------------------------------------------
function FormatNumber(value, decimalSize, digitGrouping, maxLength)
{
    // Trim the value
    value =  value.replace(/^\s+|\s+$/g, ''); 
    
    if (value == "")
       return "";
    
    var firstComma = value.indexOf(',');
    if (firstComma > 0)
    {
        var otherComma = value.lastIndexOf(',');
        if (firstComma != otherComma)
        {
            return "";
        }
        var data = value.split(',');
        var tempDecimals = data[1];
        if (tempDecimals.length < decimalSize)
        {
            tempDecimals = PadRight(tempDecimals, '0', decimalSize);
        }
        value = data[0] + tempDecimals;
    }
    
    // Removes dots(.) and commas(,)
    value = value.replace(/[\.,]/g, "");
    
    // Verifies if it is negative and removes the negative symbol (-).
    var sign = true;
    if (value.indexOf('-')>=0)
    {
        sign = false;
        value = value.replace(/[\-]/g, "");
    }
    
    // MaxLength settings
    if ((maxLength != 0) && (value.length > maxLength))
    {
        // If the setted value's length is greater than maxLengthValue, strips the value  
        value = value.substring(0, (maxLength));
    }

    value = RemoveLeadingZeros(value);
    
    if(isNaN(value))
    {
        return "";
    }
    
    if (value.length > decimalSize)
    {
       decimals = value.substring(value.length - decimalSize, value.length);
       num = value.substring(0, value.length - decimalSize);
    }
    else
    {
        decimals = value;
        num = 0;
    }
    
    // Add zeroes to decimals
    decimals = PadLeft(decimals, '0', decimalSize);
    
    if (digitGrouping)
    {
        // Digit Grouping(.)
        for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
           num = num.substring(0,num.length-(4*i+3))+'.'+
           num.substring(num.length-(4*i+3));
    }
    
    // Format the number   
    var formattedValue = (((sign)?'':'-') + num + ((decimalSize > 0)?',':'') + decimals);
    return formattedValue;
}

//----------------------------------------------------------------------------
// Objetivo: Formatação para ser utilizada no evento onChange.
//           Regras de formatação quando o value do controle é alterado por javascript.
// Entradas: source - o controle contendo o número a ser formatado
//           decimalSize - A quantidade de casas decimais.
//           digitGrouping - booleano indicando se devemos separar o número em casa de milhares.
//----------------------------------------------------------------------------
function FormatNumberOnChange(source, decimalSize, digitGrouping)
{
    var sufix = "_text";
    //retira o sufixo "_text" para obter o controle telerik
    control = window[(source.id.substring(0, source.id.length - sufix.length))];

    // Gets the new textbox value.
    if (control.GetTextBoxValue() == null)
       return;
    
    var value = control.GetTextBoxValue();
    var maxLength = source.maxLengthValue;
    var formattedValue = FormatNumber(value, decimalSize, digitGrouping, maxLength)
    control._SetValue(formattedValue);
}

//----------------------------------------------------------------------------
// Objetivo: Validação para ser utilizada no onPaste.
//           Regras de formatação quando um paste é realizado no controle.
// Entradas: source - o controle contendo o número a ser formatado
//           decimalSize - A quantidade de casas decimais.
//           digitGrouping - booleano indicando se devemos separar o número em casa de milhares.
// Saída   : True ou false para o evento do teclado
//----------------------------------------------------------------------------
function FormatNumberOnPaste(source, decimalSize, digitGrouping, allowNegative)
{
    pastedText = GetClipboardData();
    
    var isPositive = true;
    if ((pastedText.indexOf('-') >= 0) && (allowNegative))
    {
        isPositive = false;
    }
    pastedText = pastedText.replace(/[\.,-]/g, "");
    
    var caretPos = GetCaretPosition(source);
    
    var value = source.value;
    value = value.replace(/[\.,-]/g, "");
    
    var length = value.length;
    var pastedTextLength = pastedText.length;
    
    var data = GetSelText();
    caretPos = caretPos - data.length;
    data = data.replace(/[\.,-]/g, "");
    var selectedDataLength = data.length;
    
    if ((length + pastedTextLength - selectedDataLength) > source.maxLengthValue)
    {
        var remaniningLength = source.maxLengthValue - (length - selectedDataLength);
        pastedText = pastedText.substring(0, remaniningLength);
    }

    if (data != '')
    {
        document.selection.clear();
    }
    value = source.value;
    pastedText = ((isPositive)?'':'-') + pastedText;
    
    var newNumber = value.substring(0, caretPos) + pastedText + value.substring(caretPos);
    newNumber = FormatNumber(newNumber, decimalSize, digitGrouping, source.maxLengthValue)
    
    source.value = newNumber;
    
    event.returnValue = false; 
}

//----------------------------------------------------------------------------
// Objetivo: Validação para ser utilizada no onKeyPress.
//           Verifica se a tecla pressionada é um número, o símbolo de negativo 
//           ou backspace.  
// Entradas: booleano indicando se aceita negativos
// Saída   : True ou false para o evento do teclado
//----------------------------------------------------------------------------
function ValidateNumberOnKeyPress(source, negative) 
{
    var negativeKey = 45; //Símbolo de negativo (-).
    var positiveKey = 43; // Símbolo de positivo (+).
    var enterKey = 13; // Enter
    var keyPressed = window.event.keyCode;
    
    // Get the position of the cursor       
    var caretPos = GetInvertedCaretPosition(source);
            
	if (((keyPressed <= 47)||(keyPressed >= 58)) && (keyPressed != 9) && (keyPressed != enterKey) ) //Valor não numérico!
	{
	    if (keyPressed == positiveKey )
	    {
	        source.value = source.value.replace(/[\-]/g, "");
	        // Puts the cursor position in the correct place. 
            SetInvertedCaretPosition (source, caretPos); 
	        window.event.keyCode = 0;
			return false;
	    }
	    
	    if ((keyPressed == negativeKey) && (negative))
	    {
	        source.value = "-" + source.value.replace(/[\-]/g, "");
	        window.event.keyCode = 0;
			return false;
	    }
	    
	    if (!negative || keyPressed != negativeKey && keyPressed != enterKey) 
        {
			window.event.keyCode = 0;
			return false;
		}
	}
	
	// MaxLength settings
    var value = source.value;
    // Removes dots(.) and commas(,) 
    value = value.replace(/[\.,]/g, "");
    
    if ((value.indexOf('-') > 0) && (keyPressed == negativeKey))
    {
        source.value = '-' + source.value.replace(/[\-]/g, "");
        // Puts the cursor position in the correct place. 
        SetInvertedCaretPosition (source, caretPos); 
        window.event.keyCode = 0;
        return;    
    }

    if ((source.maxLengthValue != 0) && (keyPressed != negativeKey) && (value.length >= source.maxLengthValue))
    {
        var data = GetSelText();
        data = data.replace(/[\.,-]/g, "");
        if (data.length == 0)
        {
            window.event.keyCode = 0;
        }    
    }
    
    return true;
}

//----------------------------------------------------------------------------
// Objetivo: Formatação para ser utilizada no onKeyUp.
//           Formata o número inserido no objeto do parâmetro source.  
// Entradas: source - input contendo o valor a ser formatado.
//           decimals - quantidade de casas decimais 
//----------------------------------------------------------------------------
function FormatNumberOnKeyUp(source, decimalSize, digitGrouping)
{
    var backSpaceKey = 8;
    var deleteKey = 46;   
    var leftArrowKey = 37;
    var rightArrowKey = 39;
    var minusKey = 109;
    var plusKey = 107;
    var enterKey = 13;
    var negativeKey = 45; //Símbolo de negativo (-).    
    
    // Validate the key pressed.
    var keyPressed = window.event.keyCode;
    
    
        
    if ((keyPressed == negativeKey) && (!negative))
    {
       return;
	}

    if (( (keyPressed <= 47) || ((keyPressed >= 58)&& (!((keyPressed >= 96)&&(keyPressed <= 105)))) ) &&(keyPressed != backSpaceKey)&&(keyPressed != deleteKey)&&(keyPressed != enterKey))  //Valor não numérico!
    {
	    return;   
    }   

    if (source.value == null)
    {
       return;
    }
    
    
    // Get the position of the cursor       
    var caretPos = GetInvertedCaretPosition (source);
      
  	// MaxLength settings
    var value = source.value;
    value = value.replace(/[\.,]/g, "");
    
    // Trim the value
    value = source.value.replace(/^\s+|\s+$/g, ''); 
    
    if (value == "")
       return;
    
//    if (keyPressed == backSpaceKey)
//    {
//        // Removes dots(.) and commas(,)
//        value = value.replace(/[\.,]/g, "");
//    }
        
//    var firstComma = value.indexOf(',');
//    if (firstComma > 0)
//    {
//        var otherComma = value.lastIndexOf(',');
//        if (firstComma != otherComma)
//        {
//            source.value = "";
//            return;
//        }
//        var data = value.split(',');
//        var tempDecimals = data[1];
//        if (tempDecimals.length < decimalSize)
//        {
//            tempDecimals = PadRight(tempDecimals, '0', decimalSize);
//        }
//        value = data[0] + tempDecimals;
//    }
    
//    // Removes dots(.) and commas(,)
    value = value.replace(/[\.,]/g, "");
    
    // Verifies if it is negative and removes the negative symbol (-).
    var sign = true;
    if (value.indexOf('-')>=0)
    {
        sign = false;
        value = value.replace(/[\-]/g, "");
    }

    value = RemoveLeadingZeros(value);
    
    if(isNaN(value))
    {
        source.value = "";
        return;
    }
    
    if (value.length > decimalSize)
    {
       decimals = value.substring(value.length - decimalSize, value.length);
       num = value.substring(0, value.length - decimalSize);
    }
    else
    {
        decimals = value;
        num = 0;
    }
    
    // Add zeroes to decimals
    decimals = PadLeft(decimals, '0', decimalSize);
    
    if (digitGrouping)
    {
        // Digit grouping(.)
        for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
           num = num.substring(0,num.length-(4*i+3))+'.'+
           num.substring(num.length-(4*i+3));
    }

    // Format the number   
    source.value = (((sign)?'':'-') + num + ((decimalSize > 0)?',':'') + decimals );
    
    // Puts the cursor position in the correct place. 
    SetInvertedCaretPosition (source, caretPos); 
    
}

//----------------------------------------------------------------------------
//Objetivo: Validação universal para quase todos os campos numéricos
//Entradas: Evento do teclado, número de casas decimais e se aceita negativos
//Saída	  : True ou false para o evento do teclado
//----------------------------------------------------------------------------
function ValidateRealNumbersKey(textField, decimalSize, allowNegative) 
{
	var key = String.fromCharCode(event.keyCode);                     // Valor da tecla pressionada
	var retVal = ValidateRealNumberDigit(key, decimalSize, allowNegative);   // Retorno da função
	
	if (event.keyCode == 45 && allowNegative) 
	{
        textField.value = (textField.value.search('-')>=0)? 
                          textField.value.substr(1, textField.maxLength-1): '-' + textField.value;
		event.returnValue = false;
	}
	else
	{
		if (textField.value.search(',') < 0 && (textField.maxLength - 1) == textField.value.length && 
		    document.selection != null && document.selection.type != 'None')
			event.returnValue = false;
		else
			event.returnValue = retVal;			
	}
}

//----------------------------------------------------------------------------
//Objetivo: Valida a colagem de dados em campos numérico real
//Entradas: Objeto campo, se aceita negativos, número de casas decimais
//Saída	  : Objeto campo
//----------------------------------------------------------------------------
function ValidateRealNumbersPaste(textField, allowNegative, decimalSize)
{
	var inputText = GetClipboardData(); // Valor armazenado no clipboard
	var comma;                          // Posição da vírgula, se existir
	ClearClipboardData();

	if (inputText != '')
	{
		inputText = ValidateRealNumber(inputText, allowNegative);
		comma = inputText.search(',');
		
		// Se não aceita decimais, remove tudo a direita da vírgula
		if ((decimalSize == 0) && (comma >-1))
			inputText = inputText.substr(0, comma)
		
		if (textField.maxLength > 0)
            textField.value = (textField.maxLength >= inputText.length)? 
                              inputText: inputText.substr(0, textField.maxLength);
		else
			textField.value = inputText;
	}
}

//----------------------------------------------------------------------------
//Objetivo: Formata número real ao se ganhar o foco
//Entradas: Campo a ser validado, número de casas decimais e se deve ser 
//          formatado na casa dos milhares
//Saída	  : Objeto campo
//----------------------------------------------------------------------------
function FormatRealNumber(textField, decimalSize, formatDecimal)
{
	var doubleValue = new Number(textField.value.replace(',','.')); // Valor sem zeros a esquerda
	var stringValue;    // Valor de devolução
	var comma;          // Posição da vírgula, se existir
	var negative;       // Posição do hífen
    var formatValue;    // Valor de devolução, já formatado conforme as regras
    var decimalAux = counter = position = 0; // Variáveis de apoio
    var integerSize;    // Tamanho da parte inteira do campo
    var splitValue;     // Armazena as porções inteira e decimal do campo
    
	if (isNaN(doubleValue))
		doubleValue = 0;

	if (doubleValue != 0)
		stringValue = new String(doubleValue);
	else
		stringValue = textField.value;
	
	stringValue = stringValue.replace(',',';')
	
	stringValue = stringValue.replace('.','').replace('.','').replace('.','').replace('.','');
	
	stringValue = stringValue.replace(';',',')
	
	comma = stringValue.search(',');
	
	negative = stringValue.search('-');
	formatValue = '';
	
	//alert(textField.maxLength);
	
	if (stringValue != '')
	{
		if (comma == -1)
		{
			if (decimalSize > 0)
				stringValue += "," + GetStringFromRepeatedChar("0", decimalSize);
		}
		else
		{
			decimalAux = (stringValue.substr(comma + 1, decimalSize)).length;			
			if (decimalSize != 0)
			{
				if (decimalAux <= decimalSize)
					stringValue += GetStringFromRepeatedChar("0", decimalSize - decimalAux);
				else
				    stringValue = stringValue.substr(0, stringValue.length - (decimalAux - decimalSize))
			}
		}

		if (decimalSize > 0)
		{
			splitValue = stringValue.split(",");
            integerSize = (negative > -1)? splitValue[0].length - 1: splitValue[0].length;
		}
		else
			integerSize = (negative > -1)? stringValue.length - 1: stringValue.length;
		
		if ((stringValue.substr(0,1) == ",") || (stringValue.substr(0,2) == "-,"))
            stringValue = (negative == -1)? '0' + stringValue: stringValue = '-0' + stringValue.replace("-", "");

		comma = stringValue.search(',');
		if (comma < 0)
			comma = stringValue.length;
		
		formatValue = stringValue.substr(comma);
		if (formatDecimal)
		{
			for (counter = comma - 1; counter >= 0; counter--)
			{
				if (position == 3)
				{
					if (stringValue.substr(counter, 1) != '-')
						formatValue = '.' + formatValue;
					position = 0;
				}
				formatValue = stringValue.substr(counter, 1) + formatValue;
				position++;
			}
		}
		else
			formatValue = stringValue;

		textField.value = formatValue;		
	}
}

//----------------------------------------------------------------------------
//Objetivo: Formata campo numérico real ao se ganhar o foco
//Entradas: Objeto campo, flag indicando que ele aceita negativos
//Saída	  : Objeto campo formatado
//----------------------------------------------------------------------------
function FormatRealNumberOnFocus(textField, allowNegative) 
{
	textField.value = ValidateRealNumber(textField.value, allowNegative);
	textField.select();
}

//----------------------------------------------------------------------------
//Objetivo: Função de apoio para validar a maior parte dos campos numéricos
//Entradas: Caracter, número de casas decimais do campo e se aceita negativos
//Saída	  : True ou false para o caracter enviado
//----------------------------------------------------------------------------
function ValidateRealNumberDigit(inputChar, decimalSize, allowNegative) 
{
//	if (decimalSize > 0)
//	{
		if (allowNegative)
			return ("0123456789-".indexOf(inputChar)>=0);
		else
			return ("0123456789".indexOf(inputChar)>=0);
//	}
//	else{
//		if (allowNegative)
//			return ("0123456789-".indexOf(inputChar)>=0);
//		else
//			return ("0123456789".indexOf(inputChar)>=0);
//	}
}

//----------------------------------------------------------------------------
//Objetivo: Remove da string todos os caracteres que não aceitem as condições
//Entradas: String com o conteúdo a ser validado e flase se aceita negativos
//Saída	  : String com os caracteres inválidos removidos
//----------------------------------------------------------------------------
function ValidateRealNumber(inputText, allowNegative)
{
	var i;           // Contador usado para varrer a string
	var retValue = '';       // Retorno da função
	var comma = false;    // Indica se existe vírgula
	
	for (i=0; i < inputText.length; i++)
	{
		if ((!isNaN(inputText.substr(i,1)) && inputText.substr(i,1) != ' ') || 
		     inputText.substr(i,1) == ',' || (inputText.substr(i,1) == '-' && allowNegative))
		{
			if (inputText.substr(i,1) == ',')
			{
				if (!comma)
				{
					comma = true;
					retValue += inputText.substr(i,1);
				}
			}
			else if (inputText.substr(i,1) == '-' && allowNegative)
			{
				if (i == 0)
					retValue += inputText.substr(i,1);
			}
			else
				retValue += inputText.substr(i,1);
		}
	}
	return retValue;
}

//----------------------------------------------------------------------------
//Objetivo: Monta string com X caracteres repetidos
//Entradas: Caracter a ser repetido, número de repetições
//Saída	  : String com os X caracteres
//***********************************************************************
function GetStringFromRepeatedChar(inputChar, size)
{
	var i;           // Contador usado na repetição
	var string = ''; // String de retorno
	
	for (i = 1; i <= size; i++)
		string += inputChar;
		
	return string;
}

//----------------------------------------------------------------------------
//Objetivo: Formatação do campo de acordo com as casas decimais.
//Entradas: Evento do teclado e número de casas decimais
//Saída	  : True ou false para o evento do teclado
//----------------------------------------------------------------------------
function FormatRealNumber(textField, decimalSize) 
{
    var bNegative = false;
    var divisor = "1";
    
    var txtValor = textField.value.replace("-","").replace("-","");
    txtValor = txtValor.replace(",","");
    if(txtValor != 0)
    {
        if(event.keyCode == 189 || event.keyCode == 109 || !textField.value.search("-"))
			bNegative = true;
    
		for(iDec=1;iDec<=decimalSize;iDec++){
			divisor += "0";}
		textField.value = txtValor/divisor;
		var aNumber = textField.value.split(".");
		if(aNumber[1]>=0)
		{
		    if(aNumber[1].length<decimalSize)
		    {
		        vDecimal = aNumber[1];
		        for(iDec=1;iDec<=decimalSize;iDec++){
		            vDecimal += "0";}
		        textField.value = aNumber[0] + "," + vDecimal.substring(0,decimalSize);
		    }
		}
		else
		{
		    if(decimalSize>0)
		    {
		        vDecimal = "";
	            for(iDec=1;iDec<=decimalSize;iDec++){
	                vDecimal += "0";}
		        textField.value = aNumber[0] + "," + vDecimal.substring(0,decimalSize);
		    }
		    else
		    {
		        textField.value = aNumber[0];
		    }
		}
		
	    textField.value = textField.value.replace(".",",");
		
		if(bNegative)
			textField.value = "-" + textField.value;
		
	}
	else
		textField.value = txtValor;

}

//----------------------------------------------------------------------------
//Objetivo: Verifica na saída do formulário se o campo foi alterado e dispara
//          o evento onchange.
//Entradas: Evento do teclado, número de casas decimais e se aceita negativos
//Saída	  : True ou false para o evento do teclado
//----------------------------------------------------------------------------
function verifyOnChange(source, decimalSize, digitGrouping)
{
    var sufix = "_text";
    FormatNumberOnKeyUp(source, decimalSize, digitGrouping);
    //retira o sufixo "_text" para obter o controle telerik
    control = window[(source.id.substring(0, source.id.length - sufix.length))];
    
    if (control.GetTextBoxValue() != control.InitialValue)
        {
        source.fireEvent('onchange');
        }
}

//-----------------------------------------------------------------------
//Objetivo: Compara dois numeros
//Entradas: Numero1, numero2, operador
//Saída	  : True para comparação OK, de acordo com operador. False, caso contrário.
//-----------------------------------------------------------------------
function CompareNumbers(source, arguments)
{
    var rangeValidator = document.getElementById((source.id.substring(0, source.id.length - 8)) + '_Range');
    
    if(rangeValidator != null)
    {
        if (rangeValidator.style.display == "inline")
        {
            return;
        }
    }
    
    if((typeof source.operatorToCompare) != "undefined")
    {
        var Operator = source.operatorToCompare;
    }
    
    var valValidate = arguments.Value;
    
    if((typeof source.valueToCompare != "undefined"))
    {                          
        var valCompare = source.valueToCompare;
    }

    if((typeof source.controlToCompare != "undefined"))
    {                          
        var valCompare = document.getElementById(source.controlToCompare).value;
    }
    
    if(valValidate!="" && valCompare!="" || source.validateemptytext == "true")
    {
        switch(Operator)
        {
            case "1": arguments.IsValid=(valValidate==valCompare); break;
            case "2": arguments.IsValid=(valValidate!=valCompare); break;
            case "3": arguments.IsValid=(valValidate>valCompare);  break;
            case "4": arguments.IsValid=(valValidate>=valCompare); break;
            case "5": arguments.IsValid=(valValidate<valCompare);  break;
            case "6": arguments.IsValid=(valValidate<=valCompare); break;
            default: break;
        }
    }  
	return;
}

