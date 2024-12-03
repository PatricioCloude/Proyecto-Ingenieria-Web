<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>SISTEMA - OVALTECH</title>

    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="<?php echo $URL; ?>/public/templeates/AdminLTE-3.2.0/plugins/fontawesome-free/css/all.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="<?php echo $URL; ?>/public/templeates/AdminLTE-3.2.0/dist/css/adminlte.min.css">

    <!-- Libreria Sweetallert2-->
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- DataTables -->
    <link rel="stylesheet" href="<?php echo $URL; ?>/public/templeates/AdminLTE-3.2.0/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="<?php echo $URL; ?>/public/templeates/AdminLTE-3.2.0/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="<?php echo $URL; ?>/public/templeates/AdminLTE-3.2.0/plugins/datatables-buttons/css/buttons.bootstrap4.min.css">

    <!-- jQuery -->
    <script src="<?php echo $URL; ?>/public/templeates/AdminLTE-3.2.0/plugins/jquery/jquery.min.js"></script>
    <link rel="shortcut icon" href="<?php echo $URL; ?>/public/images/t_logo.jpg">
</head>

<body class="hold-transition sidebar-mini">

    <div class="wrapper">

        <!-- Navbar -->
        <nav class="main-header navbar navbar-expand navbar-white navbar-light">
            <!-- Left navbar links -->
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
                </li>
                <li class="nav-item d-none d-sm-inline-block">
                    <a href="<?php echo $URL; ?>" class="nav-link"><b>SISTEMA DE ALMACÉN </b></a>
                    
                </li>
            </ul>

            <!-- Right navbar links -->
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <!--<a class="nav-link" data-widget="fullscreen" href="#" role="button">
                    <i class="fas fa-expand-arrows-alt"></i>-->
                    </a>
                </li>
            </ul>
        </nav>
        <!-- /.navbar -->

        <!-- Main Sidebar Container -->
        <aside class="main-sidebar sidebar-dark-primary elevation-4">
            <!-- Brand Logo -->
            <a href="<?php echo $URL; ?>" class="brand-link">
                <img src="<?php echo $URL; ?>/public/images/t_logo.jpg" alt="AdminLTE Logo" class="brand-image img-circule ">
                <span class="brand-text " style="color: white;"><b>OVALTECH E.I.R.L.</b></span>
            </a>

            <!-- Sidebar -->
            <div class="sidebar">
                <!-- Sidebar user panel (optional) -->
                <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                    <div class="image">
                        <img src="<?php echo $URL; ?>/public/templeates/AdminLTE-3.2.0/dist/img/user2-160x160.png" class="img-circle elevation-2" alt="User Image">
                    </div>
                    <div class="info">

                        <a href="#" aria-disabled="true" class="disabled-link" style="color: white;"><?php echo $nombres_sesion; ?></a>
                        <style>
                            .disabled-link[aria-disabled="true"] {
                                pointer-events: none;
                                cursor: default;
                                color: gray;
                            }
                        </style>
                    </div>
                </div>


                <!-- Sidebar Menu -->
                <nav class="mt-2">
                    <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                        <!-- Add icons to the links using the .nav-icon class
                         with font-awesome or any other icon font library -->



                        <?php if ($rol_sesion == 'ADMINISTRADOR'): ?>
                        <li class="nav-item ">
                            <a href="#" class="nav-link active">
                                <i class="nav-icon fas fa-users"></i>
                                <p>
                                    Usuarios
                                    <i class="right fas fa-angle-left"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="<?php echo $URL; ?>/usuarios" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Listado de usuarios</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="<?php echo $URL; ?>/usuarios/create.php" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Creación de usuario</p>
                                    </a>
                                </li>
                            </ul>
                        </li>

                        <li class="nav-item ">
                            <a href="#" class="nav-link active">
                                <i class="nav-icon fas fa-address-card"></i>
                                <p>
                                    Roles
                                    <i class="right fas fa-angle-left"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="<?php echo $URL; ?>/roles" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Listado de roles</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="<?php echo $URL; ?>/roles/create.php" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Creación de rol</p>
                                    </a>
                                </li>
                            </ul>
                        </li>

                        <?php endif; ?>


                        <?php if ($rol_sesion == 'ALMACENERO'|| $rol_sesion == 'ADMINISTRADOR'): ?>
                        <li class="nav-item ">
                            <a href="#" class="nav-link active">
                                <i class="nav-icon fas fa-tags"></i>
                                <p>
                                    Categorías
                                    <i class="right fas fa-angle-left"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="<?php echo $URL; ?>/categorias" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Listado de categorías</p>
                                    </a>
                                </li>
                            </ul>
                        </li>

                        <li class="nav-item ">
                            <a href="#" class="nav-link active">
                                <i class="nav-icon fas fa-list"></i>
                                <p>
                                    Almacen
                                    <i class="right fas fa-angle-left"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="<?php echo $URL; ?>/almacen" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Listado de productos</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="<?php echo $URL; ?>/almacen/create.php" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Creación de productos</p>
                                    </a>
                                </li>
                                <li class="nav-item" hidden="true">
                                    <a href="<?php echo $URL; ?>/almacen/kardex.php" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Kardex</p>
                                    </a>
                                </li>
                            </ul>
                        </li>




                        <li class="nav-item ">
                            <a href="#" class="nav-link active">
                                <i class="nav-icon fas fa-cart-plus"></i>
                                <p>
                                    Compras
                                    <i class="right fas fa-angle-left"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="<?php echo $URL; ?>/compras" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Listado de compras</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="<?php echo $URL; ?>/compras/create.php" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Creación de compra</p>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item ">
                            <a href="#" class="nav-link active">
                                <i class="nav-icon fas fa-car"></i>
                                <p>
                                    Proveedores
                                    <i class="right fas fa-angle-left"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="<?php echo $URL; ?>/proveedores" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Listado de proveedores</p>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <?php endif; ?>
                        <?php if ($rol_sesion == 'VENDEDOR'|| $rol_sesion == 'ADMINISTRADOR'): ?>
                        <li class="nav-item ">
                            <a href="#" class="nav-link active">
                                <i class="nav-icon fas fa-shopping-basket"></i>
                                <p>
                                    Ventas
                                    <i class="right fas fa-angle-left"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="<?php echo $URL; ?>/ventas" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Listado de Ventas</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="<?php echo $URL; ?>/ventas/create.php" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Creación de Ventas</p>
                                    </a>
                                </li>
                            </ul>
                        </li>

                        <li class="nav-item ">
                            <a href="#" class="nav-link active">
                                <i class="nav-icon fa fa-user-friends"></i>
                                <p>
                                    Clientes
                                    <i class="right fas fa-angle-left"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="<?php echo $URL; ?>/clientes" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Listado de Clientes</p>
                                    </a>
                                </li>

                            </ul>
                        </li>
                        <?php endif; ?>

                        

                        <li class="nav-item">
                            <a href="<?php echo $URL; ?>/app/controllers/login/cerrar_sesion.php" class="nav-link" style="background-color: #ca0a0b">
                                <i class="nav-icon fas fa-door-closed"></i>
                                <p>
                                    Cerrar Sesión
                                </p>
                            </a>
                        </li>
                    </ul>
                </nav>
                <!-- /.sidebar-menu -->
            </div>
            <!-- /.sidebar -->
        </aside>