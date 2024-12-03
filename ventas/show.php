<?php
$id_venta_get = $_GET['id_venta'];

include('../app/config.php');
include('../layout/sesion.php');

include('../layout/parte1.php');

include('../app/controllers/ventas/cargar_venta.php');
include('../app/controllers/clientes/cargar_cliente.php');
?>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-12">
                    <h1 class="m-0">Detalle de la Venta Nro <?= $nro_venta; ?></h1>
                </div><!-- /.col -->
            </div><!-- /.row -->
        </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->


    <!-- Main content -->
    <div class="content">
        <div class="container-fluid">
            <div class="col-md-12">
                <div class="card card-outline card-primary">
                    <div class="card-header">

                        <h3 class="card-title"><i class="fa fa-shopping-bag"></i> Venta Nro
                            <input type="text" style="text-align : center" value="<?php echo $nro_venta; ?>" disabled>
                        </h3>
                        <div class="card-tools">
                            <!--<button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i>-->
                            </button>
                        </div>

                    </div>

                    <div class="card-body">
                        <div class="table responsive">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th style="background-color: #e7e7e7; text-align:center;">N°</th>
                                        <th style="background-color: #e7e7e7; text-align:center;">Producto</th>
                                        <th style="background-color: #e7e7e7; text-align:center;">Detalle</th>
                                        <th style="background-color: #e7e7e7; text-align:center;">Cantidad</th>
                                        <th style="background-color: #e7e7e7; text-align:center;">Precio U.</th>
                                        <th style="background-color: #e7e7e7; text-align:center;">Precio Sub.</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                    $contador_de_carrito = 0;
                                    $cantidad_total = 0;
                                    $precio_unitario_total =  0;
                                    $precio_total = 0;

                                    $sql_carrito = "SELECT *,pro.nombre AS nombre_producto,pro.descripcion 
                                                    AS descripcion,pro.precio_venta AS precio_venta, pro.stock AS stock, pro.id_producto AS id_producto 
                                                    FROM tb_carrito AS car  INNER JOIN tb_almacen AS pro ON car.id_producto = pro.id_producto WHERE nro_venta = '$nro_venta' ORDER BY id_carrito ASC";
                                    $query_carrito = $pdo->prepare($sql_carrito);
                                    $query_carrito->execute();
                                    $carrito_datos = $query_carrito->fetchAll(PDO::FETCH_ASSOC);

                                    foreach ($carrito_datos as $carrito_dato) {
                                        $id_carrito = $carrito_dato['id_carrito'];
                                        $contador_de_carrito = $contador_de_carrito + 1;
                                        $cantidad_total = $cantidad_total + $carrito_dato['cantidad'];
                                        $precio_unitario_total = $precio_unitario_total + floatval($carrito_dato['precio_venta']) ?>

                                        <tr>
                                            <td>
                                                <center><?php echo $contador_de_carrito ?></center>
                                                <input type="text" value="<?php echo $carrito_dato['id_producto']; ?>" id="id_producto<?php echo $contador_de_carrito ?>" hidden>
                                            </td>
                                            <td>
                                                <center> <?php echo $carrito_dato['nombre_producto']; ?></center>
                                            </td>
                                            <td>
                                                <center> <?php echo $carrito_dato['descripcion']; ?></center>
                                            </td>
                                            <td>
                                                <center><span id="cantidad_carrito<?php echo $contador_de_carrito ?>"> <?php echo $carrito_dato['cantidad']; ?></span></center>
                                                <input type="text" value="<?php echo $carrito_dato['stock']; ?>" id="stock_de_inventario<?php echo $contador_de_carrito ?>" hidden>
                                            </td>
                                            <td>
                                                <center> <?php echo $carrito_dato['precio_venta']; ?></center>
                                            </td>

                                            <td>
                                                <center>
                                                    <?php
                                                    $cantidad = floatval($carrito_dato['cantidad']);
                                                    $precio_venta = floatval($carrito_dato['precio_venta']);
                                                    echo $subtotal = $cantidad * $precio_venta;
                                                    $precio_total = $precio_total + $subtotal;
                                                    ?>
                                                </center>
                                            </td>

                                        </tr>
                                    <?php
                                    }
                                    ?>


                                    <!-- <td><center><a href="" class="btn btn-danger btn-sm"><i class="fa fa-trash"></i> Borrar</a></center></td> -->


                                    <tr>
                                        <th colspan="3" style="background-color: #e7e7e7;text-align: right">TOTAL</th>
                                        <th>
                                            <center>
                                                <?php
                                                echo $cantidad_total;
                                                ?>
                                            </center>
                                        </th>
                                        <th>
                                            <center>S/.
                                                <?php
                                                echo $precio_unitario_total;

                                                ?>
                                            </center>
                                        </th>
                                        <th style="background-color: #fff819;">
                                            <center>S/.
                                                <?php
                                                echo $precio_total;

                                                ?>
                                            </center>
                                        </th>

                                    </tr>
                                </tbody>
                            </table>
                        </div>



                    </div>

                </div>

            </div>
            <?php
            foreach ($clientes_datos as $clientes_dato) {
                $nombre_cliente = $clientes_dato['nombre_cliente'];
                $ruc_cliente = $clientes_dato['ruc_cliente'];
                $celular_cliente = $clientes_dato['celular_cliente'];
                $email_cliente = $clientes_dato['email_cliente'];
            }
            ?>

            <div class="row">
                <div class="col-md-9">
                    <div class="card card-outline card-primary">
                        <div class="card-header">
                            <h3 class="card-title"><i class="fa fa-user-check"></i> Datos del Cliente</h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>

                        </div>

                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <input type="text" id="id_cliente" hidden>
                                        <label for="">Nombre del Cliente</label>
                                        <input type="text" value="<?php echo $nombre_cliente ?>" class="form-control" id="nombre_cliente" disabled>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="">Nit/CI del Cliente</label>
                                        <input type="text" value="<?php echo $ruc_cliente ?>" class="form-control" id="ruc_cliente" disabled>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="">Celular del Cliente</label>
                                        <input type="text" value="<?php echo $celular_cliente ?>" class="form-control" id="celular_cliente" disabled>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="">Correo del Cliente</label>
                                        <input type="text" value="<?php echo $email_cliente ?>" class="form-control" id="email_cliente" disabled>
                                    </div>
                                </div>
                                <div class="col-md-6"></div>
                            </div>

                        </div>

                    </div>

                </div>



                <div class="col-md-3">
                    <div class="card card-outline card-primary">
                        <div class="card-header">
                            <h3 class="card-title"><i class="fa fa-shopping-basket"></i> Registrar Venta</h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>

                        </div>

                        <div class="card-body">
                            <div class="form-group">
                                <label for="">Monto a Cancelar</label>
                                <input type="text" class="form-control" id="total_a_cancelar" style="text-align:center;background-color:#fff819;font-weight:bold" value=" <?php echo $precio_total; ?>" disabled>

                            </div>
                            <div class="col-md-12">
                                            <div class="form-group">
                                            <a href="index.php" class="btn btn-secondary btn-block">Cancelar</a>
                                            </div>
                                    </div>

                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <?php include('../layout/mensajes.php'); ?>
    <?php include('../layout/parte2.php'); ?>



    <script>
        $(function() {
            $("#example1").DataTable({
                "pageLength": 5,
                "language": {
                    "emptyTable": "No hay información",
                    "info": "Mostrando _START_ a _END_ de _TOTAL_ Productos",
                    "infoEmpty": "Mostrando 0 a 0 de 0 Productos",
                    "infoFiltered": "(Filtrado de _MAX_ total Productos)",
                    "infoPostFix": "",
                    "thousands": ",",
                    "lengthMenu": "Mostrar _MENU_ Productos",
                    "loadingRecords": "Cargando...",
                    "processing": "Procesando...",
                    "search": "Buscador:",
                    "zeroRecords": "Sin resultados encontrados",
                    "paginate": {
                        "first": "Primero",
                        "last": "Ultimo",
                        "next": "Siguiente",
                        "previous": "Anterior"
                    }
                },
                "responsive": true,
                "lengthChange": true,
                "autoWidth": false,

            }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
        });


        $(function() {
            $("#example2").DataTable({
                "pageLength": 5,
                "language": {
                    "emptyTable": "No hay información",
                    "info": "Mostrando _START_ a _END_ de _TOTAL_ Clientes",
                    "infoEmpty": "Mostrando 0 a 0 de 0 Clientes",
                    "infoFiltered": "(Filtrado de _MAX_ total Clientes)",
                    "infoPostFix": "",
                    "thousands": ",",
                    "lengthMenu": "Mostrar _MENU_ Clientes",
                    "loadingRecords": "Cargando...",
                    "processing": "Procesando...",
                    "search": "Buscador:",
                    "zeroRecords": "Sin resultados Clientes",
                    "paginate": {
                        "first": "Primero",
                        "last": "Ultimo",
                        "next": "Siguiente",
                        "previous": "Anterior"
                    }
                },
                "responsive": true,
                "lengthChange": true,
                "autoWidth": false,

            }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
        });
    </script>

    <!-- modal para visualizar formulario para agregar clientes -->
    <div class="modal fade" id="modal-agregar_cliente">
        <div class="modal-dialog modal-dialog-centered ">
            <div class="modal-content">
                <div class="modal-header" style="background-color: #26caba;color: white">
                    <h4 class="modal-title">Nuevo Cliente </h4>
                    <div style="width:10px;"></div>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="../app/controllers/clientes/guardar_clientes.php" method="post">
                        <div class="form-group"><label for="">Nombre del cliente</label><input type="text" name="nombre_cliente" class="form-control"></div>
                        <div class="form-group"><label for="">Nit/CI del cliente</label><input type="text" name="ruc_cliente" class="form-control"></div>
                        <div class="form-group"><label for="">Celular del cliente</label><input type="text" name="celular_cliente" class="form-control"></div>
                        <div class="form-group"><label for="">Correo del cliente</label><input type="email" name="email_cliente" class="form-control"></div>
                        <hr>
                        <div class="form-group"><button type="submit" class="btn btn-primary btn-block">Guardar Cliente</button></div>
                    </form>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->