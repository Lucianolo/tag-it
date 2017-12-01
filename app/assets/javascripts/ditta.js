function modificaDitta(){
    //Riempimento modulo modificaDitta
    $("#nome_ditta_modifica").val( $("#nome_ditta").html() );
    $("#descrizione_ditta_modifica").val( $("#descrizione_ditta").html() );
    $("#web_ditta_modifica").val( $("#web_ditta").html() );
    $("#mail_ditta_modifica").val( $("#mail_ditta").html() );
    $("#social_ditta_modifica").val( $("#social_ditta").html() );
    $("#telefono_ditta_modifica").val( $("#telefono_ditta").html() );
    $("#indirizzo_ditta_modifica").val( $("#indirizzo_ditta").html() );
    aggiungiTastiModificaDitta();
}

function modificaDittaSalva(){
    var nome_ditta_modifica = $("#nome_ditta_modifica").val();
    var descrizione_ditta_modifica = $("#descrizione_ditta_modifica").val();
    var web_ditta_modifica = $("#web_ditta_modifica").val();
    var mail_ditta_modifica = $("#mail_ditta_modifica").val();
    var social_ditta_modifica = $("#social_ditta_modifica").val();
    var telefono_ditta_modifica = $("#telefono_ditta_modifica").val();
    var indirizzo_ditta_modifica = $("#indirizzo_ditta_modifica").val();
    $.post( "../php/set_ditta.php", { d_id_pass: d_id_now, d_nome_pass: nome_ditta_modifica, d_descrizione_pass: descrizione_ditta_modifica, d_web_pass: web_ditta_modifica, d_mail_pass: mail_ditta_modifica, d_social_pass: social_ditta_modifica, d_telefono_pass: telefono_ditta_modifica, d_indirizzo_pass: indirizzo_ditta_modifica })
        .done(function( data ) {
            var response = JSON.parse(data);
            if( response.success == 1 && document.getElementById("avatar").files.length > 0 ){
                $( "#avatarForm" ).submit();
            } else {
                window.location.href = './index.html';
            }
        });
}

function modificaDittaAnnulla(){
    rimuoviTastiModificaDitta();
}

function aggiungiTastiModificaDitta(){
    $('.home_button').hide();
    $('.edit_buttons').show();
    $("#DittaContainer").hide();
    $("#modificaDittaContainer").show();

}

function rimuoviTastiModificaDitta(){
	$("#modificaDittaContainer").hide();
    $('.edit_buttons').hide();
    $('.home_button').show();
	$("#DittaContainer").show();
}
