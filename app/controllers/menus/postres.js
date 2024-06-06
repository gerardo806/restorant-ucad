$(document).ready(function () {
    listar_platillos();

    const formMenus = new bootstrap.Modal(document.getElementById('postreModal'), {
        keyboard: false
    });

    $('#btn_nuevo_postre').on("click", function () {
        $('#frm_registro_postre').removeClass('d-none');
        $('#frm_update_postre').addClass('d-none');

        $('#frm_registro_postre')[0].reset();
        formMenus.show();
    });

    $('#precio').on("input", function () {
        this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');
    });

    $('#precioUpdate').on("input", function () {
        this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');
    });

    $('#frm_registro_postre').on("submit", function (e) {
        e.preventDefault();
    });

    $('#frm_update_postre').on("submit", function (e) {
        e.preventDefault();
    });

    $('#btn_postre_save').click(function (e) {
        $('#frm_registro_postre').validate({
            ignore: "",
            rules: {
                postre: 'required',
                precio: 'required',
                descripcion: 'required',
            },
            messages: {
                postre: 'Debe colocar el nombre del postre',
                precio: 'Debe colocar el precio del postre',
                descripcion: 'Debe colocar la descripción del postre',
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
                const platillo = $('#postre').val();
                const descripcion = $('#descripcion').val();

                if (!(/^\d+(\.\d{1,})?$/ig.test(precio))) {
                    Swal.fire({
                        title: "<strong>¡Advertencia!</strong>",
                        icon: "warning",
                        html: "EL precio del platillo es incorrecto",
                        showCloseButton: true,
                        showCancelButton: true,
                        focusConfirm: false,
                        confirmButtonText: 'Aceptar',
                        cancelButtonText: 'Cancelar',
                    });
                } else if (postre.length < 4) {
                    Swal.fire({
                        title: "<strong>¡Advertencia!</strong>",
                        icon: "warning",
                        html: "El nombre del platillo debe ser mayor 3 caracteres",
                        showCloseButton: true,
                        showCancelButton: true,
                        focusConfirm: false,
                        confirmButtonText: 'Aceptar',
                        cancelButtonText: 'Cancelar',
                    });
                }else if (descripcion.length < 4) {
                    Swal.fire({
                        title: "<strong>¡Advertencia!</strong>",
                        icon: "warning",
                        html: "La descripción del platillo debe ser mayor 3 caracteres",
                        showCloseButton: true,
                        showCancelButton: true,
                        focusConfirm: false,
                        confirmButtonText: 'Aceptar',
                        cancelButtonText: 'Cancelar',
                    });
                } else {
                    guardar_data();

                    formMenus.hide();
                }
            }
        });
    });

    $('#btn_postre_update').click(function (e) {
        $('#frm_update_postre').validate({
            ignore: "",
            rules: {
                postreUpdate: 'required',
                precioUpdate: 'required',
                descripcionUpdate: 'required',
            },
            messages: {
                postreUpdate: 'Debe colocar el nombre del postre',
                precioUpdate: 'Debe colocar el precio del postre',
                descripcionUpdate: 'Debe colocar la descripción del postre',
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
                const platillo = $('#postreUpdate').val();
                const descripcion = $('#descripcionUpdate').val();

                if (!(/^\d+(\.\d{1,})?$/ig.test(precio))) {
                    Swal.fire({
                        title: "<strong>¡Advertencia!</strong>",
                        icon: "warning",
                        html: "EL precio del platillo es incorrecto",
                        showCloseButton: true,
                        showCancelButton: true,
                        focusConfirm: false,
                        confirmButtonText: 'Aceptar',
                        cancelButtonText: 'Cancelar',
                    });
                } else if (postre.length < 4) {
                    Swal.fire({
                        title: "<strong>¡Advertencia!</strong>",
                        icon: "warning",
                        html: "El nombre del platillo debe ser mayor 3 caracteres",
                        showCloseButton: true,
                        showCancelButton: true,
                        focusConfirm: false,
                        confirmButtonText: 'Aceptar',
                        cancelButtonText: 'Cancelar',
                    });
                }else if (descripcion.length < 4) {
                    Swal.fire({
                        title: "<strong>¡Advertencia!</strong>",
                        icon: "warning",
                        html: "La descripción del platillo debe ser mayor 3 caracteres",
                        showCloseButton: true,
                        showCancelButton: true,
                        focusConfirm: false,
                        confirmButtonText: 'Aceptar',
                        cancelButtonText: 'Cancelar',
                    });
                } else {
                    update_data();

                    formMenus.hide();
                }
            }
        });
    });

    $('#tbl_postres').on('click', '.btn-edit', function () {
        $('#frm_registro_postre').addClass('d-none');
        $('#frm_update_postre').removeClass('d-none');
        const id = $(this).data('id');
        // Lógica para editar el usuario con el ID obtenido
        console.log('Editar usuario con ID:', id);
        obtener_postre(id);
    });

    $('#tbl_postres').on('click', '.btn-delete', function () {
        const id = $(this).data('id');
        // Lógica para eliminar el usuario con el ID obtenido
        console.log('Eliminar usuario con ID:', id);
        Swal.fire({
            title: "Esta segur@?",
            title: "Estas seguro?",
            text: "No se podra revertir este cambio!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            cancelButtonText: "No, cancelar",
            confirmButtonText: "Si, confirmar",
        }).then((result) => {
            if (result.isConfirmed) {
                eliminar_postre(id);
            } else if (result.isDenied) {
                console.log('Cancelado');
            }

        });
    });
});

