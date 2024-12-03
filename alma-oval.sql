-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-07-2024 a las 17:31:51
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `alma-oval`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_stock` (IN `id_producto` INT, IN `nuevo_stock` INT)   BEGIN
    UPDATE tb_almacen SET stock = nuevo_stock WHERE id_producto = id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `borrar_carrito` (IN `id_carrito` INT)   BEGIN
    DELETE FROM tb_carrito WHERE id_carrito = id_carrito;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `borrar_venta` (IN `id_venta` INT)   BEGIN
    DELETE FROM tb_ventas WHERE id_venta = id_venta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `borrar_venta_if` (IN `nro_venta` INT)   BEGIN
    DELETE FROM tb_carrito WHERE nro_venta = nro_venta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_cliente` (IN `id_cliente` INT)   BEGIN
    SELECT * FROM tb_clientes WHERE id_cliente = id_cliente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_compra` (IN `p_id_compra` INT)   BEGIN
    SELECT 
        co.*, 
        pro.precio_compra AS precio_compra, 
        pro.codigo AS codigo, 
        pro.nombre AS nombre_producto, 
        pro.descripcion AS descripcion, 
        pro.stock AS stock, 
        pro.stock_minimo AS stock_minimo, 
        pro.stock_maximo AS stock_maximo,
        pro.precio_compra AS precio_compra_producto,
        pro.precio_venta AS precio_venta_producto,
        pro.fecha_ingreso AS fecha_ingreso,
        pro.imagen AS imagen,
        cat.nombre_categoria AS nombre_categoria,
        us.nombres AS nombre_usuarios_producto,
        prov.nombre_proveedor AS nombre_proveedor,
        prov.celular AS celular_proveedor,
        prov.telefono AS telefono_proveedor,
        prov.empresa AS empresa_proveedor,
        prov.email AS email_proveedor,
        prov.direccion AS direccion_proveedor,
        us.nombres AS nombres_usuario
    FROM tb_compras AS co
    INNER JOIN tb_almacen AS pro ON co.id_producto = pro.id_producto
    INNER JOIN tb_categorias AS cat ON cat.id_categoria = pro.id_categoria
    INNER JOIN tb_usuarios AS us ON co.id_usuario = us.id_usuario
    INNER JOIN tb_proveedores AS prov ON co.id_proveedor = prov.id_proveedor
    WHERE co.id_compra = p_id_compra;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_producto` (IN `p_id_producto` INT)   BEGIN
    SELECT *, cat.nombre_categoria AS categoria, u.email AS email, u.id_usuario AS id_usuario
    FROM tb_almacen AS a
    INNER JOIN tb_categorias AS cat ON a.id_categoria = cat.id_categoria
    INNER JOIN tb_usuarios AS u ON u.id_usuario = a.id_usuario
    WHERE a.id_producto = p_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_venta` (IN `id_venta_get` INT)   BEGIN
    SELECT ve.*, cli.nombre_cliente AS nombre_cliente
    FROM tb_ventas AS ve
    INNER JOIN tb_clientes AS cli ON cli.id_cliente = ve.id_cliente
    WHERE ve.id_venta = id_venta_get;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_almacen` (IN `p_codigo` VARCHAR(255), IN `p_nombre` VARCHAR(255), IN `p_descripcion` TEXT, IN `p_stock` INT, IN `p_stock_minimo` INT, IN `p_stock_maximo` INT, IN `p_precio_compra` DECIMAL(10,2), IN `p_precio_venta` DECIMAL(10,2), IN `p_fecha_ingreso` DATE, IN `p_imagen` VARCHAR(255), IN `p_id_usuario` INT, IN `p_id_categoria` INT, IN `p_fyh_creacion` DATETIME)   BEGIN
    INSERT INTO tb_almacen (
        codigo, nombre, descripcion, stock, stock_minimo, stock_maximo,
        precio_compra, precio_venta, fecha_ingreso, imagen, id_usuario, id_categoria, fyh_creacion
    )
    VALUES (
        p_codigo, p_nombre, p_descripcion, p_stock, p_stock_minimo, p_stock_maximo,
        p_precio_compra, p_precio_venta, p_fecha_ingreso, p_imagen, p_id_usuario, p_id_categoria, p_fyh_creacion
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_compras` (IN `p_id_producto` INT, IN `p_nro_compra` VARCHAR(255), IN `p_fecha_compra` DATE, IN `p_id_proveedor` INT, IN `p_comprobante` VARCHAR(255), IN `p_id_usuario` INT, IN `p_precio_compra` DECIMAL(10,2), IN `p_cantidad` INT, IN `p_fyh_creacion` DATETIME)   BEGIN
    INSERT INTO tb_compras (
        id_producto, nro_compra, fecha_compra, id_proveedor, comprobante, id_usuario,
        precio_compra, cantidad, fyh_creacion
    ) VALUES (
        p_id_producto, p_nro_compra, p_fecha_compra, p_id_proveedor, p_comprobante, p_id_usuario,
        p_precio_compra, p_cantidad, p_fyh_creacion
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_proveedores` (IN `p_nombre_proveedor` VARCHAR(255), IN `p_celular` VARCHAR(20), IN `p_telefono` VARCHAR(20), IN `p_empresa` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_direccion` VARCHAR(255), IN `p_fyh_creacion` DATETIME)   BEGIN
    INSERT INTO tb_proveedores (nombre_proveedor, celular, telefono, empresa, email, direccion, fyh_creacion) 
    VALUES (p_nombre_proveedor, p_celular, p_telefono, p_empresa, p_email, p_direccion, p_fyh_creacion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_rol` (IN `p_rol` VARCHAR(255), IN `p_fyh_creacion` DATETIME)   BEGIN
  INSERT INTO tb_roles(rol, fyh_creacion) 
  VALUES (p_rol, p_fyh_creacion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_usuarios` (IN `p_nombres` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_id_rol` INT, IN `p_password_user` VARCHAR(255), IN `p_fyh_creacion` DATETIME)   BEGIN
  INSERT INTO tb_usuarios (nombres, email, id_rol, password_user, fyh_creacion)
  VALUES (p_nombres, p_email, p_id_rol, p_password_user, p_fyh_creacion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_almacen` (IN `p_id_producto` INT)   BEGIN
    DELETE FROM tb_almacen WHERE id_producto = p_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_compras` (IN `id_compra_param` INT)   BEGIN
    DELETE FROM tb_compras WHERE id_compra = id_compra_param;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_usuario` (IN `p_id_usuario` INT)   BEGIN
  DELETE FROM tb_usuarios WHERE id_usuario = p_id_usuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_proveedor` (IN `p_id_proveedor` INT)   BEGIN
    DELETE FROM tb_proveedores WHERE id_proveedor = p_id_proveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `guardar_clientes` (IN `p_nombre_cliente` VARCHAR(255), IN `p_ruc_cliente` VARCHAR(20), IN `p_celular_cliente` VARCHAR(20), IN `p_email_cliente` VARCHAR(255), IN `p_fyh_creacion` DATETIME)   BEGIN
    INSERT INTO tb_clientes (nombre_cliente, ruc_cliente, celular_cliente, email_cliente, fyh_creacion)
    VALUES (p_nombre_cliente, p_ruc_cliente, p_celular_cliente, p_email_cliente, p_fyh_creacion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_de_categoria` ()   BEGIN
    SELECT * FROM tb_categorias;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_de_clientes` ()   BEGIN
    SELECT * FROM tb_clientes;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_de_compras` ()   BEGIN
    SELECT *,
           pro.codigo as codigo, pro.nombre as nombre_producto, pro.descripcion as descripcion, pro.stock as stock,
           pro.stock_minimo as stock_minimo, pro.stock_maximo as stock_maximo, pro.precio_compra as precio_compra_producto,
           pro.precio_venta as precio_venta_producto, pro.fecha_ingreso as fecha_ingreso, pro.imagen as imagen,
           cat.nombre_categoria as nombre_categoria, us.nombres as nombre_usuarios_producto,
           prov.nombre_proveedor as nombre_proveedor, prov.celular as celular_proveedor, prov.telefono as telefono_proveedor,
           prov.empresa as empresa, prov.email as email_proveedor, prov.direccion as direccion_proveedor, us.nombres as nombres_usuario
    FROM tb_compras as co
    INNER JOIN tb_almacen as pro ON co.id_producto = pro.id_producto
    INNER JOIN tb_categorias as cat ON cat.id_categoria = pro.id_categoria
    INNER JOIN tb_usuarios as us ON co.id_usuario = us.id_usuario
    INNER JOIN tb_proveedores as prov ON co.id_proveedor = prov.id_proveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_de_productos` ()   BEGIN
    SELECT *, cat.nombre_categoria AS categoria, u.email AS email
    FROM tb_almacen AS a
    INNER JOIN tb_categorias AS cat ON a.id_categoria = cat.id_categoria
    INNER JOIN tb_usuarios AS u ON u.id_usuario = a.id_usuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_de_proveedores` ()   BEGIN
    SELECT * FROM tb_proveedores;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_de_roles` ()   BEGIN
  SELECT * FROM tb_roles;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_de_usuarios` ()   BEGIN
  SELECT us.id_usuario AS id_usuario, us.nombres AS nombres, us.email AS email, rol.rol AS rol
  FROM tb_usuarios AS us
  INNER JOIN tb_roles AS rol ON us.id_rol = rol.id_rol;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listado_de_ventas` ()   BEGIN
    SELECT *, cli.nombre_cliente AS nombre_cliente
    FROM tb_ventas AS ve
    INNER JOIN tb_clientes AS cli ON cli.id_cliente = ve.id_cliente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar_carrito` (IN `p_nro_venta` INT, IN `p_id_producto` INT, IN `p_cantidad` INT, IN `p_fyh_creacion` DATETIME)   BEGIN
    INSERT INTO tb_carrito (nro_venta, id_producto, cantidad, fyh_creacion) 
    VALUES (p_nro_venta, p_id_producto, p_cantidad, p_fyh_creacion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registro_de_categorias` (IN `p_nombre_categoria` VARCHAR(255), IN `p_fyh_creacion` DATETIME)   BEGIN
    INSERT INTO tb_categorias (nombre_categoria, fyh_creacion)
    VALUES (p_nombre_categoria, p_fyh_creacion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registro_de_ventas` (IN `p_nro_venta` INT, IN `p_id_cliente` INT, IN `p_total_pagado` DECIMAL(10,2), IN `p_fyh_creacion` DATETIME)   BEGIN
    INSERT INTO tb_ventas (nro_venta, id_cliente, total_pagado, fyh_creacion) 
    VALUES (p_nro_venta, p_id_cliente, p_total_pagado, p_fyh_creacion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_usuarios` (IN `p_id_usuario` INT)   BEGIN
  SELECT us.id_usuario AS id_usuario, us.nombres AS nombres, us.email AS email, rol.rol AS rol
  FROM tb_usuarios AS us
  INNER JOIN tb_roles AS rol ON us.id_rol = rol.id_rol
  WHERE us.id_usuario = p_id_usuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sql_carrito` (IN `nro_venta_param` INT)   BEGIN
    SELECT *, pro.nombre AS nombre_producto, pro.descripcion 
    AS descripcion, pro.precio_venta 
    AS precio_venta, pro.stock 
    AS stock, pro.id_producto 
    AS id_producto
    FROM tb_carrito AS car
    INNER JOIN tb_almacen AS pro 
    ON car.id_producto = pro.id_producto
    WHERE nro_venta = nro_venta_param
    ORDER BY id_carrito ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_almacen` (IN `p_id_producto` INT, IN `p_nombre` VARCHAR(255), IN `p_descripcion` TEXT, IN `p_stock` INT, IN `p_stock_minimo` INT, IN `p_stock_maximo` INT, IN `p_precio_compra` DECIMAL(10,2), IN `p_precio_venta` DECIMAL(10,2), IN `p_fecha_ingreso` DATE, IN `p_imagen` VARCHAR(255), IN `p_id_usuario` INT, IN `p_id_categoria` INT, IN `p_fyh_actualizacion` TIMESTAMP)   BEGIN
    UPDATE tb_almacen
    SET nombre = p_nombre,
        descripcion = p_descripcion,
        stock = p_stock,
        stock_minimo = p_stock_minimo,
        stock_maximo = p_stock_maximo,
        precio_compra = p_precio_compra,
        precio_venta = p_precio_venta,
        fecha_ingreso = p_fecha_ingreso,
        imagen = p_imagen,
        id_usuario = p_id_usuario,
        id_categoria = p_id_categoria,
        fyh_actualizacion = p_fyh_actualizacion
    WHERE id_producto = p_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_compras` (IN `p_id_compra` INT, IN `p_id_producto` INT, IN `p_nro_compra` INT, IN `p_fecha_compra` DATE, IN `p_id_proveedor` INT, IN `p_comprobante` VARCHAR(255), IN `p_id_usuario` INT, IN `p_precio_compra` DECIMAL(10,2), IN `p_cantidad` INT, IN `p_fyh_actualizacion` DATETIME)   BEGIN
    UPDATE tb_compras 
    SET id_producto = p_id_producto,
        nro_compra = p_nro_compra,
        fecha_compra = p_fecha_compra,
        id_proveedor = p_id_proveedor,
        comprobante = p_comprobante,
        id_usuario = p_id_usuario,
        precio_compra = p_precio_compra,
        cantidad = p_cantidad,
        fyh_actualizacion = p_fyh_actualizacion 
    WHERE id_compra = p_id_compra;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_de_categorias` (IN `p_id_categoria` INT, IN `p_nombre_categoria` VARCHAR(255), IN `p_fyh_actualizacion` DATETIME)   BEGIN
    UPDATE tb_categorias
    SET nombre_categoria = p_nombre_categoria,
        fyh_actualizacion = p_fyh_actualizacion
    WHERE id_categoria = p_id_categoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_proveedor` (IN `p_id_proveedor` INT, IN `p_nombre_proveedor` VARCHAR(255), IN `p_celular` VARCHAR(15), IN `p_telefono` VARCHAR(15), IN `p_empresa` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_direccion` TEXT, IN `p_fyh_actualizacion` DATETIME)   BEGIN
    UPDATE tb_proveedores
    SET nombre_proveedor = p_nombre_proveedor,
        celular = p_celular,
        telefono = p_telefono,
        empresa = p_empresa,
        email = p_email,
        direccion = p_direccion,
        fyh_actualizacion = p_fyh_actualizacion
    WHERE id_proveedor = p_id_proveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_roles` (IN `p_id_rol` INT)   BEGIN
  SELECT * FROM tb_roles WHERE id_rol = p_id_rol;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_stock_almacen` (IN `p_stock` INT, IN `p_id_producto` INT)   BEGIN
    UPDATE tb_almacen SET stock = p_stock WHERE id_producto = p_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_stock_compras` (IN `p_id_producto` INT, IN `p_stock` INT)   BEGIN
    -- Actualiza el stock en la tabla tb_almacen
    UPDATE tb_almacen
    SET stock = p_stock
    WHERE id_producto = p_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_update_roles` (IN `p_id_rol` INT, IN `p_rol` VARCHAR(255), IN `p_fyh_actualizacion` DATETIME)   BEGIN
  UPDATE tb_roles
  SET rol = p_rol, fyh_actualizacion = p_fyh_actualizacion
  WHERE id_rol = p_id_rol;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_update_usuarios_else` (IN `p_nombres` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_id_rol` INT, IN `p_password_user` VARCHAR(255), IN `p_fyh_actualizacion` DATETIME, IN `p_id_usuario` INT)   BEGIN
    UPDATE tb_usuarios
    SET nombres = p_nombres,
        email = p_email,
        id_rol = p_id_rol,
        password_user = p_password_user,
        fyh_actualizacion = p_fyh_actualizacion
    WHERE id_usuario = p_id_usuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_update_usuarios_if` (IN `p_nombres` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_id_rol` INT, IN `p_fyh_actualizacion` DATETIME, IN `p_id_usuario` INT)   BEGIN
    UPDATE tb_usuarios
    SET nombres = p_nombres,
        email = p_email,
        id_rol = p_id_rol,
        fyh_actualizacion = p_fyh_actualizacion
    WHERE id_usuario = p_id_usuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_usuario` (IN `p_id_usuario` INT)   BEGIN
  SELECT us.id_usuario AS id_usuario, us.nombres AS nombres, us.email AS email, rol.rol AS rol
  FROM tb_usuarios AS us
  INNER JOIN tb_roles AS rol ON us.id_rol = rol.id_rol
  WHERE us.id_usuario = p_id_usuario;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_almacen`
--

CREATE TABLE `tb_almacen` (
  `id_producto` int(11) NOT NULL,
  `codigo` varchar(255) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `stock` int(11) NOT NULL,
  `stock_minimo` int(11) DEFAULT NULL,
  `stock_maximo` int(11) DEFAULT NULL,
  `precio_compra` varchar(255) NOT NULL,
  `precio_venta` varchar(255) NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `imagen` text DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `fyh_creacion` datetime NOT NULL,
  `fyh_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tb_almacen`
--

INSERT INTO `tb_almacen` (`id_producto`, `codigo`, `nombre`, `descripcion`, `stock`, `stock_minimo`, `stock_maximo`, `precio_compra`, `precio_venta`, `fecha_ingreso`, `imagen`, `id_usuario`, `id_categoria`, `fyh_creacion`, `fyh_actualizacion`) VALUES
(1, 'P-00001', 'Monitor Gamer ASUS ROG Swift PG329Q-W', 'Monitor para juegos ASUS ROG Swift PG329Q-W: QHD de 32 pulgadas (2560x1440), IPS rápido, 175 Hz*, 1 ms (GTG), Extreme Low Motion Blur, G-SYNC Compatible, DisplayHDR™ 600', 7, 5, 10, '6349.00', '6399.00', '2024-07-22', '2024-07-22-09-45-43__415051362_883458053784791_3144146187630143795_n.jpg', 1, 1, '2024-04-12 18:26:25', '2024-07-23 07:48:26'),
(2, 'P-00002', 'Teclado Mecánico Corsair K95 RGB', 'Teclado mecánico para juegos Corsair K95 RGB, interruptores Cherry MX Speed, retroiluminación RGB', 5, 5, 10, '100.00', '150.00', '2024-05-10', '2024-07-22-10-11-31__w=800,h=800,fit=pad.avif', 1, 2, '2024-05-10 12:15:30', '2024-07-22 22:11:31'),
(3, 'P-00003', 'Ratón Logitech G502 HERO', 'Ratón para juegos Logitech G502 HERO, sensor HERO 25K, RGB, 11 botones programables', 5, 5, 10, '60.00', '100.00', '2024-06-08', '2024-07-22-10-12-34__mouse-logitech-gaming-g502-hero-rgb-usb-910-005469.jpg', 1, 2, '2024-06-08 09:45:10', '2024-07-22 22:12:34'),
(4, 'P-00004', 'Auriculares SteelSeries Arctis 7', 'Auriculares inalámbricos para juegos SteelSeries Arctis 7, DTS Headphone:X v2.0, 24 horas de batería', 6, 5, 10, '120.00', '180.00', '2024-07-15', '2024-07-22-10-13-08__D_NQ_NP_821576-MPE72549507937_102023-O.webp', 1, 2, '2024-07-15 14:30:50', '2024-07-22 22:13:08'),
(5, 'P-00005', 'Tarjeta Gráfica NVIDIA GeForce RTX 3080', 'Tarjeta gráfica NVIDIA GeForce RTX 3080, 10GB GDDR6X, ray tracing, DLSS', 8, 5, 10, '700.00', '1000.00', '2024-07-20', '2024-07-22-10-13-35__1111.png', 1, 1, '2024-07-20 16:20:25', '2024-07-23 07:49:18'),
(6, 'P-00006', 'Laptop Dell XPS 13', 'Laptop Dell XPS 13: 13.4 pulgadas, Intel Core i7, 16GB RAM, 512GB SSD', 10, 5, 10, '900.00', '1200.00', '2024-02-01', '2024-07-22-10-14-02__710EGJBdIML._AC_SL1500_.jpg', 1, 6, '2024-08-01 10:00:00', '2024-07-23 07:50:06'),
(7, 'P-00007', 'SSD Samsung 970 EVO Plus 1TB', 'SSD Samsung 970 EVO Plus: 1TB, NVMe, M.2', 13, 5, 10, '150.00', '200.00', '2024-05-05', '2024-07-22-10-14-30__w=800,h=800,fit=pad (1).avif', 1, 7, '2024-08-05 11:30:00', '2024-07-23 07:50:28'),
(8, 'P-00008', 'Procesador AMD Ryzen 9 5900X', 'Procesador AMD Ryzen 9 5900X: 12 núcleos, 24 hilos, 3.7GHz (hasta 4.8GHz)', 5, 5, 10, '400.00', '550.00', '2024-04-10', '2024-07-23-07-51-28__w=800,h=800,fit=pad (5).avif', 1, 8, '2024-08-10 12:00:00', '2024-07-23 07:51:28'),
(9, 'P-00009', 'Placa Base ASUS ROG Strix B550-F', 'Placa base ASUS ROG Strix B550-F Gaming (Wi-Fi 6), AMD AM4, PCIe 4.0, 2.5Gb Ethernet', 10, 5, 10, '180.00', '250.00', '2024-06-15', '2024-07-22-10-15-16__pd.png', 1, 9, '2024-08-15 13:45:00', '2024-07-23 07:51:48'),
(10, 'P-00010', 'Fuente de Alimentación Corsair RM850x', 'Fuente de alimentación Corsair RM850x: 850W, 80 PLUS Gold, totalmente modular', 6, 5, 10, '120.00', '160.00', '2024-06-20', '2024-07-22-10-15-48__1427-005090_1.jpg', 1, 10, '2024-08-20 14:30:00', '2024-07-23 07:52:05'),
(11, 'P-00011', 'Case NZXT H510', 'Case NZXT H510: Mid-Tower ATX, panel frontal USB-C, gestión de cables mejorada', 8, 5, 10, '70.00', '100.00', '2024-06-25', '2024-07-22-10-16-26__image-3.webp', 1, 11, '2024-08-25 15:15:00', '2024-07-23 07:52:24'),
(12, 'P-00012', 'Monitor LG UltraGear 27GN950-B', 'Monitor para juegos LG UltraGear 27GN950-B: UHD 27 pulgadas (3840x2160), Nano IPS, 144Hz, 1ms, G-SYNC', 6, 5, 10, '600.00', '800.00', '2024-02-29', '2024-07-22-10-17-07__w=800,h=800,fit=pad (2).avif', 1, 12, '2024-08-30 16:00:00', '2024-07-23 07:52:40'),
(13, 'P-00013', 'Memoria RAM Corsair Vengeance LPX 16GB (2 x 8GB)', 'Memoria RAM Corsair Vengeance LPX 16GB (2 x 8GB): DDR4 3200MHz, C16', 9, 5, 10, '80.00', '110.00', '2024-03-05', '2024-07-22-10-17-34__CMK16GX4M2Z3200C16-1.jpg', 1, 13, '2024-09-05 17:00:00', '2024-07-23 07:54:22'),
(14, 'P-00014', 'Cámara Web Logitech C920', 'Cámara web Logitech C920: Full HD 1080p, micrófonos estéreo', 9, 5, 10, '50.00', '70.00', '2024-06-10', '2024-07-22-10-18-02__w=800,h=800,fit=pad (3).avif', 1, 2, '2024-09-10 18:00:00', '2024-07-22 22:39:58'),
(15, 'P-00015', 'Impresora HP LaserJet Pro M404dn', 'Impresora HP LaserJet Pro M404dn: impresión en blanco y negro, Ethernet, dúplex automático', 10, 5, 10, '150.00', '200.00', '2024-01-15', '2024-07-22-10-18-32__images.jfif', 1, 15, '2024-09-15 19:00:00', '2024-07-23 07:54:02'),
(16, 'P-00016', 'Tablet Apple iPad Pro 12.9', 'Tablet Apple iPad Pro 12.9: Wi-Fi, 128GB, Space Gray, 4ta generación', 8, 5, 10, '900.00', '1100.00', '2024-06-20', '2024-07-22-10-19-14__ipad_pro_wi-fi_12-9_in_6th_generation_space_gray_pdp_image_position-1b_coes.webp', 1, 16, '2024-09-20 20:00:00', '2024-07-23 07:53:49'),
(17, 'P-00017', 'Disco Duro Externo Seagate 2TB', 'Disco duro externo Seagate 2TB: USB 3.0, portátil', 9, 5, 10, '60.00', '90.00', '2024-02-25', '2024-07-22-10-20-29__image-b209260fecec4ce9a5770f74025ed1d2.webp', 1, 7, '2024-09-25 21:00:00', '2024-07-23 07:53:28'),
(18, 'P-00018', 'Router ASUS RT-AX88U', 'Router ASUS RT-AX88U: Wi-Fi 6, dual band, 8 puertos LAN, AiMesh', 10, 5, 10, '250.00', '300.00', '2024-05-30', '2024-07-22-10-20-58__D_NQ_NP_937290-MPE72439371186_102023-O.webp', 1, 18, '2024-09-30 22:00:00', '2024-07-23 07:53:15'),
(19, 'P-00019', 'Altavoces Bose SoundLink Revolve', 'Altavoces inalámbricos Bose SoundLink Revolve: Bluetooth, portátil, 360 grados', 6, 5, 10, '120.00', '150.00', '2024-07-05', '2024-07-22-10-22-54__cq5dam.web.320.320.png', 1, 20, '2024-10-05 23:00:00', '2024-07-23 07:52:57'),
(20, 'P-00020', 'Auriculares Sony WH-1000XM4', 'Auriculares inalámbricos Sony WH-1000XM4: cancelación de ruido, 30 horas de batería, micrófono', 5, 5, 10, '250.00', '350.00', '2024-05-10', '2024-07-22-10-23-26__209668-800-800.webp', 1, 19, '2024-10-10 23:00:10', '2024-07-22 22:38:40'),
(21, 'P-00021', 'Intel i9-13900K', 'Procesador de 13ª generación de Intel con 24 núcleos (8 P-cores y 16 E-cores) y 32 hilos, frecuencia base de 3.0 GHz y turbo de hasta 5.8 GHz. Compatible con socket LGA 1700 y soporta PCIe 5.0 y memoria DDR5.', 7, 5, 10, '1920.00', '1980.00', '2024-07-16', '2024-07-23-07-21-03__w=800,h=800,fit=pad (4).avif', 1, 8, '2024-07-23 07:21:03', '2024-07-23 09:23:25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_carrito`
--

CREATE TABLE `tb_carrito` (
  `id_carrito` int(11) NOT NULL,
  `nro_venta` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `fyh_creacion` datetime NOT NULL,
  `fyh_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_carrito`
--

INSERT INTO `tb_carrito` (`id_carrito`, `nro_venta`, `id_producto`, `cantidad`, `fyh_creacion`, `fyh_actualizacion`) VALUES
(2, 1, 1, 1, '2024-07-23 08:49:12', '0000-00-00 00:00:00'),
(3, 2, 2, 1, '2024-07-23 09:45:59', '0000-00-00 00:00:00'),
(4, 2, 3, 1, '2024-07-23 09:46:06', '0000-00-00 00:00:00'),
(5, 2, 20, 1, '2024-07-23 09:46:24', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_categorias`
--

CREATE TABLE `tb_categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre_categoria` varchar(255) NOT NULL,
  `fyh_creacion` datetime NOT NULL,
  `fyh_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tb_categorias`
--

INSERT INTO `tb_categorias` (`id_categoria`, `nombre_categoria`, `fyh_creacion`, `fyh_actualizacion`) VALUES
(1, 'Computadoras y accesorios', '2024-07-21 22:25:10', '2024-07-22 22:32:25'),
(2, 'Periféricos', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(3, 'Componentes de PC', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(4, 'Auriculares y Audio', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(5, 'Tarjetas Gráficas', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(6, 'Laptops', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(7, 'Almacenamiento', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(8, 'Procesadores', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(9, 'Placas Base', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(10, 'Fuentes de Alimentación', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(11, 'Cajas de PC', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(12, 'Monitores', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(13, 'Memoria RAM', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(14, 'Cámaras Web', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(15, 'Impresoras', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(16, 'Tablets', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(17, 'Discos Duros Externos', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(18, 'Routers', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(19, 'Auriculares Bluetooth', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(20, 'Altavoces', '2024-05-10 12:15:30', '2024-05-10 12:15:30'),
(21, 'Televisores', '2024-05-10 12:15:30', '2024-05-10 12:15:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_clientes`
--

CREATE TABLE `tb_clientes` (
  `id_cliente` int(11) NOT NULL,
  `nombre_cliente` varchar(255) NOT NULL,
  `ruc_cliente` varchar(255) NOT NULL,
  `celular_cliente` varchar(255) NOT NULL,
  `email_cliente` varchar(255) NOT NULL,
  `fyh_creacion` datetime NOT NULL,
  `fyh_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_clientes`
--

INSERT INTO `tb_clientes` (`id_cliente`, `nombre_cliente`, `ruc_cliente`, `celular_cliente`, `email_cliente`, `fyh_creacion`, `fyh_actualizacion`) VALUES
(1, 'Carlos Mendoza', '12345678901', '987654321', 'carlos.mendoza@gmail.com', '2024-07-21 10:00:00', '2024-07-21 10:00:00'),
(2, 'Ana María Gómez', '10987654321', '976543210', 'ana.gomez@hotmail.com', '2024-07-20 10:05:00', '2024-07-20 10:05:00'),
(3, 'Luis Fernández', '20234567890', '965432109', 'luis.fernandez@gmail.com', '2024-07-19 10:10:00', '2024-07-19 10:10:00'),
(4, 'Maria Ruiz', '30345678901', '954321087', 'maria.ruiz@yahoo.com', '2024-07-18 10:15:00', '2024-07-18 10:15:00'),
(5, 'Jorge Morales', '40456789012', '943210876', 'jorge.morales@outlook.com', '2024-07-17 10:20:00', '2024-07-17 10:20:00'),
(6, 'Patricia López', '50567890123', '932109765', 'patricia.lopez@gmail.com', '2024-07-16 10:25:00', '2024-07-16 10:25:00'),
(7, 'Fernando Silva', '60678901234', '921098654', 'fernando.silva@hotmail.com', '2024-07-15 10:30:00', '2024-07-15 10:30:00'),
(8, 'Laura Castro', '70789012345', '910987543', 'laura.castro@yahoo.com', '2024-07-14 10:35:00', '2024-07-14 10:35:00'),
(9, 'Andrés Gómez', '80890123456', '909876432', 'andres.gomez@gmail.com', '2024-07-13 10:40:00', '2024-07-13 10:40:00'),
(10, 'Sofia Martínez', '90901234567', '898765321', 'sofia.martinez@hotmail.com', '2024-07-12 10:45:00', '2024-07-12 10:45:00'),
(11, 'Miguel Pérez', '10123456789', '987654321', 'miguel.perez@gmail.com', '2024-07-11 10:50:00', '2024-07-11 10:50:00'),
(12, 'Gabriela Ortega', '11234567890', '976543210', 'gabriela.ortega@yahoo.com', '2024-07-10 10:55:00', '2024-07-10 10:55:00'),
(13, 'Ricardo Castillo', '12345678901', '965432109', 'ricardo.castillo@hotmail.com', '2024-07-09 11:00:00', '2024-07-09 11:00:00'),
(14, 'Verónica Vega', '13456789012', '954321087', 'veronica.vega@gmail.com', '2024-07-08 11:05:00', '2024-07-08 11:05:00'),
(15, 'Eduardo Fernández', '14567890123', '943210876', 'eduardo.fernandez@yahoo.com', '2024-07-07 11:10:00', '2024-07-07 11:10:00'),
(16, 'Claudia Ramírez', '15678901234', '932109765', 'claudia.ramirez@gmail.com', '2024-07-06 11:15:00', '2024-07-06 11:15:00'),
(17, 'Alejandro Torres', '16789012345', '921098654', 'alejandro.torres@hotmail.com', '2024-07-05 11:20:00', '2024-07-05 11:20:00'),
(18, 'Isabel Morales', '17890123456', '910987543', 'isabel.morales@yahoo.com', '2024-07-04 11:25:00', '2024-07-04 11:25:00'),
(19, 'Hugo Martínez', '18901234567', '909876432', 'hugo.martinez@gmail.com', '2024-07-03 11:30:00', '2024-07-03 11:30:00'),
(20, 'Nathalie Guzmán', '19012345678', '898765321', 'nathalie.guzman@hotmail.com', '2024-07-02 11:35:00', '2024-07-02 11:35:00'),
(21, 'Julio César Fernández', '20123456789', '887654310', 'julio.fernandez@gmail.com', '2024-07-01 11:40:00', '2024-07-01 11:40:00'),
(22, 'Mónica López', '21234567890', '876543209', 'monica.lopez@yahoo.com', '2024-06-30 11:45:00', '2024-06-30 11:45:00'),
(23, 'Raúl Rodríguez', '22345678901', '865432198', 'raul.rodriguez@hotmail.com', '2024-06-29 11:50:00', '2024-06-29 11:50:00'),
(24, 'Carmen López', '23456789012', '854321987', 'carmen.lopez@gmail.com', '2024-06-28 11:55:00', '2024-06-28 11:55:00'),
(25, 'José Martínez', '24567890123', '843210876', 'jose.martinez@yahoo.com', '2024-06-27 12:00:00', '2024-06-27 12:00:00'),
(26, 'Sarmiento Noel', '24567897989', '987546514', 'Sarmiento.N@gmail.com', '2024-07-23 07:12:22', '0000-00-00 00:00:00'),
(27, 'Aloba Shin', '89445679681', '987546518', 'Aloba.S@gmail.com', '2024-07-23 07:17:13', '0000-00-00 00:00:00'),
(28, 'Fernando Copaja', '0', '987546897', 'Fernando.C@gmail.com', '2024-07-23 09:52:06', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_compras`
--

CREATE TABLE `tb_compras` (
  `id_compra` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `nro_compra` int(11) NOT NULL,
  `fecha_compra` date NOT NULL,
  `id_proveedor` int(11) NOT NULL,
  `comprobante` varchar(255) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `precio_compra` varchar(50) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `fyh_creacion` datetime NOT NULL,
  `fyh_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tb_compras`
--

INSERT INTO `tb_compras` (`id_compra`, `id_producto`, `nro_compra`, `fecha_compra`, `id_proveedor`, `comprobante`, `id_usuario`, `precio_compra`, `cantidad`, `fyh_creacion`, `fyh_actualizacion`) VALUES
(1, 20, 1, '2024-07-15', 1, '98765432', 1, '250.00', 5, '2024-07-22 23:10:07', '2024-07-22 23:44:33'),
(2, 2, 2, '2024-06-20', 2, '87654321', 1, '250.00', 6, '2024-06-20 11:00:00', '2024-07-22 23:48:11'),
(3, 4, 3, '2024-06-25', 3, '76543210', 1, '250.00', 6, '2024-06-25 12:00:00', '2024-07-22 23:48:47'),
(4, 14, 4, '2024-07-01', 4, '65432109', 1, '250.00', 9, '2024-07-01 13:00:00', '2024-07-22 23:49:19'),
(5, 5, 5, '2024-07-05', 5, '54321098', 1, '250.00', 8, '2024-07-05 14:00:00', '2024-07-05 14:00:00'),
(6, 6, 6, '2024-07-10', 6, '43210987', 1, '180.00', 10, '2024-07-10 15:00:00', '2024-07-10 15:00:00'),
(7, 7, 7, '2024-07-12', 7, '32109876', 1, '220.00', 7, '2024-07-12 16:00:00', '2024-07-12 16:00:00'),
(8, 8, 7, '2024-07-15', 8, '21098765', 1, '275.00', 5, '2024-07-15 17:00:00', '2024-07-15 17:00:00'),
(9, 9, 9, '2024-07-18', 9, '10987654', 1, '320.00', 10, '2024-07-18 18:00:00', '2024-07-18 18:00:00'),
(10, 10, 10, '2024-07-20', 10, '09876543', 1, '360.00', 6, '2024-07-20 19:00:00', '2024-07-20 19:00:00'),
(11, 11, 11, '2024-07-22', 11, '98765012\n', 1, '450.00', 8, '2024-07-22 20:00:00', '2024-07-22 20:00:00'),
(12, 12, 12, '2024-07-23', 12, '98765012\n', 1, '500.00', 6, '2024-07-23 21:00:00', '2024-07-23 21:00:00'),
(13, 13, 13, '2024-07-24', 13, '12-76543211', 1, '420.00', 9, '2024-07-24 22:00:00', '2024-07-24 22:00:00'),
(14, 14, 14, '2024-07-25', 14, '65432122\n', 1, '340.00', 7, '2024-07-25 23:00:00', '2024-07-25 23:00:00'),
(15, 15, 15, '2024-07-26', 15, '54321033', 1, '280.00', 10, '2024-07-26 09:00:00', '2024-07-26 09:00:00'),
(16, 16, 16, '2024-07-27', 16, '43210944', 1, '150.00', 8, '2024-07-27 10:00:00', '2024-07-27 10:00:00'),
(17, 17, 17, '2024-07-28', 17, '32109855\n', 1, '200.00', 9, '2024-07-28 11:00:00', '2024-07-28 11:00:00'),
(18, 18, 18, '2024-07-29', 18, '21098766', 1, '280.00', 10, '2024-07-29 12:00:00', '2024-07-29 12:00:00'),
(19, 19, 19, '2024-07-30', 19, '10987677', 1, '330.00', 6, '2024-07-30 13:00:00', '2024-07-30 13:00:00'),
(20, 20, 20, '2024-07-31', 20, '19-09876588', 1, '400.00', 9, '2024-07-31 14:00:00', '2024-07-31 14:00:00'),
(21, 1, 21, '2024-07-15', 14, '94855432', 1, '5072.00', 8, '2024-07-23 07:56:07', '0000-00-00 00:00:00'),
(22, 3, 22, '2024-07-21', 8, '45786952', 1, '3600.00', 6, '2024-07-23 07:57:24', '0000-00-00 00:00:00'),
(23, 21, 23, '2024-07-10', 16, '45781045', 1, '13440.00', 7, '2024-07-23 09:25:18', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_proveedores`
--

CREATE TABLE `tb_proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `nombre_proveedor` varchar(255) NOT NULL,
  `celular` varchar(50) NOT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `empresa` varchar(255) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `direccion` varchar(255) NOT NULL,
  `fyh_creacion` datetime NOT NULL,
  `fyh_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tb_proveedores`
--

INSERT INTO `tb_proveedores` (`id_proveedor`, `nombre_proveedor`, `celular`, `telefono`, `empresa`, `email`, `direccion`, `fyh_creacion`, `fyh_actualizacion`) VALUES
(1, 'Martín Guerrero', '958123456', '981234567', 'TechLatam S.A.', 'martin.guerrero@techlatam.com', 'Av. Libertador # 123', '2024-07-21 09:00:00', '2024-07-21 09:00:00'),
(2, 'Valeria Soto', '958234567', '982345678', 'InnovaComputers S.A.', 'valeria.soto@innovacomputers.com', 'Calle del Sol # 456', '2024-07-20 09:05:00', '2024-07-20 09:05:00'),
(3, 'Héctor Vidal', '958345678', '983456789', 'RedTech LTDA.', 'hector.vidal@redtech.com', 'Av. San Martín # 789', '2024-07-19 09:10:00', '2024-07-19 09:10:00'),
(4, 'Elena Bravo', '958456789', '984567890', 'CompuGlobal S.A.', 'elena.bravo@compuglobal.com', 'Calle Santa Cruz # 321', '2024-07-18 09:15:00', '2024-07-18 09:15:00'),
(5, 'Sebastián Morales', '958567890', '985678901', 'GlobalTech S.A.C.', 'sebastian.morales@globaltech.com', 'Av. 9 de Octubre # 654', '2024-07-17 09:20:00', '2024-07-17 09:20:00'),
(6, 'Juliana Restrepo', '958678901', '986789012', 'Innovatech LTDA.', 'juliana.restrepo@innovatech.com', 'Calle de la Innovación # 987', '2024-07-16 09:25:00', '2024-07-16 09:25:00'),
(7, 'Ricardo Mendoza', '958789012', '987890123', 'TechSolutions S.A.', 'ricardo.mendoza@techsolutions.com', 'Av. Revolución # 135', '2024-07-15 09:30:00', '2024-07-15 09:30:00'),
(8, 'Camila Hernández', '958890123', '988901234', 'CompuNet LTDA.', 'camila.hernandez@compunet.com', 'Calle 5 de Febrero # 246', '2024-07-14 09:35:00', '2024-07-14 09:35:00'),
(9, 'Gabriel Álvarez', '958901234', '989012345', 'Tecnología Avanzada S.A.', 'gabriel.alvarez@tecavanzada.com', 'Av. de la Tecnología # 357', '2024-07-13 09:40:00', '2024-07-13 09:40:00'),
(10, 'Natalia Paredes', '958012345', '980123456', 'Computech S.A.C.', 'natalia.paredes@computech.com', 'Calle de la Computación # 468', '2024-07-12 09:45:00', '2024-07-12 09:45:00'),
(11, 'Eduardo Silva', '958123457', '981234568', 'DataSystems LTDA.', 'eduardo.silva@datasystems.com', 'Av. del Progreso # 579', '2024-07-11 09:50:00', '2024-07-11 09:50:00'),
(12, 'Isabella Guzmán', '958234568', '982345679', 'TechPro S.A.', 'isabella.guzman@techpro.com', 'Calle de la Avanzada # 680', '2024-07-10 09:55:00', '2024-07-10 09:55:00'),
(13, 'Mauricio Torres', '958345679', '983456780', 'Computers Latin S.A.C.', 'mauricio.torres@computerslatin.com', 'Av. Central # 791', '2024-07-09 10:00:00', '2024-07-09 10:00:00'),
(14, 'Claudia Castillo', '958456780', '984567891', 'Innovación Digital S.A.', 'claudia.castillo@innovaciondigital.com', 'Calle de la Innovación # 902', '2024-07-08 10:05:00', '2024-07-08 10:05:00'),
(15, 'Alejandro Rivera', '958567891', '985678902', 'FutureTech LTDA.', 'alejandro.rivera@futuretech.com', 'Av. del Futuro # 123', '2024-07-07 10:10:00', '2024-07-07 10:10:00'),
(16, 'Sara Mendoza', '958678902', '986789013', 'DigitalSolutions S.A.', 'sara.mendoza@digitalsolutions.com', 'Calle del Progreso # 234', '2024-07-06 10:15:00', '2024-07-06 10:15:00'),
(17, 'Luis Andrade', '958789013', '987890124', 'NetComputers LTDA.', 'luis.andrade@netcomputers.com', 'Av. de la Tecnología # 345', '2024-07-05 10:20:00', '2024-07-05 10:20:00'),
(18, 'Paola Castro', '958890124', '988901235', 'TechFront S.A.C.', 'paola.castro@techfront.com', 'Calle de la Innovación # 456', '2024-07-04 10:25:00', '2024-07-04 10:25:00'),
(19, 'Nicolás Cordero', '958901235', '989012346', 'Advanced Tech S.A.', 'nicolas.cordero@advancedtech.com', 'Av. del Progreso # 567', '2024-07-03 10:30:00', '2024-07-03 10:30:00'),
(20, 'Jazmín Morales', '958012346', '980123457', 'EliteComputers LTDA.', 'jazmin.morales@elitecomputers.com', 'Calle de la Avanzada # 678', '2024-07-02 10:35:00', '2024-07-02 10:35:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_roles`
--

CREATE TABLE `tb_roles` (
  `id_rol` int(11) NOT NULL,
  `rol` varchar(255) NOT NULL,
  `fyh_creacion` datetime NOT NULL,
  `fyh_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tb_roles`
--

INSERT INTO `tb_roles` (`id_rol`, `rol`, `fyh_creacion`, `fyh_actualizacion`) VALUES
(1, 'ADMINISTRADOR', '2024-07-21 23:15:19', '2024-07-21 23:15:19'),
(2, 'ALMACENERO', '2024-07-21 19:11:28', '2024-07-21 20:13:35'),
(3, 'VENDEDOR', '2024-07-23 10:02:04', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_usuarios`
--

CREATE TABLE `tb_usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombres` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_user` text NOT NULL,
  `id_rol` int(11) NOT NULL,
  `fyh_creacion` datetime NOT NULL,
  `fyh_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tb_usuarios`
--

INSERT INTO `tb_usuarios` (`id_usuario`, `nombres`, `email`, `password_user`, `id_rol`, `fyh_creacion`, `fyh_actualizacion`) VALUES
(1, 'Alexis Coaquira', 'adcoaquiraq@unjbg.edu.pe', 'admin', 1, '2024-07-21 15:16:01', '2024-07-21 15:16:01'),
(2, 'Eduardo Patricio', 'eypatricioc@unjbg.edu.pe', 'admin', 1, '2024-07-22 21:29:31', '0000-00-00 00:00:00'),
(3, 'Oscar Mamani', 'oemamanim@unjbg.edu.pe', 'admin', 1, '2024-07-22 21:31:30', '0000-00-00 00:00:00'),
(4, 'Yessica Miranda', 'MirandaY@gmail.com', 'alma1', 2, '2024-07-23 10:00:34', '0000-00-00 00:00:00'),
(5, 'Josep Alanoca', 'Josepalanoca@gmail.com', 'alma2', 2, '2024-07-23 10:01:48', '0000-00-00 00:00:00'),
(6, 'Santiago Choquecota', 'ChoqueSanti@gmail.com', 'vende1', 3, '2024-07-23 10:02:40', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_ventas`
--

CREATE TABLE `tb_ventas` (
  `id_venta` int(11) NOT NULL,
  `nro_venta` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `total_pagado` int(11) NOT NULL,
  `fyh_creacion` datetime NOT NULL,
  `fyh_actualizacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_ventas`
--

INSERT INTO `tb_ventas` (`id_venta`, `nro_venta`, `id_cliente`, `total_pagado`, `fyh_creacion`, `fyh_actualizacion`) VALUES
(1, 1, 1, 6399, '2024-07-23 08:49:35', '0000-00-00 00:00:00'),
(2, 2, 28, 600, '2024-07-23 09:52:28', '0000-00-00 00:00:00');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tb_almacen`
--
ALTER TABLE `tb_almacen`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `tb_carrito`
--
ALTER TABLE `tb_carrito`
  ADD PRIMARY KEY (`id_carrito`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_venta` (`nro_venta`);

--
-- Indices de la tabla `tb_categorias`
--
ALTER TABLE `tb_categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `tb_clientes`
--
ALTER TABLE `tb_clientes`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `tb_compras`
--
ALTER TABLE `tb_compras`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_proveedor` (`id_proveedor`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `tb_proveedores`
--
ALTER TABLE `tb_proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `tb_roles`
--
ALTER TABLE `tb_roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `tb_usuarios`
--
ALTER TABLE `tb_usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `id_rol` (`id_rol`);

--
-- Indices de la tabla `tb_ventas`
--
ALTER TABLE `tb_ventas`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `nro_venta` (`nro_venta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tb_almacen`
--
ALTER TABLE `tb_almacen`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `tb_carrito`
--
ALTER TABLE `tb_carrito`
  MODIFY `id_carrito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tb_categorias`
--
ALTER TABLE `tb_categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `tb_clientes`
--
ALTER TABLE `tb_clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `tb_compras`
--
ALTER TABLE `tb_compras`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `tb_proveedores`
--
ALTER TABLE `tb_proveedores`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `tb_roles`
--
ALTER TABLE `tb_roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tb_usuarios`
--
ALTER TABLE `tb_usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tb_ventas`
--
ALTER TABLE `tb_ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tb_almacen`
--
ALTER TABLE `tb_almacen`
  ADD CONSTRAINT `tb_almacen_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `tb_categorias` (`id_categoria`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_almacen_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `tb_carrito`
--
ALTER TABLE `tb_carrito`
  ADD CONSTRAINT `tb_carrito_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `tb_almacen` (`id_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_compras`
--
ALTER TABLE `tb_compras`
  ADD CONSTRAINT `tb_compras_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `tb_almacen` (`id_producto`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_compras_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_compras_ibfk_4` FOREIGN KEY (`id_proveedor`) REFERENCES `tb_proveedores` (`id_proveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_usuarios`
--
ALTER TABLE `tb_usuarios`
  ADD CONSTRAINT `tb_usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `tb_roles` (`id_rol`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `tb_ventas`
--
ALTER TABLE `tb_ventas`
  ADD CONSTRAINT `tb_ventas_ibfk_2` FOREIGN KEY (`nro_venta`) REFERENCES `tb_carrito` (`nro_venta`),
  ADD CONSTRAINT `tb_ventas_ibfk_3` FOREIGN KEY (`id_cliente`) REFERENCES `tb_clientes` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
