<?php
if (!isset($_SESSION['restoran'])) {
  header('Cache-control: no-cache; must-revalidate');
  header('location: login');
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Restoran</title>

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
    <link href="resources/plugins/select2-bootstrap5-theme/select2-bootstrap-5-theme.min.css" rel="stylesheet" />

    <!-- jQuery -->
    <script src="resources/plugins/jquery/jquery.min.js"></script>
    <script src="resources/dist/js/md5.js"></script>

    <link rel="stylesheet" href="resources/dist/css/styles.css">

</head>

<body class="hold-transition sidebar-mini layout-fixed">
    <main class="main" id="top">
        <nav class="navbar navbar-expand-lg fixed-top navbar-dark bg-dark"
            data-navbar-on-scroll="data-navbar-on-scroll">
            <div class="container"><a class="navbar-brand" href="index.html">
                    Joya's Restaurant
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation"><i
                        class="fa-solid fa-bars text-white fs-3"></i></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mt-2 mt-lg-0">
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="home">Inicio</a>
                        </li>
                        <li class="nav-item">
                        <li class="nav-item mt-2 mt-lg-0">
                            <div class="dropdown">
                                <button class="btn bg-transparent text-white dropdown-toggle p-2 rounded-1" type="button"
                                    id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                    Configuraciones
                                </button>
                                <ul class="dropdown-menu rounded-1 p-0" aria-labelledby="dropdownMenuButton1">
                                    <li><a class="dropdown-item" href="#">Roles</a></li>
                                    <li><a class="dropdown-item border-bottom" href="users">Usuarios</a></li>
                                </ul>
                            </div>
                        </li>
                        </li>
                        <li class="nav-item mt-2 mt-lg-0">
                            <div class="dropdown">
                                <button class="btn bg-transparent text-white dropdown-toggle p-2 rounded-1" type="button"
                                    id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                    Menús
                                </button>
                                <ul class="dropdown-menu rounded-1 p-0" aria-labelledby="dropdownMenuButton1">
                                    <li><a class="dropdown-item" href="platillos">Platillos</a></li>
<<<<<<< HEAD
                                    <li><a class="dropdown-item border-bottom" href="bebidas">Bebidas</a></li>
=======
                                    <li><a class="dropdown-item border-bottom" href="#">Bebidas</a></li>
>>>>>>> 84a94823acacae0ef695b867f5a927511f5ff0e7
                                </ul>
                            </div>
                        </li>
                        <li class="nav-item mt-2 mt-lg-0">
                            <div class="dropdown">
                                <button class="btn btn-secondary dropdown-toggle p-2 rounded-1" type="button"
                                    id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                    <?=$_SESSION['restoran_usuario']?>
                                </button>
                                <ul class="dropdown-menu rounded-1 p-0" aria-labelledby="dropdownMenuButton1">
                                    <li><a class="dropdown-item" href="#">Action</a></li>
                                    <li><a class="dropdown-item border-bottom" href="#">Another action</a></li>
                                    <li><a class="dropdown-item" id="logout" href="#">Cerrar sesión</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div>
            <section>
                <div class="container">
                    <div class="row align-items-center py-lg-8 py-6">
                        <?php @include(MODULO_PATH . "/" . $conf[$modulo]['archivo']);?>
                    </div>
                </div>
            </section>
        </div>

        <section class="pt-0">
  <div class="container">
    <div class="row justify-content-between align-items-center">
      <div class="col-lg-5 col-sm-12">
        <a href="index.html"><img class="img-fluid mt-5 mb-4" src="resources/dist/img/pie_restaurante.png" alt="" /></a>
      </div>
      <div class="col-lg-2 col-sm-4">
        <h3 class="fw-bold fs-1 mt-5 mb-4">Misión</h3>
        <ul class="list-unstyled">
          <li class="my-3 col-md-4" style="width: 100%; max-width: 500px; margin: 0 auto; text-align: left;">Ofrecer una experiencia gastronómica única.</li>
        </ul>
      </div>
      <div class="col-lg-2 col-sm-4">
        <h3 class="fw-bold fs-1 mt-5 mb-4">Visión</h3>
        <ul class="list-unstyled">
          <li class="my-3" style="width: 100%; max-width: 500px; margin: 0 auto; text-align: left;">Ser el restaurante de referencia en la ciudad.</li>
        </ul>
      </div>
      <div class="col-lg-2 col-sm-4 text-center">
        <h3 class="fw-bold fs-1 mt-5 mb-4">Valores</h3>
        <ul class="list-unstyled">
          <li class="my-2">Integridad</li>
          <li class="my-2">Servicio</li>
        </ul>
      </div>
    </div>
    <p class="text-center text-gray mt-5">Universidad Cristiana de las Asambleas de Dios</p>
  </div>
  <!-- end of .container-->
</section>

    </main>

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
    <!-- DataTable -->
    <link rel="stylesheet" type="text/css" href="resources/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" type="text/css"
        href="resources/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <script type="text/javascript" src="resources/plugins/datatables/jquery.dataTables.js"></script>
    <script type="text/javascript" src="resources/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
    <script type="text/javascript" src="resources/plugins/datatables-responsive/js/dataTables.responsive.min.js">
    </script>
    <script type="text/javascript" src="resources/plugins/datatables-responsive/js/responsive.bootstrap4.min.js">
    </script>

    <!-- Select2 -->
    <link rel="stylesheet" href="resources/plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="resources/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    <script type="text/javascript" src="resources/plugins/select2/js/select2.full.min.js"></script>
    <script type="text/javascript" src="resources/plugins/select2/js/i18n/es.js"></script>

    <script type="module" src="resources/dist/js/general.js"></script>
</body>

</html>