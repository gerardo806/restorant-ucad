$(document).ready(function () {
    listar_bebidas();
    listar_tipoBebida();
    //listar_sexo();

    const formBebida = new bootstrap.Modal(document.getElementById('bebidaModal'), {
        keyboard: false
      });

      $('#btn_nuevo_bebida').on("click", function () {
          $('#frm_update_bebida').addClass('d-none');
        $('#frm_registro_bebida').removeClass('d-none');

        $('#frm_registro_bebida')[0].reset();
        $('#id_bebida').val(null).trigger('change');
        formBebida.show();
    });

    $('#precio').on("input", function () {
        this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');
    });

    $('#precioUpdate').on("input", function () {
        this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');
    });

    $('#frm_registro_bebida').on("submit", function (e) {
        e.preventDefault();
    });

    $('#frm_update_bebida').on("submit", function (e) {
        e.preventDefault();
    });

    $('#btn_bebida_save').click(function (e) {
        $('#frm_registro_bebida').validate({
            ignore: "",
            rules: {
                cantidad: 'required',
                'id_bebida': 'required',
                precio: 'required',
            },
            messages: {
                cantidad: 'Debe colocar el nombre de usuario',
                precio: 'Debe colocar una contraseña',
                'id_bebida': 'Debe colocar el rol'
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
                const precio = $('#precio').val();
                const cantidad = $('#cantidad').val();

                if (!(/^\d+(\.\d{1,})?$/ig.test(precio))) {
                    Swal.fire({
                        title: "<strong>¡Advertencia!</strong>",
                        icon: "warning",
                        html: "EL precio de la bebida es incorrecto",
                        showCloseButton: true,
                        showCancelButton: true,
                        focusConfirm: false,
                        confirmButtonText: 'Aceptar',
                        cancelButtonText: 'Cancelar',
                    });
                } else if (cantidad.length < 4) {
                    Swal.fire({
                        title: "<strong>¡Advertencia!</strong>",
                        icon: "warning",
                        html: "La cantidad de la bebida debe ser mayor a 3 caracteres",
                        showCloseButton: true,
                        showCancelButton: true,
                        focusConfirm: false,
                        confirmButtonText: 'Aceptar',
                        cancelButtonText: 'Cancelar',
                    });
                } else {
                    guardar_data();
                    formBebida.hide();
                }
            }
        });
    });

    $('#btn_bebida_update').click(function (e) {
        $('#frm_update_bebida').validate({
            ignore: "",
            rules: {
                cantidadUpdate: 'required',
                'id_bebidaUpdate': 'required',
                precioUpdate: 'required',
            },
            messages: {
                cantidadUpdate: 'Debe colocar el nombre de usuario',
                precioUpdate: 'Debe colocar una contraseña',
                'id_bebidaUpdate': 'Debe colocar el rol'
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
                const precio = $('#precioUpdate').val();
                const cantidad = $('#cantidadUpdate').val();

                if (!(/^\d+(\.\d{1,})?$/ig.test(precio))) {
                    Swal.fire({
                        title: "<strong>¡Advertencia!</strong>",
                        icon: "warning",
                        html: "EL precio de la bebida es incorrecto",
                        showCloseButton: true,
                        showCancelButton: true,
                        focusConfirm: false,
                        confirmButtonText: 'Aceptar',
                        cancelButtonText: 'Cancelar',
                    });
                } else if (cantidad.length < 4) {
                    Swal.fire({
                        title: "<strong>¡Advertencia!</strong>",
                        icon: "warning",
                        html: "La cantidad de la bebida debe ser mayor a 3 caracteres",
                        showCloseButton: true,
                        showCancelButton: true,
                        focusConfirm: false,
                        confirmButtonText: 'Aceptar',
                        cancelButtonText: 'Cancelar',
                    });
                } else {
                    update_data();
                    formBebida.hide();
                }
            }
        });
    });

    $('#tbl_bebidas').on('click', '.btn-edit', function () {
        $('#frm_registro_bebida').addClass('d-none');
        $('#frm_update_bebida').removeClass('d-none');
        const id = $(this).data('id');
        // Lógica para editar el usuario con el ID obtenido
        console.log('Editar usuario con ID:', id);
        obtener_bebida(id);
    });

    $('#tbl_bebidas').on('click', '.btn-delete', function () {
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
                eliminar_bebidas(id);
              } else if (result.isDenied) {
                console.log('Cancelado');
              }
            
          });
    });
});

