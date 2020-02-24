//----------------------------------------------------------------------------
//Objetivo: Valida se caracter enviado é número
//Entradas: Caracter
//Saída	  : True ou false para o caracter enviado
//----------------------------------------------------------------------------
function ValidateIntegerDigit(inputChar) 
{
	var code = inputChar.charCodeAt(0); //Código ASCI do caracter enviado
	
	// Caracteres aceitos: 048 - 057
    return (code >= 48 && code <= 57);
}

//----------------------------------------------------------------------------
//Objetivo: Valida se caracter enviado é letra
//Entradas: Caracter
//Saída	  : True ou false para o caracter enviado
//----------------------------------------------------------------------------
function ValidateAlfa(inputChar) 
{
	var code = inputChar.charCodeAt(0); // Código ASCII do caracter enviado
	
    // Caracteres aceitos: 065 - 090; 097 - 122;
    return (code >= 65 && code <= 90) || (code >= 97 && code <= 122)
}

//----------------------------------------------------------------------------
//Objetivo: Valida se caracter enviado é letra acentuada
//Entradas: Caracter
//Saída	  : True ou false para o caracter enviado
//----------------------------------------------------------------------------
function ValidateAcent(inputChar) 
{
	var code = inputChar.charCodeAt(0); // Código ASCII do caracter enviado
	
    // Caracteres aceitos:  192 - 214; 217 - 246; 249 - 255
    return (code >= 192 && code <= 214) || (code >= 217 && code <= 246) || (code >= 249 && code <= 255)
}

//----------------------------------------------------------------------------
//Objetivo: Valida se caracter enviado é caracter especial
//Entradas: Caracter
//Saída	  : True ou false para o caracter enviado
//----------------------------------------------------------------------------
function ValidateSpecialChar(inputChar) 
{
	var code = inputChar.charCodeAt(0); // Código ASCII do caracter enviado
	
    // Caracteres aceitos: 000 - 031; 033 - 047; 058 - 064; 091 - 096; 123 - 191; 215 - 216; 247 - 248
    return (code >= 0 && code <= 31) || (code >= 33 && code <= 47 && code!=44) || 
           (code >= 58 && code <= 64) || (code >= 91 && code <= 96) || 
           (code >= 123 && code <= 191) || (code >= 215 && code <= 216) || (code >= 247 && code <= 248)
}

//----------------------------------------------------------------------------
//Objetivo: Valida se o caracter enviado é um caracter especial
//Entradas: Caracter
//Saída	  : True ou false para o caracter enviado
//----------------------------------------------------------------------------
function ValidateComma(inputChar) 
{
	var code = inputChar.charCodeAt(0); //Código ASCII do caracter enviado
	
    return (code == 44) // Caracteres aceitos: 044
}

//----------------------------------------------------------------------------
//Objetivo: Valida digitação apenas de números
//Entradas: Captura evento do teclado
//Saída	  : True se foi digitado um número. False se não foi
//----------------------------------------------------------------------------
function ValidateIntegerKey() 
{
	var key = String.fromCharCode(event.keyCode); // Valor da tecla pressionada
	
	event.returnValue = ValidateIntegerDigit(key); // Retorno da validação
}

//----------------------------------------------------------------------------
//Objetivo: Retorna dados da área de transferência
//Saída	  : Texto armazenado na área de transferência
//----------------------------------------------------------------------------
function GetClipboardData()
{
    if(window.clipboardData.getData('Text')!= null)
	    return (window.clipboardData.getData('Text')).replace(/\t/g,'');

	return '';
}

//----------------------------------------------------------------------------
//Objetivo: Limpa área de transferência
//----------------------------------------------------------------------------
function ClearClipboardData()
{
	return window.clipboardData.setData('Text','');
}

//----------------------------------------------------------------------------
//Objetivo: Remove da string todos os caracteres que não aceitem as condições
//Entradas: String com o conteúdo a ser validado
//Saída	  : String com os caracteres inválidos removidos
//----------------------------------------------------------------------------
function ValidateNumber(inputText)
{
	var i; //Contador usado para varrer a string
	var retValue = ''; //Retorno da função
	
	for (i=0; i < inputText.length; i++)
	{
		if (!isNaN(inputText.substr(i,1)) && inputText.substr(i,1) != ' ')
			retValue += inputText.substr(i,1);
	}
	return retValue;
}

//----------------------------------------------------------------------------
//Objetivo: Remove da string todos os caracteres que não aceitem as condições
//Entradas: String com o conteúdo a ser validado
//Saída	  : String com os caracteres inválidos removidos
//----------------------------------------------------------------------------
function RemoveAlfa(inputText)
{
	var retValue = ''; //Retorno da função
	
	for (i=0; i < inputText.length; i++)
	{
		if (!ValidateAlfa(inputText.substr(i,1)))
			retValue += inputText.substr(i,1);
	}
	return retValue;
}

//----------------------------------------------------------------------------
//Objetivo: Remove da string todos os caracteres que não aceitem as condições
//Entradas: String com o conteúdo a ser validado
//Saída	  : String com os caracteres inválidos removidos
//----------------------------------------------------------------------------
function RemoveAcents(inputText)
{
	var retValue = ''; // Retorno da função
	
	for (i=0; i < inputText.length; i++)
	{
		if (!ValidateAcent(inputText.substr(i,1)))
			retValue += inputText.substr(i,1);
	}
	return retValue;
}

//----------------------------------------------------------------------------
//Objetivo: Remove da string todos os caracteres que não aceitem as condições
//Entradas: String com o conteúdo a ser validado
//Saída	  : String com os caracteres inválidos removidos
//----------------------------------------------------------------------------
function RemoveNumbers(inputText)
{
	var retValue = ''; // Retorno da função
	
	for (i=0; i < inputText.length; i++)
	{
		if (!ValidateIntegerDigit(inputText.substr(i,1)))
			retValue += inputText.substr(i,1);
	}
	return retValue;
}

//----------------------------------------------------------------------------
//Objetivo: Remove da string todos os caracteres que não aceitem as condições
//Entradas: String com o conteúdo a ser validado
//Saída	  : String com os caracteres inválidos removidos
//----------------------------------------------------------------------------
function RemoveSpecialChars(inputText)
{
	var retValue = ''; // Retorno da função
	
	for (i=0; i < inputText.length; i++)
	{
		if (!ValidateSpecialChar(inputText.substr(i,1)))
			retValue += inputText.substr(i,1);
	}
	return retValue;
}

//----------------------------------------------------------------------------
//Objetivo: Remove da string todos os caracteres que não aceitem as condições
//Entradas: String com o conteúdo a ser validado
//Saída	  : String com os caracteres inválidos removidos
//----------------------------------------------------------------------------
function RemoveComma(inputText)
{
	var retValue = ''; // Retorno da função
	
	for (i=0; i < inputText.length; i++)
	{
		if (!ValidateComma(inputText.substr(i, 1)))
			retValue += inputText.substr(i, 1);
	}
	return retValue;
}

//----------------------------------------------------------------------------
//Objetivo: Remove da string todos os caracteres que não aceitem as condições
//Entradas: String com o conteúdo a ser validado
//Saída	  : String com os caracteres inválidos removidos
//----------------------------------------------------------------------------
function RemoveSpaces(inputText)
{
	var retValue = ''; // Retorno da função
	
	for (i=0; i < inputText.length; i++)
	{
		if (inputText.substr(i,1) != ' ')
			retValue += inputText.substr(i,1);
	}
	return retValue;
}