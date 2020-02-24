//----------------------------------------------------------------------------
//Objetivo: Valida se caracter enviado � n�mero
//Entradas: Caracter
//Sa�da	  : True ou false para o caracter enviado
//----------------------------------------------------------------------------
function ValidateIntegerDigit(inputChar) 
{
	var code = inputChar.charCodeAt(0); //C�digo ASCI do caracter enviado
	
	// Caracteres aceitos: 048 - 057
    return (code >= 48 && code <= 57);
}

//----------------------------------------------------------------------------
//Objetivo: Valida se caracter enviado � letra
//Entradas: Caracter
//Sa�da	  : True ou false para o caracter enviado
//----------------------------------------------------------------------------
function ValidateAlfa(inputChar) 
{
	var code = inputChar.charCodeAt(0); // C�digo ASCII do caracter enviado
	
    // Caracteres aceitos: 065 - 090; 097 - 122;
    return (code >= 65 && code <= 90) || (code >= 97 && code <= 122)
}

//----------------------------------------------------------------------------
//Objetivo: Valida se caracter enviado � letra acentuada
//Entradas: Caracter
//Sa�da	  : True ou false para o caracter enviado
//----------------------------------------------------------------------------
function ValidateAcent(inputChar) 
{
	var code = inputChar.charCodeAt(0); // C�digo ASCII do caracter enviado
	
    // Caracteres aceitos:  192 - 214; 217 - 246; 249 - 255
    return (code >= 192 && code <= 214) || (code >= 217 && code <= 246) || (code >= 249 && code <= 255)
}

//----------------------------------------------------------------------------
//Objetivo: Valida se caracter enviado � caracter especial
//Entradas: Caracter
//Sa�da	  : True ou false para o caracter enviado
//----------------------------------------------------------------------------
function ValidateSpecialChar(inputChar) 
{
	var code = inputChar.charCodeAt(0); // C�digo ASCII do caracter enviado
	
    // Caracteres aceitos: 000 - 031; 033 - 047; 058 - 064; 091 - 096; 123 - 191; 215 - 216; 247 - 248
    return (code >= 0 && code <= 31) || (code >= 33 && code <= 47 && code!=44) || 
           (code >= 58 && code <= 64) || (code >= 91 && code <= 96) || 
           (code >= 123 && code <= 191) || (code >= 215 && code <= 216) || (code >= 247 && code <= 248)
}

//----------------------------------------------------------------------------
//Objetivo: Valida se o caracter enviado � um caracter especial
//Entradas: Caracter
//Sa�da	  : True ou false para o caracter enviado
//----------------------------------------------------------------------------
function ValidateComma(inputChar) 
{
	var code = inputChar.charCodeAt(0); //C�digo ASCII do caracter enviado
	
    return (code == 44) // Caracteres aceitos: 044
}

//----------------------------------------------------------------------------
//Objetivo: Valida digita��o apenas de n�meros
//Entradas: Captura evento do teclado
//Sa�da	  : True se foi digitado um n�mero. False se n�o foi
//----------------------------------------------------------------------------
function ValidateIntegerKey() 
{
	var key = String.fromCharCode(event.keyCode); // Valor da tecla pressionada
	
	event.returnValue = ValidateIntegerDigit(key); // Retorno da valida��o
}

//----------------------------------------------------------------------------
//Objetivo: Retorna dados da �rea de transfer�ncia
//Sa�da	  : Texto armazenado na �rea de transfer�ncia
//----------------------------------------------------------------------------
function GetClipboardData()
{
    if(window.clipboardData.getData('Text')!= null)
	    return (window.clipboardData.getData('Text')).replace(/\t/g,'');

	return '';
}

//----------------------------------------------------------------------------
//Objetivo: Limpa �rea de transfer�ncia
//----------------------------------------------------------------------------
function ClearClipboardData()
{
	return window.clipboardData.setData('Text','');
}