function listar_bebidas(){
    /*if($.fn.DataTable.isDataTable("#tbl_usuarios")){
        $("#tbl_usuarios").DataTable().clear();
        $("#tbl_usuarios").DataTable().destroy();
    }*/
    $("#tbl_bebidas").DataTable({
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
            url: 'app/models/menus/bebidas/listar.php',
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
                data: 'bebida'
            },
            {
                data: 'cantidad'
            },
            {
                data: 'precio'
            },
            {
                data: 'estado'
            },
            {
                data: 'idbebida',
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

function listar_tipoBebida(data){
    $("#id_bebida").select2({
        placeholder: 'Seleccione un tipo de bebida',
        ajax:{
            url: 'app/models/menus/bebidas/listarTipoBebida.php',
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
        dropdownParent: $('#bebidaModal')
    });

    $("#id_bebidaUpdate").select2({
        placeholder: 'Seleccione un tipo de bebida',
        ajax:{
            url: 'app/models/menus/bebidas/listarTipoBebida.php',
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
        dropdownParent: $('#bebidaModal')
    });

    $("#id_bebida").val(null).trigger('change');
    $("#id_bebida").val(null).trigger('change');

    if(data!=undefined && data != null){
        const option = new Option(data.nombre_rol, data.idrol, false, false);
        $("#id_bebida").html(option);
        $("#id_bebida").trigger('change');
    }
}


function guardar_data(){
    let form = $("#frm_registro_bebida").formJson();
    console.log(form);
    $.ajax({
        url: 'app/models/menus/bebidas/guardar_bebida.php', //hacia donde irá la solicitud (ruta)
        type: 'POST', //el metodo http a utilizar
        dataType: 'json', //tipo de datos que se espera recibir del servidor
        data: {
            form: form
        }
    }) // datos enviados al servidor
    .done(function (response){
        if(response.success){
            console.log(response);
            listar_bebidas();
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
    let form = $("#frm_update_bebida").formJson();
    console.log(form);
    $.ajax({
        url: 'app/models/menus/bebidas/actualizar_bebidas.php', //hacia donde irá la solicitud (ruta)
        type: 'POST', //el metodo http a utilizar
        dataType: 'json', //tipo de datos que se espera recibir del servidor
        data: {
            form: form
        }
    }) // datos enviados al servidor
    .done(function (response){
        console.log(response);
        if(response.success){
            listar_bebidas();
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

function obtener_bebida(id){
    $.ajax({
        url: 'app/models/menus/bebidas/obtener.php', //hacia donde irá la solicitud (ruta)
        type: 'POST', //el metodo http a utilizar
        dataType: 'json', //tipo de datos que se espera recibir del servidor
        data: {
            idbebida: id
        }
    }) // datos enviados al servidor
    .done(function (response){
        if(response.success){
            console.log(response);
            const bebida = response.resultado[0];
            $('#idbebida').val(bebida.idbebida);
            $('#cantidadUpdate').val(bebida.cantidad);
            $('#precioUpdate').val(bebida.precio);
            const newOption = new Option(bebida.nombre_bebida, bebida.idtipo_bebida, true, true);
            $('#id_bebidaUpdate').append(newOption).trigger('change');

            $('#bebidaModal').modal('show');
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

function eliminar_bebidas(id){
    $.ajax({
        url: 'app/models/menus/bebidas/eliminar_bebidas.php', //hacia donde irá la solicitud (ruta)
        type: 'POST', //el metodo http a utilizar
        dataType: 'json', //tipo de datos que se espera recibir del servidor
        data: {
            idbebida: id
        }
    }) // datos enviados al servidor
    .done(function (response){
        if(response.success){
            listar_bebidas();

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