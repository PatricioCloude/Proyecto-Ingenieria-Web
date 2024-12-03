<?php

    include ('../../config.php');


    $nombre_cliente     = $_POST['nombre_cliente'];
    $ruc_cliente     = $_POST['ruc_cliente'];
    $celular_cliente    = $_POST['celular_cliente'];
    $email_cliente      = $_POST['email_cliente'];

    $sentencia = $pdo->prepare("CALL guardar_clientes(:nombre_cliente, :ruc_cliente, :celular_cliente, :email_cliente, :fyh_creacion)");

    $sentencia->bindParam(':nombre_cliente' ,$nombre_cliente);
    $sentencia->bindParam(':ruc_cliente' ,$ruc_cliente);
    $sentencia->bindParam(':celular_cliente',$celular_cliente);
    $sentencia->bindParam(':email_cliente'  ,$email_cliente);
    $sentencia->bindParam(':fyh_creacion'   ,$fechaHora);

    if($sentencia->execute()){
        ?>
            <script>
                location.href = "<?php echo $URL;?>/ventas/create.php";
            </script>
        <?php
    }else{

        session_start();
        $_SESSION['mensaje']    = "Error no se pudo registrar en la base de datos";
        $_SESSION['icono']      = "error";
        //  header('Location: '.$URL.'/categorias');
        ?>
            <script>
                location.href = "<?php echo $URL;?>/ventas/create.php";
            </script>
        <?php
    }

?>






