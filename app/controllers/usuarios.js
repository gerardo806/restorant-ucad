$(document).ready(function () {
    listar_usuarios();
    listar_rol();
    //listar_sexo();

    const formUsers = new bootstrap.Modal(document.getElementById('usersModal'), {
        keyboard: false
      });

      $('#btn_nuevo_user').on("click", function () {
        $('#frm_registro_user').removeClass('d-none');
        $('#frm_update_user').addClass('d-none');

        $('#frm_registro_user')[0].reset();
        $('#id_rol').val(null).trigger('change');
        formUsers.show();
    });

    $('#frm_registro_user').on("submit", function (e) {
        e.preventDefault();
    });

    $('#frm_update_user').on("submit", function (e) {
        e.preventDefault();
    });

    $('#btn_user_save').click(function (e) {
        $('#frm_registro_user').validate({
            ignore: "",
            rules: {
                usuario: 'required',
                'id_rol': 'required',
                clave: 'required',
                confirmarClave: 'required',
            },
            messages: {
                usuario: 'Debe colocar el nombre de usuario',
                clave: 'Debe colocar una contraseña',
                'id_rol': 'Debe colocar el rol',
                confirmarClave: 'Debe confirmación de la contraseña',
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
                const clave = $('#clave').val(),
                    confirmarClave = $('#confirmarClave').val(),
                    id = $('#id_usuario').val();

                if(clave!== confirmarClave){
                    Swal.fire({
                        title: "<strong>¡Advertencia!</strong>",
                        icon: "warning",
                        html: "Las contraseñas no coinciden",
                        showCloseButton: true,
                        showCancelButton: true,
                        focusConfirm: false,
                        confirmButtonText: 'Aceptar',
                        cancelButtonText: 'Cancelar',
                    });
                }else if(clave.length < 4){
                    Swal.fire({
                        title: "<strong>¡Advertencia!</strong>",
                        icon: "warning",
                        html: "La contraseña debe ser mayor 3 caracteres",
                        showCloseButton: true,
                        showCancelButton: true,
                        focusConfirm: false,
                        confirmButtonText: 'Aceptar',
                        cancelButtonText: 'Cancelar',
                    });
                }else{
                    guardar_data();
                    
                    formUsers.hide();
                }
            }
        });
    });

    $('#btn_user_update').click(function (e) {
        $('#frm_update_user').validate({
            ignore: "",
            rules: {
                usuario: 'required',
                'id_rol': 'required'
            },
            messages: {
                usuario: 'Debe colocar el nombre de usuario',
                'id_rol': 'Debe colocar el rol'
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
                const clave = $('#claveUpdate').val(),
                    confirmarClave = $('#confirmarClaveUpdate').val();

                if(clave !== "" || confirmarClave !== ""){
                    if(clave!== confirmarClave){
                        Swal.fire({
                            title: "<strong>¡Advertencia!</strong>",
                            icon: "warning",
                            html: "Las contraseñas no coinciden",
                            showCloseButton: true,
                            showCancelButton: true,
                            focusConfirm: false,
                            confirmButtonText: 'Aceptar',
                            cancelButtonText: 'Cancelar',
                        });
                        return;
                    }
                }
                
                update_data();
                formUsers.hide();
                
            }
        });
    });

    $('#tbl_usuarios').on('click', '.btn-edit', function () {
        $('#frm_registro_user').addClass('d-none');
        $('#frm_update_user').removeClass('d-none');
        const id = $(this).data('id');
        // Lógica para editar el usuario con el ID obtenido
        console.log('Editar usuario con ID:', id);
        obtener_usuario(id);
    });

    $('#tbl_usuarios').on('click', '.btn-delete', function () {
        const id = $(this).data('id');
        // Lógica para eliminar el usuario con el ID obtenido
        console.log('Eliminar usuario con ID:', id);
        Swal.fire({
            title: "Esta segur@?",
            text: "No se podra revertir este cambio!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            cancelButtonText: "No, cancelar",
            confirmButtonText: "Si, confirmar",
          }).then((result) => {
            if (result.isConfirmed) {
                eliminar_usuario(id);
              } else if (result.isDenied) {
                console.log('Cancelado');
              }
            
          });
    });
});

function listar_usuarios(){
    /*if($.fn.DataTable.isDataTable("#tbl_usuarios")){
        $("#tbl_usuarios").DataTable().clear();
        $("#tbl_usuarios").DataTable().destroy();
    }*/
    $("#tbl_usuarios").DataTable({
        language:{
            url: 'resources/plugins/datatables/spanish.json'
        },
        destroy: true,
        info: true,
        filter: true,
        lengthChange: false,
        pageLength: 10,
        responsive: true,
        processing: true,
        serverSide: true,
        order:[
            [1, 'asc'] //orden alfabetico
        ],
        ajax:{
            url: 'app/models/usuario/listar.php',
            type: 'POST',
            dataType: 'Json',
            complete: function(response) {
                console.log(response.responseJSON);
            }
        },
        columns:[
            {
                data: 'numero'
            },
            {
                data: 'usuario'
            },
            {
                data: 'fecha_creacion'
            },
            {
                data: 'rol'
            },
            {
                data: 'descripcion'
            },
            {
                data: 'idusuario',
                orderable: false,
                searchable: false,
                render: function(data, type, row) {
                    return `
                        <button class="btn btn-primary btn-edit p-2 rounded-1 mx-3" data-id="${data}">Editar</button>
                        <button class="btn btn-danger btn-delete p-2 rounded-1" data-id="${data}">Eliminar</button>
                    `;
                }
            }
        ]
    });
}

