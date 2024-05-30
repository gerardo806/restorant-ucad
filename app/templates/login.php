<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Log in</title>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="resources/plugins/fontawesome-free/css/all.min.css">

    <link rel="apple-touch-icon" sizes="180x180" href="resources/dist/img/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="resources/dist/img/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="resources/dist/img/favicons/favicon-16x16.png">
    <link rel="shortcut icon" type="image/x-icon" href="resources/dist/img/favicons/favicon.ico">
    <link rel="manifest" href="resources/dist/img/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="resources/dist/img/favicons/mstile-150x150.png">
    <meta name="theme-color" content="#ffffff">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200;300;400;500;600;700&amp;display=swap"
        rel="stylesheet">
    <link href="resources/vendors/prism/prism.css" rel="stylesheet">
    <link href="resources/vendors/swiper/swiper-bundle.min.css" rel="stylesheet">
    <link href="resources/dist/css/theme.css" rel="stylesheet" />

    <!-- jQuery -->
    <script src="resources/plugins/jquery/jquery.min.js"></script>
    <script src="resources/dist/js/md5.js"></script>

    <link rel="stylesheet" href="resources/dist/css/styles.css">
</head>

<body class="hold-transition login-page">
    <main class="main" id="top">
        <nav class="navbar navbar-expand-lg fixed-top navbar-dark" data-navbar-on-scroll="data-navbar-on-scroll">
            <div class="container"><a class="navbar-brand" href="index.html">
                    Joya's Restaurant
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation"><i
                        class="fa-solid fa-bars text-white fs-3"></i></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mt-2 mt-lg-0">
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="#inicio">Inicio</a>
                        </li>
                        <li class="nav-item"><a class="nav-link" aria-current="page" href="#vacantes">Empleos</a></li>
                        <li class="nav-item"><a class="nav-link" aria-current="page" href="#menus">Menús</a></li>
                        <li class="nav-item mt-2 mt-lg-0"><a
                                class="nav-link btn btn-light text-black w-md-25 w-50 w-lg-100" data-bs-toggle="modal"
                                data-bs-target="#staticBackdrop" href="#">Iniciar Sesión</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <?php
        @include(MODULO_PATH . "/" . $conf[$modulo]['archivo']);
      ?>
    </main>

    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
        aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-dark">
                    <h5 class="modal-title text-white" id="staticBackdropLabel">Completar formulario</h5>
                    <button type="button" class="btn-close bg-light" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form autocomplete="off" id="formLogin" name="formLogin">
                        <div class="text-center">
                            <img src="resources/dist/img/logo-joya-restaurant.png" class="img-logo-login" alt="logo">
                            <h3>Joya's Restaurant</h3>
                        </div>
                        <div class="mb-3 msgHelp">
                            <label class="form-label w-100">
                                <span class="h5">Usuario</span>
                                <input type="text" class="form-control p-2 mt-2" id="username" name="username">
                            </label>
                        </div>
                        <div class="mb-3 msgHelp">
                            <label class="form-label w-100">
                                <span class="h5">Contraseña</span>
                                <input type="password" name="passUser" id="passUser" class="form-control p-2 mt-2">
                            </label>
                        </div>
                        <input type="submit" id="signIn" class="btn btn-info w-100 p-2 text-white" value="Iniciar Sesión">
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger p-2 text-white">Crear cuenta</button>
                    <button type="button" class="btn btn-secondary p-2" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <script src="resources/vendors/popper/popper.min.js"></script>
    <script src="resources/vendors/bootstrap/bootstrap.min.js"></script>
    <script src="resources/vendors/anchorjs/anchor.min.js"></script>
    <script src="resources/vendors/is/is.min.js"></script>
    <script src="resources/vendors/fontawesome/all.min.js"></script>
    <script src="resources/vendors/lodash/lodash.min.js"></script>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
    <script src="resources/vendors/prism/prism.js"></script>
    <script src="resources/vendors/swiper/swiper-bundle.min.js"></script>
    <script src="resources/dist/js/theme.js"></script>

     <!--jquery validate-->
  <script type="text/javascript" src="resources/plugins/jquery-validation/jquery.validate.js"></script>
  <script type="text/javascript" src="resources/plugins/jquery-validation/additional-methods.js"></script>
  <script type="text/javascript" src="resources/plugins/jquery-validation/localization/messages_es.js"></script>
    <!--sweetalert-->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</body>

</html>