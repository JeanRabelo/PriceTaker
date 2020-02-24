//----------------------------------------------------------------------------
//Objetivo: Valida a digitação de caracteres alfanuméricos
//Entradas: se aceita alfabeticos, se acentos, se aceita números, se aceita espaços, 
//          se aceita especiais, se aceita apenas maiúsculos
//Saída	  : True se alfanumérico. False se não.
//----------------------------------------------------------------------------
function ValidateAlfanumericKey(blockAlfa, blockAcent, blockNumber, blockSpaces, 
                                blockSpecial, blockComma, charCase) 
{
	var key = String.fromCharCode(event.keyCode); // Valor da tecla pressionada
	
	switch(charCase){
		case 1:
			key = key.toUpperCase();
			event.keyCode = key.charCodeAt(0);
			break;
		case 2:
			key = key.toLowerCase();
			event.keyCode = key.charCodeAt(0);
			break;
	}

	event.returnValue = ((ValidateAlfa(key) && blockAlfa) || (ValidateAcent(key) && blockAcent) || 
	                    (ValidateIntegerDigit(key) && blockNumber) || (key == ' ' && blockSpaces) || 
	                    (ValidateSpecialChar(key) && blockSpecial) || (ValidateComma(key) && blockComma));
}

//----------------------------------------------------------------------------
//Objetivo: Valida colagem de dados em campo Alfanumerico
//Entradas: Objeto campo, se aceita alfabeticos, se aceita acentos, se aceita números, 
//            se aceita espaços, se aceita especiais, se aceita apenas maiúsculos
//Saída	  : Objeto campo
//----------------------------------------------------------------------------
function ValidateAlfanumericPaste(textField, blockAlfa, blockAcent, blockNumber, blockSpaces, 
                                 blockSpecial, blockComma, charCase)
{
    var inputText = GetClipboardData(); // Valor armazenado no clipboard
    
	ClearClipboardData();
	if (inputText != '')	
	{
		switch(charCase)
		{
			case 1: inputText = inputText.toUpperCase(); break;
			case 2: inputText = inputText.toLowerCase(); break;
		}
		if (!blockAlfa)     inputText = RemoveAlfa(inputText);
		if (!blockAcent)    inputText = RemoveAcents(inputText);
		if (!blockNumber)   inputText = RemoveNumbers(inputText);
		if (!blockSpaces)   inputText = RemoveSpaces(inputText);
		if (!blockComma)    inputText = RemoveComma(inputText);
		if (!blockSpecial)  inputText = RemoveSpecialChars(inputText);
		
		if (textField.maxLength > 0)
		{
			if (textField.maxLength >= inputText.length)
				textField.value = inputText;
			else
				textField.value = inputText.substr(0, textField.maxLength);
		}
		else
			textField.value = inputText;
	}
}

//-----------------------------------------------------------------------
//Objetivo: Compara dois numeros
//Entradas: Numero1, numero2, operador
//Saída	  : True para comparação OK, de acordo com operador. False, caso contrário.
//-----------------------------------------------------------------------
function CompareStrings(source, arguments)
{
    var rangeValidator = document.getElementById((source.id.substring(0, source.id.length - 8)) + '_Range');
    var id = source.id.substring(0, source.id.length - 8) + '_text';
    
    if(rangeValidator != null)
    {
        if (rangeValidator.style.display == "inline")
        {
            return;
        }
    }
    
    if((typeof source.operatorToCompare) != undefined)
    {
        var Operator = source.operatorToCompare;
    }
    
    var valValidate = getTextTransform(id);
    
    if((typeof source.valueToCompare != undefined))
    {                          
        var valCompare = source.valueToCompare;
    }

    if((typeof source.controlToCompare != undefined))
    {                          
        var valCompare = getTextTransform(source.controlToCompare);
    }
    
    if (document.getElementById(id).ValidationIgnoreCase != undefined && document.getElementById(id).ValidationIgnoreCase.toLowerCase() == 'true')
    {
        valValidate = valValidate.toLowerCase();
        valCompare = valCompare.toLowerCase();
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