function listar_rol(data){
    $("#id_rol").select2({
        placeholder: 'Seleccione un rol',
        ajax:{
            url: 'app/models/rol/listar.php',
            type: 'GET',
            dataType: 'json',
            data: function(params){
                return{
                    query: params.term
                }
            },
            delay: 250,
            processResults: function(data, page){
                return {
                    results: data.data
                }
            },
            cache: true
        },
        theme: 'bootstrap-5',
        allowClear: true,
        minimumInputLength: 0,
        dropdownParent: $('#usersModal')
    });

    $("#id_rolUpdate").select2({
        placeholder: 'Seleccione un rol',
        ajax:{
            url: 'app/models/rol/listar.php',
            type: 'GET',
            dataType: 'json',
            data: function(params){
                return{
                    query: params.term
                }
            },
            delay: 250,
            processResults: function(data, page){
                return {
                    results: data.data
                }
            },
            cache: true
        },
        theme: 'bootstrap-5',
        allowClear: true,
        minimumInputLength: 0,
        dropdownParent: $('#usersModal')
    });

    $("#id_rol").val(null).trigger('change');
    $("#id_rolUpdate").val(null).trigger('change');

    if(data!=undefined && data != null){
        const option = new Option(data.nombre_rol, data.idrol, false, false);
        $("#id_rol").html(option);
        $("#id_rol").trigger('change');
    }
}

function listar_sexo(data){
    $("#id_sexo").select2({
        placeholder: 'Seleccione un sexo',
        ajax:{
            url: 'app/models/usuario/genero.php',
            type: 'GET',
            dataType: 'json',
            data: function(params){
                return{
                    query: params.term
                }
            },
            delay: 250,
            processResults: function(data, page){
                return {
                    results: data.data
                }
            },
            cache: true
        },
        theme: 'bootstrap-5',
        allowClear: true,
        minimumInputLength: 0,
        dropdownParent: $('#usersModal')
    });

    $("#id_sexo").val(null).trigger('change');

    if(data!=undefined && data != null){
        const option = new Option(data.nombre_rol, data.idrol, false, false);
        $("#id_sexo").html(option);
        $("#id_sexo").trigger('change');
    }
}

function guardar_data(){
    let form = $("#frm_registro_user").formJson();
    console.log(form);
    $.ajax({
        url: 'app/models/usuario/guardar_usuario.php', //hacia donde irá la solicitud (ruta)
        type: 'POST', //el metodo http a utilizar
        dataType: 'json', //tipo de datos que se espera recibir del servidor
        data: {
            form: form
        }
    }) // datos enviados al servidor
    .done(function (response){
        if(response.success){
            console.log(response);
            listar_usuarios();
            Swal.fire({
                title: "<strong>Éxito</strong>",
                icon: "success",
                html: response.message,
                showCloseButton: true,
                showCancelButton: true,
                focusConfirm: false,
                confirmButtonText: 'Aceptar',
                cancelButtonText: 'Cancelar',
            });
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
}

function update_data(){
    let form = $("#frm_update_user").formJson();
    console.log(form);
    $.ajax({
        url: 'app/models/usuario/actualizar_usuario.php', //hacia donde irá la solicitud (ruta)
        type: 'POST', //el metodo http a utilizar
        dataType: 'json', //tipo de datos que se espera recibir del servidor
        data: {
            form: form
        }
    }) // datos enviados al servidor
    .done(function (response){
        console.log(response);
        if(response.success){
            listar_usuarios();
            Swal.fire({
                title: "<strong>Éxito</strong>",
                icon: "success",
                html: response.message,
                showCloseButton: true,
                showCancelButton: true,
                focusConfirm: false,
                confirmButtonText: 'Aceptar',
                cancelButtonText: 'Cancelar',
            });
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
}

function obtener_usuario(id){
    $.ajax({
        url: 'app/models/usuario/obtener.php', //hacia donde irá la solicitud (ruta)
        type: 'POST', //el metodo http a utilizar
        dataType: 'json', //tipo de datos que se espera recibir del servidor
        data: {
            idusuario: id
        }
    }) // datos enviados al servidor
    .done(function (response){
        if(response.success){
            console.log(response);
            const usuario = response.resultado[0];
            $('#id_usuario').val(usuario.idusuario);
            $('#usuarioUpdate').val(usuario.usuario);
            const newOption = new Option(usuario.rol, usuario.id_rol, true, true);
            $('#id_rolUpdate').append(newOption).trigger('change');

            $('#usersModal').modal('show');
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
}

function eliminar_usuario(id){
    $.ajax({
        url: 'app/models/usuario/eliminar_usuario.php', //hacia donde irá la solicitud (ruta)
        type: 'POST', //el metodo http a utilizar
        dataType: 'json', //tipo de datos que se espera recibir del servidor
        data: {
            idusuario: id
        }
    }) // datos enviados al servidor
    .done(function (response){
        if(response.success){
            listar_usuarios();

            Swal.fire({
                title: "Borrado!",
                text: response.message,
                icon: "success"
              });
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
}