//----------------------------------------------------------------------------
//Objetivo: Remove da string todos os caracteres que n�o aceitem as condi��es
//Entradas: String com o conte�do a ser validado
//Sa�da	  : String com os caracteres inv�lidos removidos
//----------------------------------------------------------------------------
function ValidateNumber(inputText)
{
	var i; //Contador usado para varrer a string
	var retValue = ''; //Retorno da fun��o
	
	for (i=0; i < inputText.length; i++)
	{
		if (!isNaN(inputText.substr(i,1)) && inputText.substr(i,1) != ' ')
			retValue += inputText.substr(i,1);
	}
	return retValue;
}

//----------------------------------------------------------------------------
//Objetivo: Remove da string todos os caracteres que n�o aceitem as condi��es
//Entradas: String com o conte�do a ser validado
//Sa�da	  : String com os caracteres inv�lidos removidos
//----------------------------------------------------------------------------
function RemoveAlfa(inputText)
{
	var retValue = ''; //Retorno da fun��o
	
	for (i=0; i < inputText.length; i++)
	{
		if (!ValidateAlfa(inputText.substr(i,1)))
			retValue += inputText.substr(i,1);
	}
	return retValue;
}

//----------------------------------------------------------------------------
//Objetivo: Remove da string todos os caracteres que n�o aceitem as condi��es
//Entradas: String com o conte�do a ser validado
//Sa�da	  : String com os caracteres inv�lidos removidos
//----------------------------------------------------------------------------
function RemoveAcents(inputText)
{
	var retValue = ''; // Retorno da fun��o
	
	for (i=0; i < inputText.length; i++)
	{
		if (!ValidateAcent(inputText.substr(i,1)))
			retValue += inputText.substr(i,1);
	}
	return retValue;
}

//----------------------------------------------------------------------------
//Objetivo: Remove da string todos os caracteres que n�o aceitem as condi��es
//Entradas: String com o conte�do a ser validado
//Sa�da	  : String com os caracteres inv�lidos removidos
//----------------------------------------------------------------------------
function RemoveNumbers(inputText)
{
	var retValue = ''; // Retorno da fun��o
	
	for (i=0; i < inputText.length; i++)
	{
		if (!ValidateIntegerDigit(inputText.substr(i,1)))
			retValue += inputText.substr(i,1);
	}
	return retValue;
}

//----------------------------------------------------------------------------
//Objetivo: Remove da string todos os caracteres que n�o aceitem as condi��es
//Entradas: String com o conte�do a ser validado
//Sa�da	  : String com os caracteres inv�lidos removidos
//----------------------------------------------------------------------------
function RemoveSpecialChars(inputText)
{
	var retValue = ''; // Retorno da fun��o
	
	for (i=0; i < inputText.length; i++)
	{
		if (!ValidateSpecialChar(inputText.substr(i,1)))
			retValue += inputText.substr(i,1);
	}
	return retValue;
}

//----------------------------------------------------------------------------
//Objetivo: Remove da string todos os caracteres que n�o aceitem as condi��es
//Entradas: String com o conte�do a ser validado
//Sa�da	  : String com os caracteres inv�lidos removidos
//----------------------------------------------------------------------------
function RemoveComma(inputText)
{
	var retValue = ''; // Retorno da fun��o
	
	for (i=0; i < inputText.length; i++)
	{
		if (!ValidateComma(inputText.substr(i, 1)))
			retValue += inputText.substr(i, 1);
	}
	return retValue;
}

//----------------------------------------------------------------------------
//Objetivo: Remove da string todos os caracteres que n�o aceitem as condi��es
//Entradas: String com o conte�do a ser validado
//Sa�da	  : String com os caracteres inv�lidos removidos
//----------------------------------------------------------------------------
function RemoveSpaces(inputText)
{
	var retValue = ''; // Retorno da fun��o
	
	for (i=0; i < inputText.length; i++)
	{
		if (inputText.substr(i,1) != ' ')
			retValue += inputText.substr(i,1);
	}
	return retValue;
}