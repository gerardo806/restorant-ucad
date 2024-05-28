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
</head>

<body class="hold-transition login-page">
    <main class="main" id="top">
        <nav class="navbar navbar-expand-lg fixed-top navbar-dark" data-navbar-on-scroll="data-navbar-on-scroll">
            <div class="container"><a class="navbar-brand" href="index.html">Joya's Restaurant</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation"><i
                        class="fa-solid fa-bars text-white fs-3"></i></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mt-2 mt-lg-0">
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="index.html">Inicio</a>
                        </li>
                        <li class="nav-item"><a class="nav-link" aria-current="page" href="about.html">Acerca de</a></li>
                        <li class="nav-item"><a class="nav-link" aria-current="page" href="blogs.html">Blogs</a></li>
                        <li class="nav-item mt-2 mt-lg-0"><a
                                class="nav-link btn btn-light text-black w-md-25 w-50 w-lg-100" aria-current="page"
                                href="#">Log In</a></li>
                    </ul>
                </div>
            </div>
        </nav>

            <?php
        @include(MODULO_PATH . "/" . $conf[$modulo]['archivo']);
      ?>
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
        <!--sweetalert-->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</body>

</html>