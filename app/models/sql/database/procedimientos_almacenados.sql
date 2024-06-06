/BITACORA/
DELIMITER $$
CREATE PROCEDURE registrarBitacora(
    IN p_idafectado INT,
    IN p_nombre_tabla VARCHAR(45),
    IN p_idusuario INT,
    IN p_idpermiso INT,
    IN p_info_previa TEXT,
    IN p_info_posterior TEXT
)
BEGIN
    DECLARE v_idbitacora INT;

    -- Insertar en bitacora
    INSERT INTO mydb.bitacora (fecha, nombre_tabla, idafectado, idusuario, idpermiso)
    VALUES (NOW(), p_nombre_tabla, p_idafectado, p_idusuario, p_idpermiso);

    -- Obtener el ID de la bitácora insertada
    SET v_idbitacora = LAST_INSERT_ID();

    -- Insertar en detalle_bitacora
    INSERT INTO mydb.detalle_bitacora (info_previa, info_posterior, idbitacora)
    VALUES (p_info_previa, p_info_posterior, v_idbitacora);
END$$
DELIMITER ;


