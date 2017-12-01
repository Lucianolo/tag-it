function getRatings(id){
	localStorage.setItem("p_id", id);
	location.href = "/backend/reviews.html";
}
function modificaProdotto(p_id_now){
	//Riempimento modulo modificaProdotto
	$(".filters").hide();
	$("#nome_prodotto_modifica").val( $("#nome_prodotto_" + p_id_now).text().trim() );
	$("#descrizione_prodotto_modifica").val( $("#descrizione_prodotto_" + p_id_now).html() );
	$("#tipologia_prodotto_modifica").val( $("#tipologia_prodotto_" + p_id_now).val() );
	$("#avatar_p_id").val(p_id_now);
	aggiungiTastiModificaProdotto(p_id_now);
}

function eliminaProdotto(p_id_now){
	$("#eliminaButton").attr('onClick', "eliminaProdottoOk(" + p_id_now + ")" );
}

function eliminaProdottoOk(p_id_now){
	console.log(p_id_now);
	$.post( "/products/delete_product", { id: p_id_now })
		.done(function( data ) {
			if( data.success == 1 ){
				window.location.href = '/prodotti';
			}  else {
				alert("Eliminazione non riuscita.");
			}
	});	
}

function modificaProdottoSalva(p_id_now){
	var nome_prodotto_modifica = $("#nome_prodotto_modifica").val();
	var descrizione_prodotto_modifica = $("#descrizione_prodotto_modifica").val();
	var tipologia_prodotto_modifica = $("#tipologia_prodotto_modifica").val();
	var id_ditta = $("#hidden-id-ditta").val();
	
	$.ajax({
            type: "POST",
            data: JSON.stringify({	id: p_id_now,
            						nome_prodotto: nome_prodotto_modifica ,
            						descrizione_prodotto: descrizione_prodotto_modifica, 
            						categoria: tipologia_prodotto_modifica,
            						ditta: id_ditta
            }),
            contentType: "application/json; charset=utf-8",
            url: "/products/edit/",
            dataType: 'JSON',
            success: function(data) {
            	console.log(data);
            	window.location.href = "/prodotti"
            }
			
	});	
}

function modificaProdottoAnnulla(p_id_now){
	$(".filters").show();
	rimuoviTastiModificaProdotto(p_id_now);
}

function aggiungiProdotto(){
	var button_annulla = "<button type=\"button\" class=\"btn btn-danger\" onclick=\"aggiungiProdottoAnnulla()\"><i class=\"fa fa-times\" aria-hidden=\"true\"></i> Annulla</button>";
	var button_salva = "<button type=\"button\" class=\"btn btn-success\" onclick=\"aggiungiProdottoSalva()\"><i class=\"fa fa-check\" aria-hidden=\"true\"></i> Salva</button>";
	$("#button_container").html("<div class=\"btn-group\" role=\"group\">" + button_salva + button_annulla + "</div>");	
	$(".filters").hide();
	$("#aggiungiProdottoContainer").show();
	$("#ProdottoContainer").hide();
}

function aggiungiProdottoSalva(){
	var nome_prodotto_aggiungi = $("#nome_prodotto_aggiungi").val();
	var descrizione_prodotto_aggiungi = $("#descrizione_prodotto_aggiungi").val();
	var tipologia_prodotto_aggiungi = $("#tipologia_prodotto_aggiungi").val();
	var id_ditta = $("#hidden-id-ditta").val();
	var regione = $("#regione_prodotto_aggiungi").val();
	$.ajax({
            type: "POST",
            data: JSON.stringify({	nome_prodotto: nome_prodotto_aggiungi ,
            						descrizione_prodotto: descrizione_prodotto_aggiungi, 
            						categoria: tipologia_prodotto_aggiungi,
            						ditta: id_ditta
            }),
            contentType: "application/json; charset=utf-8",
            url: "/products/add/",
            dataType: 'JSON',
            success: function(data) {
            	console.log(data);
            	window.location.href = "/prodotti"
            }
			
		});	
}

function aggiungiProdottoAnnulla(){
	$("#aggiungiProdottoContainer").hide();
	$("#button_container").html("<button type=\"button\" class=\"btn btn-default\" onclick=\"aggiungiProdotto()\"><i class=\"fa fa-plus\" aria-hidden=\"true\"></i> Nuovo</button>");
	$("#ProdottoContainer").show();
	$(".filters").show();
}

function settaCampiAggiungi(){
	var campiTipologia = tipologie[$("#tipologia_prodotto_aggiungi").val()].campi;
	$("#campiAggiungi").html("");
	for(var i = 0; i < campiTipologia.length; i++){
		$("#campiAggiungi").append("<div class=\"form-group\"><label for=\"campo_" + i + "\">" + campiTipologia[i].tc_nome + ":</label><input class=\"form-control\" id=\"campo_" + i + "\" style=\"width: 100%;\" placeholder=\"" + campiTipologia[i].tc_nome + "\"/></div>");
	}
}



function aggiungiTastiModificaProdotto(p_id_now){
	var button_annulla = "<button type=\"button\" class=\"btn btn-danger\" onclick=\"modificaProdottoAnnulla(" + p_id_now + ")\"><i class=\"fa fa-times\" aria-hidden=\"true\"></i> Annulla</button>";
	var button_salva = "<button type=\"button\" class=\"btn btn-success\" onclick=\"modificaProdottoSalva(" + p_id_now + ")\"><i class=\"fa fa-check\" aria-hidden=\"true\"></i> Salva</button>";
	$("#button_container").html("<div class=\"btn-group\" role=\"group\">" + button_salva + button_annulla + "</div>");	
	$("#modificaProdottoContainer").show();
	$("#ProdottoContainer").hide();
}

function rimuoviTastiModificaProdotto(p_id_now){
	$("#modificaProdottoContainer").hide();
	var button_modifica = "<div class=\"btn-group\" role=\"group\"><button type=\"button\" class=\"btn btn-default\" onclick=\"modificaProdotto(" + p_id_now + ")\"><i class=\"fa fa-pencil\" aria-hidden=\"true\"></i> Modifica</button><button type=\"button\" class=\"btn btn-danger\" onclick=\"eliminaProdotto(" + p_id_now + ")\" data-toggle=\"modal\" data-target=\"#eliminaModal\"><i class=\"fa fa-trash\" aria-hidden=\"true\"></i> Elimina</button></div>";
	$("#button_container" + p_id_now).html(button_modifica);
	$("#button_container").html("<button type=\"button\" class=\"btn btn-default\" onclick=\"aggiungiProdotto()\"><i class=\"fa fa-plus\" aria-hidden=\"true\"></i> Nuovo</button>");
	$("#modificaProdottoContainer").hide();
	$("#ProdottoContainer").show();
}