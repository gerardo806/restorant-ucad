import { httpPost } from "../../resources/dist/js/helpers/ajax.js";

$(document).ready(function () {
    const $formLogin = $('#formLogin'),
        $btnLogin = $('#signIn');

    $formLogin.submit(function (e) {
        e.preventDefault();
    });

    $btnLogin.click(function (e) {
        console.log('click...');
        $formLogin.validate({
            ignore: "",
            rules: {
                username: 'required',
                passUser: 'required'
            },
            messages: {
                username: 'Debe colocar el nombre de usuario',
                passUser: 'Debe colocar la contraseña'
            },
            errorElement: 'span',
            errorPlacement: function (error, element) {
                error.addClass('invalid-feedback');
                element.closest('.msgHelp').append(error);
            },
            highlight: function (element, errorClass, validClass) {
                $(element).addClass('is-invalid');
            },
            unhighlight: function (element, errorClass, validClass) {
                $(element).removeClass('is-invalid');
            },
            submitHandler: function (form) {
                httpPost(
                    'app/models/usuario/login.php',
                    {
                        usuario: $("#username").val(),
                        clave: $("#passUser").val()
                    },
                    function (response) {
                        if (response.success) {
                            location.href = response.url;
                            console.log(response);
                        } else {
                            //console.error(response.error);
                            Swal.fire({
                                title: "<strong>Atención</strong>",
                                icon: "info",
                                html: response.error,
                                showCloseButton: true,
                                showCancelButton: true,
                                focusConfirm: false,
                                confirmButtonText: 'Aceptar',
                                cancelButtonText: 'Cancelar',
                            });
                        }
                    }
                )
            }
        });
    });
});

/* $(document).ready(function () {
    $("#btn_login").click(function () { 
        iniciar_sesion();
    });
});

function iniciar_sesion(){
    $.ajax({
        url: 'app/models/usuario/login.php', //hacia donde irá la solicitud (ruta)
        type: 'POST', //el metodo http a utilizar
        dataType: 'json', //tipo de datos que se espera recibir del servidor
        data: {
            usuario: $("#usuario").val(),
            clave: hex_md5($("#clave").val())
        }
    }) // datos enviados al servidor
    .done(function (response){
        if(response.success){
            location.href=response.url;
        }else{
            //console.error(response.error);
            Swal.fire({
                title: "<strong>Atención</strong>",
                icon: "info",
                html: response.error,
                showCloseButton: true,
                showCancelButton: true,
                focusConfirm: false,
                confirmButtonText: 'Aceptar',
                cancelButtonText: 'Cancelar',
            });
        }
    })//si la respuesta es exitosa (comunicacion)
    .fail(function(jqXHR, textStatus, errorThrown){
        console.log("Error al realizar la solicitud: "+ textStatus, errorThrown);
    })
} */