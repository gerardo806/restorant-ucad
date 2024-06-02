/*BITACORA*/
DELIMITER $$
CREATE PROCEDURE `registrarBitacora`(
    IN `p_idafectado` INT,
    IN `p_nombre_tabla` VARCHAR(45),
    IN `p_idusuario` INT,
    IN `p_idpermiso` INT,
    IN `p_info_previa` TEXT,
    IN `p_info_posterior` TEXT
)
BEGIN
    DECLARE v_idbitacora INT;

    -- Insertar en bitacora
    INSERT INTO `mydb`.`bitacora` (`fecha`, `nombre_tabla`, `idafectado`, `idusuario`, `idpermiso`)
    VALUES (NOW(), p_nombre_tabla, p_idafectado, p_idusuario, p_idpermiso);

    -- Obtener el ID de la bitácora insertada
    SET v_idbitacora = LAST_INSERT_ID();

    -- Insertar en detalle_bitacora
    INSERT INTO `mydb`.`detalle_bitacora` (`info_previa`, `info_posterior`, `idbitacora`)
    VALUES (p_info_previa, p_info_posterior, v_idbitacora);
END$$
DELIMITER ;

/*USUARIO*/
DELIMITER $$

CREATE PROCEDURE `obtenerInformacionUsuarios`(
	IN idusuario_params INT
)
BEGIN
    SELECT 
        p.nombres,
        p.apellidos,
        e.codigo,
        u.nombre_usuario
    FROM 
        persona p
    INNER JOIN 
        empleado e ON p.idpersona = e.idpersona
    INNER JOIN 
        usuario u ON e.idempleado = u.idusuario
	WHERE u.idusuario = idusuario_params;
END$$

DELIMITER ;

/*menu*/
DELIMITER $$

CREATE PROCEDURE `insertarMenuCompleto`(
    IN nombre_menu VARCHAR(45),
    IN nombre_platillo VARCHAR(45),
    IN precio_platillo DECIMAL(10,2),
    IN nombre_bebida VARCHAR(45),
    IN precio_bebida DECIMAL(10,2),
    IN cantidad_bebida INT
)
BEGIN
    DECLARE menu_id INT;
    DECLARE platillo_id INT;
    DECLARE bebida_id INT;

    -- Insertar en menu_cocina
    INSERT INTO menu_cocina (nombre_menu)
    VALUES (nombre_menu);
    SET menu_id = LAST_INSERT_ID();

    -- Insertar en platillo
    INSERT INTO platillo (nombre_platillo, precio)
    VALUES (nombre_platillo, precio_platillo);
    SET platillo_id = LAST_INSERT_ID();

    -- Insertar en bebida
    INSERT INTO bebida (nombre_bebida, precio)
    VALUES (nombre_bebida, precio_bebida);
    SET bebida_id = LAST_INSERT_ID();

    -- Insertar en menu_platillo
    INSERT INTO menu_platillo (idmenu_cocina, idplatillo)
    VALUES (menu_id, platillo_id);

    -- Insertar en menu_bebida
    INSERT INTO menu_bebida (idmenu_cocina, idbebida, cantidad_bebida)
    VALUES (menu_id, bebida_id, cantidad_bebida);
END$$

DELIMITER ;

/*tipo pedido*/
DELIMITER $$

CREATE PROCEDURE `insertarTipoPedido`(
    IN p_pedido VARCHAR(45),
    IN p_estado ENUM('1', '0')
)
BEGIN
    -- Insertar en tipo_pedido
    INSERT INTO tipo_pedido (pedido, estado)
    VALUES (p_pedido, p_estado);
END$$

DELIMITER ;

/*tipo bebida*/
DELIMITER $$

CREATE PROCEDURE `insertarTipoBebida`(
    IN p_nombre_bebida VARCHAR(45),
    IN p_estado ENUM('1', '0')
)
BEGIN
    -- Insertar en tipo_bebida
    INSERT INTO tipo_bebida (nombre_bebida, estado)
    VALUES (p_nombre_bebida, p_estado);
END$$

DELIMITER ;