function listar_platillos() {
    /*if($.fn.DataTable.isDataTable("#tbl_usuarios")){
        $("#tbl_usuarios").DataTable().clear();
        $("#tbl_usuarios").DataTable().destroy();
    }*/
    $("#tbl_postres").DataTable({
        language: {
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
        order: [
            [1, 'asc'] //orden alfabetico
        ],
        ajax: {
            url: 'app/models/menus/postres/listar.php',
            type: 'POST',
            dataType: 'Json',
            complete: function (response) {
                console.log(response.responseJSON);
            }
        },
        columns: [
            {
                data: 'numero'
            },
            {
                data: 'postre'
            },
            {
                data: 'descripcion'
            },
            {
                data: 'precio'
            },
            {
                data: 'estado'
            },
            {
                data: 'idpostre',
                orderable: false,
                searchable: false,
                render: function (data, type, row) {
                    return `
                        <button class="btn btn-primary btn-edit p-2 rounded-1 mx-3" data-id="${data}">Editar</button>
                        <button class="btn btn-danger btn-delete p-2 rounded-1" data-id="${data}">Eliminar</button>
                    `;
                }
            }
        ]
    });
}

function guardar_data() {
    let form = $("#frm_registro_postre").formJson();
    console.log(form);
    $.ajax({
        url: 'app/models/menus/postres/guardar_postre.php', //hacia donde irá la solicitud (ruta)
        type: 'POST', //el metodo http a utilizar
        dataType: 'json', //tipo de datos que se espera recibir del servidor
        data: {
            form: form
        }
    }) // datos enviados al servidor
        .done(function (response) {
            if (response.success) {
                console.log(response);
                listar_platillos();
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
        })//si la respuesta es exitosa (comunicacion)
        .fail(function (jqXHR, textStatus, errorThrown) {
            console.log("Error al realizar la solicitud: " + textStatus, errorThrown);
            console.log(jqXHR);
        })
}

function update_data() {
    let form = $("#frm_update_postre").formJson();
    console.log(form);
    $.ajax({
        url: 'app/models/menus/postres/actualizar_postre.php', //hacia donde irá la solicitud (ruta)
        type: 'POST', //el metodo http a utilizar
        dataType: 'json', //tipo de datos que se espera recibir del servidor
        data: {
            form: form
        }
    }) // datos enviados al servidor
        .done(function (response) {
            console.log(response);
            if (response.success) {
                listar_platillos();
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
        })//si la respuesta es exitosa (comunicacion)
        .fail(function (jqXHR, textStatus, errorThrown) {
            console.log("Error al realizar la solicitud: " + textStatus, errorThrown);
        })
}

function obtener_postre(id) {
    $.ajax({
        url: 'app/models/menus/postres/obtener.php', //hacia donde irá la solicitud (ruta)
        type: 'POST', //el metodo http a utilizar
        dataType: 'json', //tipo de datos que se espera recibir del servidor
        data: {
            idpostre: id
        }
    }) // datos enviados al servidor
        .done(function (response) {
            if (response.success) {
                const postre = response.resultado[0];
               $('#idpostre').val(postre.idpostre);
                $('#postreUpdate').val(postre.postre);
                $('#descripcionUpdate').val(postre.descripcion);
                $('#precioUpdate').val(postre.precio);

                $('#postreModal').modal('show');
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
        })//si la respuesta es exitosa (comunicacion)
        .fail(function (jqXHR, textStatus, errorThrown) {
            console.log("Error al realizar la solicitud: " + textStatus, errorThrown);
            console.log(jqXHR);
        })
}

function eliminar_postre(id) {
    $.ajax({
        url: 'app/models/menus/postres/eliminar_postres.php', //hacia donde irá la solicitud (ruta)
        type: 'POST', //el metodo http a utilizar
        dataType: 'json', //tipo de datos que se espera recibir del servidor
        data: {
            idpostre: id
        }
    }) // datos enviados al servidor
        .done(function (response) {
            if (response.success) {
                listar_platillos();

                Swal.fire({
                    title: "Borrado!",
                    text: response.message,
                    icon: "success"
                });
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
        })//si la respuesta es exitosa (comunicacion)
        .fail(function (jqXHR, textStatus, errorThrown) {
            console.log("Error al realizar la solicitud: " + textStatus, errorThrown);
        })
}