export const httpPost = (url, data, functionSucess) => {
    $.ajax({
        url: url, //hacia donde irá la solicitud (ruta)
        type: 'POST', //el metodo http a utilizar
        dataType: 'json', //tipo de datos que se espera recibir del servidor
        data: data
    }) // datos enviados al servidor
    .done(function (response){
        functionSucess(response);
    })//si la respuesta es exitosa (comunicacion)
    .fail(function(jqXHR, textStatus, errorThrown){
        console.log("Error al realizar la solicitud: "+ textStatus, errorThrown);
    })
};