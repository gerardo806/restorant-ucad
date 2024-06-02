-- Insertar registros en la tabla `permiso`
INSERT INTO `mydb`.`permiso` (`nombre_permiso`, `estado`) VALUES
('Permiso 1', '1'),
('Permiso 2', '1'),
('Permiso 3', '1'),
('Permiso 4', '1'),
('Permiso 5', '1');

-- Insertar registros en la tabla `usuario`
INSERT INTO `mydb`.`usuario` (`nombre_usuario`, `fecha_creacion`, `estado`) VALUES
('Usuario 1', NOW(), '1'),
('Usuario 2', NOW(), '1'),
('Usuario 3', NOW(), '1'),
('Usuario 4', NOW(), '1'),
('Usuario 5', NOW(), '1');

-- Insertar registros en la tabla `bitacora`
INSERT INTO `mydb`.`bitacora` (`fecha`, `nombre_tabla`, `idafectado`, `idusuario`, `idpermiso`) VALUES
(NOW(), 'tabla1', 1, 1, 1),
(NOW(), 'tabla2', 2, 2, 2),
(NOW(), 'tabla3', 3, 3, 3),
(NOW(), 'tabla4', 4, 4, 4),
(NOW(), 'tabla5', 5, 5, 5);

-- Insertar registros en la tabla `clave`
INSERT INTO `mydb`.`clave` (`clave_usuario`, `fecha_creacion`, `fecha_vencimiento`, `estado`, `idusuario`) VALUES
('clave1', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR), '1', 1),
('clave2', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR), '1', 2),
('clave3', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR), '1', 3),
('clave4', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR), '1', 4),
('clave5', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR), '1', 5);

-- Insertar registros en la tabla `detalle_bitacora`
INSERT INTO `mydb`.`detalle_bitacora` (`info_previa`, `info_posterior`, `idbitacora`) VALUES
('info previa 1', 'info posterior 1', 1),
('info previa 2', 'info posterior 2', 2),
('info previa 3', 'info posterior 3', 3),
('info previa 4', 'info posterior 4', 4),
('info previa 5', 'info posterior 5', 5);

-- Insertar registros en la tabla `municipio`
INSERT INTO `mydb`.`municipio` (`nombre_municipio`, `estado`) VALUES
('Municipio 1', '1'),
('Municipio 2', '1'),
('Municipio 3', '1'),
('Municipio 4', '1'),
('Municipio 5', '1');

-- Insertar registros en la tabla `distrito`
INSERT INTO `mydb`.`distrito` (`nombre_distrito`, `estado`, `idmunicipio`) VALUES
('Distrito 1', '1', 1),
('Distrito 2', '1', 2),
('Distrito 3', '1', 3),
('Distrito 4', '1', 4),
('Distrito 5', '1', 5);

-- Insertar registros en la tabla `tipo_icono`
INSERT INTO `mydb`.`tipo_icono` (`clase_css`, `estado`) VALUES
('icono1', '1'),
('icono2', '1'),
('icono3', '1'),
('icono4', '1'),
('icono5', '1');

-- Insertar registros en la tabla `menu`
INSERT INTO `mydb`.`menu` (`nombre_menu`, `estado`, `idtipo_icono`) VALUES
('Menu 1', '1', 1),
('Menu 2', '1', 2),
('Menu 3', '1', 3),
('Menu 4', '1', 4),
('Menu 5', '1', 5);

-- Insertar registros en la tabla `pantalla`
INSERT INTO `mydb`.`pantalla` (`nombre_pantalla`, `url`, `estado`, `idtipo_icono`) VALUES
('Pantalla 1', 'url1', '1', 1),
('Pantalla 2', 'url2', '1', 2),
('Pantalla 3', 'url3', '1', 3),
('Pantalla 4', 'url4', '1', 4),
('Pantalla 5', 'url5', '1', 5);

-- Insertar registros en la tabla `menu_pantalla`
INSERT INTO `mydb`.`menu_pantalla` (`estado`, `idmenu`, `idpantalla`) VALUES
('1', 1, 1),
('1', 2, 2),
('1', 3, 3),
('1', 4, 4),
('1', 5, 5);

-- Insertar registros en la tabla `rol`
INSERT INTO `mydb`.`rol` (`descripcion`, `estado`) VALUES
('Rol 1', '1'),
('Rol 2', '1'),
('Rol 3', '1'),
('Rol 4', '1'),
('Rol 5', '1');

-- Insertar registros en la tabla `menu_rol`
INSERT INTO `mydb`.`menu_rol` (`estado`, `idrol`, `idmenu`) VALUES
('1', 1, 1),
('1', 2, 2),
('1', 3, 3),
('1', 4, 4),
('1', 5, 5);

-- Insertar registros en la tabla `sexo`
INSERT INTO `mydb`.`sexo` (`nombre_sexo`, `estado`) VALUES
('Masculino', '1'),
('Femenino', '1'),
('Otro', '1'),
('No especificado', '1'),
('Prefiero no decirlo', '1');

-- Insertar registros en la tabla `persona`
INSERT INTO `mydb`.`persona` (`nombres`, `apellidos`, `fecha_nacimiento`, `idsexo`, `estado`) VALUES
('Nombre 1', 'Apellido 1', '1990-01-01', 1, '1'),
('Nombre 2', 'Apellido 2', '1991-02-02', 2, '1'),
('Nombre 3', 'Apellido 3', '1992-03-03', 3, '1'),
('Nombre 4', 'Apellido 4', '1993-04-04', 4, '1'),
('Nombre 5', 'Apellido 5', '1994-05-05', 5, '1');