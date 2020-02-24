    /// Fun��o JavaScript para trocar texto fixo gerado por compotente da infra 
    /// Criado por  Apsilva
    /// Data : 05/10/ 2009
    ///Altera��o:
    ///Inclus�o do par�metro indiceControle para poder tratar os validator pelo indice
    ///vvanalli.7comm - 22/10/2009
    function traduzirTextoValidacaoIdioma(textoIdioma, controleIdioma, indiceControle)
    {
        if(indiceControle == undefined)
        {
            indiceControle = 0;
        }
    
        // Validar se existe texto e controle enviado    
        if (textoIdioma !=null && controleIdioma !=null)  
        {
            // gera uma matriz  a partir do texto do idioma 
            var texto = textoIdioma.split('|');        
            
            // gera uma matriz  a partir do controle idioma
            var controles = controleIdioma.split('|');
            
            if ( texto.length != controles.length) 
            {   
                alert ("O n�mero de par�metros t�m que ser id�nticos "); 
               
                return; 
            }
            
            // Para cada texto e controle enviado percorer a matriz e atribuir o texto recebido
                
             for (var i=0; i <texto.length; i++) 
             {
//                    var control =  window.document.getElementById(controles[i]);   
//                    if (control != null  ) 
//				    {
//                        // If aficionado devido  a incompatibilidade de alguns browsers principalmente o firefox a respeito da propriedade 
//                        // innerHtml	        
//					    if ( document.all)
//					    {
//						    control.innerText = texto[i];
//					    }
//					    else
//					    {
//						    control.textContent = texto[i];
//					    }
//				    }

                    var controles =  getElementsByIdAndTagName(controles[i], 'td');
                    if (controles[indiceControle] != null  ) 
				    {
                        // If aficionado devido  a incompatibilidade de alguns browsers principalmente o firefox a respeito da propriedade 
                        // innerHtml	        
					    if ( document.all)
					    {
						    controles[indiceControle].innerText = texto[i];
					    }
					    else
					    {
						    controles[indiceControle].textContent = texto[i];
					    }
				    }
             }
         
         }  
         
         else
         {
            alert ('Par�metros n�o podem ser vazios'); 
         }
    }
    
    //Fun��o Javascript para recuprar mais de um controle com o mesmo ID
    //Cria��o: vvanalli.7comm
    //22/10/2009
    function getElementsByIdAndTagName(elementId, tagName)
    {
        var todasDivs=[];
		var arrDivs = document.getElementsByTagName(tagName);
		for(var i = 0; i<arrDivs.length; i++)
		{
			if (arrDivs[i].id == elementId)
			{
				todasDivs.push(arrDivs[i]);
			}
		}
		return todasDivs;
    }


