-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb3 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`permiso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`permiso` (
  `idpermiso` INT NOT NULL AUTO_INCREMENT,
  `nombre_permiso` VARCHAR(50) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idpermiso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nombre_usuario` VARCHAR(45) NOT NULL,
  `fecha_creacion` DATETIME NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`bitacora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bitacora` (
  `idbitacora` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `nombre_tabla` VARCHAR(45) NOT NULL,
  `idafectado` INT NULL DEFAULT NULL,
  `idusuario` INT NOT NULL,
  `idpermiso` INT NOT NULL,
  PRIMARY KEY (`idbitacora`),
  INDEX `fk_bitacora_usuario1_idx` (`idusuario` ASC) ,
  INDEX `fk_bitacora_permiso1_idx` (`idpermiso` ASC) ,
  CONSTRAINT `fk_bitacora_permiso1`
    FOREIGN KEY (`idpermiso`)
    REFERENCES `mydb`.`permiso` (`idpermiso`),
  CONSTRAINT `fk_bitacora_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`clave`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`clave` (
  `idclave` INT NOT NULL AUTO_INCREMENT,
  `clave_usuario` VARCHAR(512) NOT NULL,
  `fecha_creacion` DATETIME NOT NULL,
  `fecha_vencimiento` DATETIME NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  `idusuario` INT NOT NULL,
  PRIMARY KEY (`idclave`, `fecha_creacion`),
  INDEX `fk_clave_usuario1_idx` (`idusuario` ASC) ,
  CONSTRAINT `fk_clave_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`detalle_bitacora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`detalle_bitacora` (
  `iddetalle_bitacora` INT NOT NULL AUTO_INCREMENT,
  `info_previa` TEXT NOT NULL,
  `info_posterior` TEXT NOT NULL,
  `idbitacora` INT NOT NULL,
  PRIMARY KEY (`iddetalle_bitacora`),
  INDEX `fk_detalle_bitacora_bitacora1_idx` (`idbitacora` ASC) ,
  CONSTRAINT `fk_detalle_bitacora_bitacora1`
    FOREIGN KEY (`idbitacora`)
    REFERENCES `mydb`.`bitacora` (`idbitacora`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`municipio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`municipio` (
  `idmunicipio` INT NOT NULL AUTO_INCREMENT,
  `nombre_municipio` VARCHAR(45) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idmunicipio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`distrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`distrito` (
  `iddistrito` INT NOT NULL AUTO_INCREMENT,
  `nombre_distrito` VARCHAR(45) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  `idmunicipio` INT NOT NULL,
  PRIMARY KEY (`iddistrito`),
  INDEX `fk_distrito_municipio1_idx` (`idmunicipio` ASC) ,
  CONSTRAINT `fk_distrito_municipio1`
    FOREIGN KEY (`idmunicipio`)
    REFERENCES `mydb`.`municipio` (`idmunicipio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_icono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_icono` (
  `idtipo_icono` INT NOT NULL AUTO_INCREMENT,
  `clase_css` VARCHAR(45) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idtipo_icono`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`menu` (
  `idmenu` INT NOT NULL AUTO_INCREMENT,
  `nombre_menu` VARCHAR(45) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  `idtipo_icono` INT NOT NULL,
  PRIMARY KEY (`idmenu`),
  INDEX `fk_menu_tipo_icono1_idx` (`idtipo_icono` ASC) ,
  CONSTRAINT `fk_menu_tipo_icono1`
    FOREIGN KEY (`idtipo_icono`)
    REFERENCES `mydb`.`tipo_icono` (`idtipo_icono`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`pantalla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pantalla` (
  `idpantalla` INT NOT NULL AUTO_INCREMENT,
  `nombre_pantalla` VARCHAR(45) NOT NULL,
  `url` VARCHAR(45) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  `idtipo_icono` INT NOT NULL,
  PRIMARY KEY (`idpantalla`),
  INDEX `fk_pantalla_tipo_icono1_idx` (`idtipo_icono` ASC) ,
  CONSTRAINT `fk_pantalla_tipo_icono1`
    FOREIGN KEY (`idtipo_icono`)
    REFERENCES `mydb`.`tipo_icono` (`idtipo_icono`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`menu_pantalla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`menu_pantalla` (
  `idmenu_pantalla` INT NOT NULL AUTO_INCREMENT,
  `estado` ENUM('1', '0') NOT NULL,
  `idmenu` INT NOT NULL,
  `idpantalla` INT NOT NULL,
  PRIMARY KEY (`idmenu_pantalla`),
  INDEX `fk_menu_pantalla_menu1_idx` (`idmenu` ASC) ,
  INDEX `fk_menu_pantalla_pantalla1_idx` (`idpantalla` ASC) ,
  CONSTRAINT `fk_menu_pantalla_menu1`
    FOREIGN KEY (`idmenu`)
    REFERENCES `mydb`.`menu` (`idmenu`),
  CONSTRAINT `fk_menu_pantalla_pantalla1`
    FOREIGN KEY (`idpantalla`)
    REFERENCES `mydb`.`pantalla` (`idpantalla`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rol` (
  `idrol` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(250) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idrol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`menu_rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`menu_rol` (
  `idmenu_rol` INT NOT NULL AUTO_INCREMENT,
  `estado` ENUM('1', '0') NOT NULL,
  `idrol` INT NOT NULL,
  `idmenu` INT NOT NULL,
  PRIMARY KEY (`idmenu_rol`),
  INDEX `fk_menu_rol_rol1_idx` (`idrol` ASC) ,
  INDEX `fk_menu_rol_menu1_idx` (`idmenu` ASC) ,
  CONSTRAINT `fk_menu_rol_menu1`
    FOREIGN KEY (`idmenu`)
    REFERENCES `mydb`.`menu` (`idmenu`),
  CONSTRAINT `fk_menu_rol_rol1`
    FOREIGN KEY (`idrol`)
    REFERENCES `mydb`.`rol` (`idrol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`sexo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sexo` (
  `idsexo` INT NOT NULL AUTO_INCREMENT,
  `nombre_sexo` VARCHAR(45) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idsexo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`persona` (
  `idpersona` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATETIME NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  `idsexo` INT NOT NULL,
  PRIMARY KEY (`idpersona`),
  INDEX `fk_persona_sexo1_idx` (`idsexo` ASC) ,
  CONSTRAINT `fk_persona_sexo1`
    FOREIGN KEY (`idsexo`)
    REFERENCES `mydb`.`sexo` (`idsexo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_correo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_correo` (
  `idtipo_correo` INT NOT NULL AUTO_INCREMENT,
  `nombre_correo` VARCHAR(45) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idtipo_correo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`persona_correo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`persona_correo` (
  `idpersona_correo` INT NOT NULL AUTO_INCREMENT,
  `correo_electronico` VARCHAR(100) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  `idtipo_correo` INT NOT NULL,
  `idpersona` INT NOT NULL,
  PRIMARY KEY (`idpersona_correo`),
  INDEX `fk_persona_correo_tipo_correo1_idx` (`idtipo_correo` ASC) ,
  INDEX `fk_persona_correo_persona1_idx` (`idpersona` ASC) ,
  CONSTRAINT `fk_persona_correo_persona1`
    FOREIGN KEY (`idpersona`)
    REFERENCES `mydb`.`persona` (`idpersona`),
  CONSTRAINT `fk_persona_correo_tipo_correo1`
    FOREIGN KEY (`idtipo_correo`)
    REFERENCES `mydb`.`tipo_correo` (`idtipo_correo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`persona_direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`persona_direccion` (
  `idpersona_direccion` INT NOT NULL AUTO_INCREMENT,
  `localidad` VARCHAR(300) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  `iddistrito` INT NOT NULL,
  `idpersona` INT NOT NULL,
  PRIMARY KEY (`idpersona_direccion`),
  INDEX `fk_persona_direccion_distrito1_idx` (`iddistrito` ASC) ,
  INDEX `fk_persona_direccion_persona1_idx` (`idpersona` ASC) ,
  CONSTRAINT `fk_persona_direccion_distrito1`
    FOREIGN KEY (`iddistrito`)
    REFERENCES `mydb`.`distrito` (`iddistrito`),
  CONSTRAINT `fk_persona_direccion_persona1`
    FOREIGN KEY (`idpersona`)
    REFERENCES `mydb`.`persona` (`idpersona`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_doc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_doc` (
  `idtipo_doc` INT NOT NULL AUTO_INCREMENT,
  `nombre_doc` VARCHAR(45) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idtipo_doc`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`persona_doc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`persona_doc` (
  `idpersona_doc` INT NOT NULL AUTO_INCREMENT,
  `documento` VARCHAR(45) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  `idtipo_doc` INT NOT NULL,
  `idpersona` INT NOT NULL,
  PRIMARY KEY (`idpersona_doc`),
  INDEX `fk_persona_doc_tipo_doc1_idx` (`idtipo_doc` ASC) ,
  INDEX `fk_persona_doc_persona1_idx` (`idpersona` ASC) ,
  CONSTRAINT `fk_persona_doc_persona1`
    FOREIGN KEY (`idpersona`)
    REFERENCES `mydb`.`persona` (`idpersona`),
  CONSTRAINT `fk_persona_doc_tipo_doc1`
    FOREIGN KEY (`idtipo_doc`)
    REFERENCES `mydb`.`tipo_doc` (`idtipo_doc`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_tel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_tel` (
  `idtipo_tel` INT NOT NULL AUTO_INCREMENT,
  `nombre_tel` VARCHAR(45) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idtipo_tel`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`persona_tel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`persona_tel` (
  `idpersona_tel` INT NOT NULL AUTO_INCREMENT,
  `telefono` VARCHAR(45) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  `idpersona` INT NOT NULL,
  `idtipo_tel` INT NOT NULL,
  PRIMARY KEY (`idpersona_tel`),
  INDEX `fk_persona_tel_persona1_idx` (`idpersona` ASC) ,
  INDEX `fk_persona_tel_tipo_tel1_idx` (`idtipo_tel` ASC) ,
  CONSTRAINT `fk_persona_tel_persona1`
    FOREIGN KEY (`idpersona`)
    REFERENCES `mydb`.`persona` (`idpersona`),
  CONSTRAINT `fk_persona_tel_tipo_tel1`
    FOREIGN KEY (`idtipo_tel`)
    REFERENCES `mydb`.`tipo_tel` (`idtipo_tel`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`rol_pemiso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rol_pemiso` (
  `idrol_pemiso` INT NOT NULL AUTO_INCREMENT,
  `estado` ENUM('1', '0') NOT NULL,
  `idpermiso` INT NOT NULL,
  `idrol` INT NOT NULL,
  PRIMARY KEY (`idrol_pemiso`),
  INDEX `fk_rol_pemiso_permiso_idx` (`idpermiso` ASC) ,
  INDEX `fk_rol_pemiso_rol1_idx` (`idrol` ASC) ,
  CONSTRAINT `fk_rol_pemiso_permiso`
    FOREIGN KEY (`idpermiso`)
    REFERENCES `mydb`.`permiso` (`idpermiso`),
  CONSTRAINT `fk_rol_pemiso_rol1`
    FOREIGN KEY (`idrol`)
    REFERENCES `mydb`.`rol` (`idrol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`lapso_plaza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`lapso_plaza` (
  `idlapso_plaza` INT NOT NULL AUTO_INCREMENT,
  `lapzo` VARCHAR(45) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idlapso_plaza`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`titulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`titulo` (
  `idtitulo` INT NOT NULL AUTO_INCREMENT,
  `nombre_titulo` VARCHAR(100) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idtitulo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cargo` (
  `idcargo` INT NOT NULL AUTO_INCREMENT,
  `nombre_cargo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  `idtitulo` INT NOT NULL,
  `ruta_img` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`idcargo`),
  INDEX `fk_cargo_titulo1_idx` (`idtitulo` ASC) ,
  CONSTRAINT `fk_cargo_titulo1`
    FOREIGN KEY (`idtitulo`)
    REFERENCES `mydb`.`titulo` (`idtitulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`contratacion_empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`contratacion_empleado` (
  `idcontratacion_empleado` INT NOT NULL AUTO_INCREMENT,
  `salario` DECIMAL NOT NULL,
  `fecha_contratacion` DATETIME NOT NULL,
  `idlapso_plaza` INT NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  `cargo_idcargo` INT NOT NULL,
  PRIMARY KEY (`idcontratacion_empleado`),
  INDEX `fk_contratacion_empleado_lapso_plaza1_idx` (`idlapso_plaza` ASC) ,
  INDEX `fk_contratacion_empleado_cargo1_idx` (`cargo_idcargo` ASC) ,
  CONSTRAINT `fk_contratacion_empleado_lapso_plaza1`
    FOREIGN KEY (`idlapso_plaza`)
    REFERENCES `mydb`.`lapso_plaza` (`idlapso_plaza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contratacion_empleado_cargo1`
    FOREIGN KEY (`cargo_idcargo`)
    REFERENCES `mydb`.`cargo` (`idcargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`empleado` (
  `idempleado` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `idpersona` INT NOT NULL,
  `idcontratacion_empleado` INT NOT NULL,
  PRIMARY KEY (`idempleado`),
  INDEX `fk_empleado_persona1_idx` (`idpersona` ASC) ,
  INDEX `fk_empleado_contratacion_empleado1_idx` (`idcontratacion_empleado` ASC) ,
  CONSTRAINT `fk_empleado_persona1`
    FOREIGN KEY (`idpersona`)
    REFERENCES `mydb`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_contratacion_empleado1`
    FOREIGN KEY (`idcontratacion_empleado`)
    REFERENCES `mydb`.`contratacion_empleado` (`idcontratacion_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`horario_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`horario_laboral` (
  `idhorario_laboral` INT NOT NULL AUTO_INCREMENT,
  `inicio` TIME NOT NULL,
  `fin` TIME NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idhorario_laboral`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`grupo` (
  `idgrup` INT NOT NULL AUTO_INCREMENT,
  `codigo_grupo` VARCHAR(45) NOT NULL,
  `nombre_grupo` VARCHAR(45) NULL,
  `estado` ENUM('1', '0') NOT NULL,
  `idhorario_laboral` INT NOT NULL,
  PRIMARY KEY (`idgrup`),
  INDEX `fk_grupo_horario_laboral1_idx` (`idhorario_laboral` ASC) ,
  CONSTRAINT `fk_grupo_horario_laboral1`
    FOREIGN KEY (`idhorario_laboral`)
    REFERENCES `mydb`.`horario_laboral` (`idhorario_laboral`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`empleado_grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`empleado_grupo` (
  `idempleado_grupo` INT NOT NULL AUTO_INCREMENT,
  `estado` ENUM('1', '0') NOT NULL,
  `empleado_idempleado` INT NOT NULL,
  `grupo_idgrup` INT NOT NULL,
  PRIMARY KEY (`idempleado_grupo`),
  INDEX `fk_empleado_grupo_empleado1_idx` (`empleado_idempleado` ASC) ,
  INDEX `fk_empleado_grupo_grupo1_idx` (`grupo_idgrup` ASC) ,
  CONSTRAINT `fk_empleado_grupo_empleado1`
    FOREIGN KEY (`empleado_idempleado`)
    REFERENCES `mydb`.`empleado` (`idempleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_grupo_grupo1`
    FOREIGN KEY (`grupo_idgrup`)
    REFERENCES `mydb`.`grupo` (`idgrup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_bebida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_bebida` (
  `idtipo_bebida` INT NOT NULL AUTO_INCREMENT,
  `nombre_bebida` VARCHAR(45) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idtipo_bebida`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`bebida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bebida` (
  `idbebida` INT NOT NULL AUTO_INCREMENT,
  `cantidad` VARCHAR(45) NOT NULL,
  `idtipo_bebida` INT NOT NULL,
  `precio` DECIMAL NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idbebida`),
  INDEX `fk_bebida_tipo_bebida1_idx` (`idtipo_bebida` ASC) ,
  CONSTRAINT `fk_bebida_tipo_bebida1`
    FOREIGN KEY (`idtipo_bebida`)
    REFERENCES `mydb`.`tipo_bebida` (`idtipo_bebida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`platillo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`platillo` (
  `idplatillo` INT NOT NULL AUTO_INCREMENT,
  `nombre_platillo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `precio` DECIMAL NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idplatillo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`menu_cocina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`menu_cocina` (
  `idmenu_cocina` INT NOT NULL AUTO_INCREMENT,
  `nombre_menu` VARCHAR(45) NOT NULL,
  `idbebida` INT NOT NULL,
  `idplatillo` INT NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  `ruta_img` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`idmenu_cocina`),
  INDEX `fk_menu_combo_bebida1_idx` (`idbebida` ASC) ,
  INDEX `fk_menu_combo_platillo1_idx` (`idplatillo` ASC) ,
  CONSTRAINT `fk_menu_combo_bebida1`
    FOREIGN KEY (`idbebida`)
    REFERENCES `mydb`.`bebida` (`idbebida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_combo_platillo1`
    FOREIGN KEY (`idplatillo`)
    REFERENCES `mydb`.`platillo` (`idplatillo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`promocion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`promocion` (
  `idpromocion` INT NOT NULL AUTO_INCREMENT,
  `descuento` DECIMAL NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  `idmenu_combo` INT NOT NULL,
  PRIMARY KEY (`idpromocion`),
  INDEX `fk_promocion_menu_combo1_idx` (`idmenu_combo` ASC) ,
  CONSTRAINT `fk_promocion_menu_combo1`
    FOREIGN KEY (`idmenu_combo`)
    REFERENCES `mydb`.`menu_cocina` (`idmenu_cocina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`lapso_promocion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`lapso_promocion` (
  `idlapso_promocion` INT NOT NULL AUTO_INCREMENT,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idlapso_promocion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`postre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`postre` (
  `idpostre` INT NOT NULL AUTO_INCREMENT,
  `nombre_postre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `precio` DECIMAL NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idpostre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`menu_cocina_postre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`menu_cocina_postre` (
  `idmenu_cocina_postre` INT NOT NULL AUTO_INCREMENT,
  `estado` ENUM('1', '0') NOT NULL,
  `idpostre` INT NOT NULL,
  `idmenu_cocina` INT NOT NULL,
  `precio` DECIMAL NOT NULL,
  PRIMARY KEY (`idmenu_cocina_postre`),
  INDEX `fk_menu_combo_postre_postre1_idx` (`idpostre` ASC) ,
  INDEX `fk_menu_cocina_postre_menu_cocina1_idx` (`idmenu_cocina` ASC) ,
  CONSTRAINT `fk_menu_combo_postre_postre1`
    FOREIGN KEY (`idpostre`)
    REFERENCES `mydb`.`postre` (`idpostre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_cocina_postre_menu_cocina1`
    FOREIGN KEY (`idmenu_cocina`)
    REFERENCES `mydb`.`menu_cocina` (`idmenu_cocina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`alimentos_adicionales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`alimentos_adicionales` (
  `idalimentos_adicionales` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` DECIMAL NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idalimentos_adicionales`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`combo_menu_postre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`combo_menu_postre` (
  `idcombo_menu_postre` INT NOT NULL AUTO_INCREMENT,
  `precio` DECIMAL NOT NULL,
  `idmenu_cocina_postre` INT NOT NULL,
  `idalimentos_adicionales` INT NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idcombo_menu_postre`),
  INDEX `fk_combo_menu_postre_menu_cocina_postre1_idx` (`idmenu_cocina_postre` ASC) ,
  INDEX `fk_combo_menu_postre_alimentos_adicionales1_idx` (`idalimentos_adicionales` ASC) ,
  CONSTRAINT `fk_combo_menu_postre_menu_cocina_postre1`
    FOREIGN KEY (`idmenu_cocina_postre`)
    REFERENCES `mydb`.`menu_cocina_postre` (`idmenu_cocina_postre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_combo_menu_postre_alimentos_adicionales1`
    FOREIGN KEY (`idalimentos_adicionales`)
    REFERENCES `mydb`.`alimentos_adicionales` (`idalimentos_adicionales`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`combo_multiple`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`combo_multiple` (
  `idcombo_multiple` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `idmenu_cocina` INT NOT NULL,
  `precio` DECIMAL NOT NULL,
  PRIMARY KEY (`idcombo_multiple`),
  INDEX `fk_combo_familiar_menu_cocina1_idx` (`idmenu_cocina` ASC) ,
  CONSTRAINT `fk_combo_familiar_menu_cocina1`
    FOREIGN KEY (`idmenu_cocina`)
    REFERENCES `mydb`.`menu_cocina` (`idmenu_cocina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`postres_multiples`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`postres_multiples` (
  `idpostres_multiples` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  `idpostre` INT NOT NULL,
  `precio` DECIMAL NOT NULL,
  PRIMARY KEY (`idpostres_multiples`),
  INDEX `fk_postres_multiples_postre1_idx` (`idpostre` ASC) ,
  CONSTRAINT `fk_postres_multiples_postre1`
    FOREIGN KEY (`idpostre`)
    REFERENCES `mydb`.`postre` (`idpostre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`alimentos_adicionales_multiples`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`alimentos_adicionales_multiples` (
  `idalimentos_adicionales_multiples` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  `precio` DECIMAL NOT NULL,
  `idalimentos_adicionales` INT NOT NULL,
  PRIMARY KEY (`idalimentos_adicionales_multiples`),
  INDEX `fk_alimentos_adicionales_multiples_alimentos_adicionales1_idx` (`idalimentos_adicionales` ASC) ,
  CONSTRAINT `fk_alimentos_adicionales_multiples_alimentos_adicionales1`
    FOREIGN KEY (`idalimentos_adicionales`)
    REFERENCES `mydb`.`alimentos_adicionales` (`idalimentos_adicionales`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`grupo_combo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`grupo_combo` (
  `idgrupo_combo` INT NOT NULL AUTO_INCREMENT,
  `nombre_combo` VARCHAR(45) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idgrupo_combo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`grupo_combo_multiple`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`grupo_combo_multiple` (
  `idgrupo_combo_multiple` INT NOT NULL AUTO_INCREMENT,
  `estado` ENUM('1', '0') NOT NULL,
  `idcombo_multiple` INT NOT NULL,
  `idgrupo_combo` INT NOT NULL,
  PRIMARY KEY (`idgrupo_combo_multiple`),
  INDEX `fk_grupo_combo_multiple_combo_multiple1_idx` (`idcombo_multiple` ASC) ,
  INDEX `fk_grupo_combo_multiple_grupo_combo1_idx` (`idgrupo_combo` ASC) ,
  CONSTRAINT `fk_grupo_combo_multiple_combo_multiple1`
    FOREIGN KEY (`idcombo_multiple`)
    REFERENCES `mydb`.`combo_multiple` (`idcombo_multiple`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupo_combo_multiple_grupo_combo1`
    FOREIGN KEY (`idgrupo_combo`)
    REFERENCES `mydb`.`grupo_combo` (`idgrupo_combo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`grupo_postres_multiples`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`grupo_postres_multiples` (
  `idgrupo_postres_multiples` INT NOT NULL AUTO_INCREMENT,
  `estado` ENUM('1', '0') NOT NULL,
  `idpostres_multiples` INT NOT NULL,
  `idgrupo_combo` INT NOT NULL,
  PRIMARY KEY (`idgrupo_postres_multiples`),
  INDEX `fk_grupo_postres_multiples_postres_multiples1_idx` (`idpostres_multiples` ASC) ,
  INDEX `fk_grupo_postres_multiples_grupo_combo1_idx` (`idgrupo_combo` ASC) ,
  CONSTRAINT `fk_grupo_postres_multiples_postres_multiples1`
    FOREIGN KEY (`idpostres_multiples`)
    REFERENCES `mydb`.`postres_multiples` (`idpostres_multiples`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupo_postres_multiples_grupo_combo1`
    FOREIGN KEY (`idgrupo_combo`)
    REFERENCES `mydb`.`grupo_combo` (`idgrupo_combo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`grupo_alim_adicionalea_mult`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`grupo_alim_adicionalea_mult` (
  `idgrupo_alim_adicionalea_mult` INT NOT NULL AUTO_INCREMENT,
  `estado` ENUM('1', '0') NOT NULL,
  `idalimentos_adicionales_multiples` INT NOT NULL,
  `idgrupo_combo` INT NOT NULL,
  PRIMARY KEY (`idgrupo_alim_adicionalea_mult`),
  INDEX `fk_grupo_alim_adicionalea_mult_alimentos_adicionales_multip_idx` (`idalimentos_adicionales_multiples` ASC) ,
  INDEX `fk_grupo_alim_adicionalea_mult_grupo_combo1_idx` (`idgrupo_combo` ASC) ,
  CONSTRAINT `fk_grupo_alim_adicionalea_mult_alimentos_adicionales_multiples1`
    FOREIGN KEY (`idalimentos_adicionales_multiples`)
    REFERENCES `mydb`.`alimentos_adicionales_multiples` (`idalimentos_adicionales_multiples`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupo_alim_adicionalea_mult_grupo_combo1`
    FOREIGN KEY (`idgrupo_combo`)
    REFERENCES `mydb`.`grupo_combo` (`idgrupo_combo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_pedido` (
  `idtipo_pedido` INT NOT NULL AUTO_INCREMENT,
  `pedido` VARCHAR(45) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idtipo_pedido`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `nombre_cliente` VARCHAR(45) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idcliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`estado_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`estado_pedido` (
  `idestado_pedido` INT NOT NULL AUTO_INCREMENT,
  `nombre_estado` VARCHAR(45) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idestado_pedido`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pedido` (
  `idpedido` INT NOT NULL AUTO_INCREMENT,
  `fecha_pedido` VARCHAR(45) NULL,
  `idcliente` INT NOT NULL,
  `usuario_caja` VARCHAR(45) NOT NULL,
  `tiempo_espera` TIME NOT NULL,
  `idestado_pedido` INT NOT NULL,
  `idtipo_pedido` INT NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idpedido`),
  INDEX `fk_pedido_cliente1_idx` (`idcliente` ASC) ,
  INDEX `fk_pedido_estado_pedido1_idx` (`idestado_pedido` ASC) ,
  INDEX `fk_pedido_tipo_pedido1_idx` (`idtipo_pedido` ASC) ,
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `mydb`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_estado_pedido1`
    FOREIGN KEY (`idestado_pedido`)
    REFERENCES `mydb`.`estado_pedido` (`idestado_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_tipo_pedido1`
    FOREIGN KEY (`idtipo_pedido`)
    REFERENCES `mydb`.`tipo_pedido` (`idtipo_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cuenta_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cuenta_cliente` (
  `idcuenta_cliente` INT NOT NULL AUTO_INCREMENT,
  `idpedido` INT NOT NULL,
  `total` DECIMAL NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idcuenta_cliente`),
  INDEX `fk_cuenta_cliente_pedido1_idx` (`idpedido` ASC) ,
  CONSTRAINT `fk_cuenta_cliente_pedido1`
    FOREIGN KEY (`idpedido`)
    REFERENCES `mydb`.`pedido` (`idpedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cuenta_cliente_combo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cuenta_cliente_combo` (
  `idcuenta_cliente_combo` INT NOT NULL AUTO_INCREMENT,
  `idcuenta_cliente` INT NOT NULL,
  `idgrupo_combo` INT NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idcuenta_cliente_combo`),
  INDEX `fk_cuenta_cliente_combo_cuenta_cliente1_idx` (`idcuenta_cliente` ASC) ,
  INDEX `fk_cuenta_cliente_combo_grupo_combo1_idx` (`idgrupo_combo` ASC) ,
  CONSTRAINT `fk_cuenta_cliente_combo_cuenta_cliente1`
    FOREIGN KEY (`idcuenta_cliente`)
    REFERENCES `mydb`.`cuenta_cliente` (`idcuenta_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cuenta_cliente_combo_grupo_combo1`
    FOREIGN KEY (`idgrupo_combo`)
    REFERENCES `mydb`.`grupo_combo` (`idgrupo_combo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cuenta_menu_postre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cuenta_menu_postre` (
  `idcuenta_menu_postre` INT NOT NULL AUTO_INCREMENT,
  `idcuenta_cliente` INT NOT NULL,
  `idcombo_menu_postre` INT NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idcuenta_menu_postre`),
  INDEX `fk_cuenta_menu_postre_cuenta_cliente1_idx` (`idcuenta_cliente` ASC) ,
  INDEX `fk_cuenta_menu_postre_combo_menu_postre1_idx` (`idcombo_menu_postre` ASC) ,
  CONSTRAINT `fk_cuenta_menu_postre_cuenta_cliente1`
    FOREIGN KEY (`idcuenta_cliente`)
    REFERENCES `mydb`.`cuenta_cliente` (`idcuenta_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cuenta_menu_postre_combo_menu_postre1`
    FOREIGN KEY (`idcombo_menu_postre`)
    REFERENCES `mydb`.`combo_menu_postre` (`idcombo_menu_postre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cuenta_cocina_postre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cuenta_cocina_postre` (
  `idcuenta_cocina_postre` INT NOT NULL AUTO_INCREMENT,
  `estado` ENUM('1', '0') NOT NULL,
  `idcuenta_cliente` INT NOT NULL,
  `idmenu_cocina_postre` INT NOT NULL,
  PRIMARY KEY (`idcuenta_cocina_postre`),
  INDEX `fk_cuenta_cocina_postre_cuenta_cliente1_idx` (`idcuenta_cliente` ASC) ,
  INDEX `fk_cuenta_cocina_postre_menu_cocina_postre1_idx` (`idmenu_cocina_postre` ASC) ,
  CONSTRAINT `fk_cuenta_cocina_postre_cuenta_cliente1`
    FOREIGN KEY (`idcuenta_cliente`)
    REFERENCES `mydb`.`cuenta_cliente` (`idcuenta_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cuenta_cocina_postre_menu_cocina_postre1`
    FOREIGN KEY (`idmenu_cocina_postre`)
    REFERENCES `mydb`.`menu_cocina_postre` (`idmenu_cocina_postre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cuenta_alimentos_adicionales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cuenta_alimentos_adicionales` (
  `idcuenta_alimentos_adicionales` INT NOT NULL AUTO_INCREMENT,
  `estado` ENUM('1', '0') NOT NULL,
  `idalimentos_adicionales` INT NOT NULL,
  `idcuenta_cliente` INT NOT NULL,
  PRIMARY KEY (`idcuenta_alimentos_adicionales`),
  INDEX `fk_cuenta_alimentos_adicionales_alimentos_adicionales1_idx` (`idalimentos_adicionales` ASC) ,
  INDEX `fk_cuenta_alimentos_adicionales_cuenta_cliente1_idx` (`idcuenta_cliente` ASC) ,
  CONSTRAINT `fk_cuenta_alimentos_adicionales_alimentos_adicionales1`
    FOREIGN KEY (`idalimentos_adicionales`)
    REFERENCES `mydb`.`alimentos_adicionales` (`idalimentos_adicionales`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cuenta_alimentos_adicionales_cuenta_cliente1`
    FOREIGN KEY (`idcuenta_cliente`)
    REFERENCES `mydb`.`cuenta_cliente` (`idcuenta_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_pago` (
  `idtipo_pago` INT NOT NULL AUTO_INCREMENT,
  `pago` VARCHAR(45) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idtipo_pago`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = armscii8;


-- -----------------------------------------------------
-- Table `mydb`.`pago_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pago_cliente` (
  `idpago_cliente` INT NOT NULL AUTO_INCREMENT,
  `numero_ticket` VARCHAR(45) NOT NULL,
  `valor_recibido` DECIMAL NOT NULL,
  `vuelto` DECIMAL NULL,
  `idcuenta_cliente` INT NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  PRIMARY KEY (`idpago_cliente`),
  INDEX `fk_pago_cliente_cuenta_cliente1_idx` (`idcuenta_cliente` ASC) ,
  CONSTRAINT `fk_pago_cliente_cuenta_cliente1`
    FOREIGN KEY (`idcuenta_cliente`)
    REFERENCES `mydb`.`cuenta_cliente` (`idcuenta_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = armscii8;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_pago_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_pago_cliente` (
  `idtipo_pago_cliente` INT NOT NULL AUTO_INCREMENT,
  `estado` ENUM('1', '0') NOT NULL,
  `idtipo_pago` INT NOT NULL,
  `idpago_cliente` INT NOT NULL,
  PRIMARY KEY (`idtipo_pago_cliente`),
  INDEX `fk_tipo_pago_cliente_tipo_pago1_idx` (`idtipo_pago` ASC) ,
  INDEX `fk_tipo_pago_cliente_pago_cliente1_idx` (`idpago_cliente` ASC) ,
  CONSTRAINT `fk_tipo_pago_cliente_tipo_pago1`
    FOREIGN KEY (`idtipo_pago`)
    REFERENCES `mydb`.`tipo_pago` (`idtipo_pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipo_pago_cliente_pago_cliente1`
    FOREIGN KEY (`idpago_cliente`)
    REFERENCES `mydb`.`pago_cliente` (`idpago_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = armscii8;


-- -----------------------------------------------------
-- Table `mydb`.`detalles_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`detalles_pago` (
  `iddetalles_pago` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(255) NOT NULL,
  `estado` ENUM('1', '0') NOT NULL,
  `idpago_cliente` INT NOT NULL,
  PRIMARY KEY (`iddetalles_pago`),
  INDEX `fk_detalles_pago_pago_cliente1_idx` (`idpago_cliente` ASC) ,
  CONSTRAINT `fk_detalles_pago_pago_cliente1`
    FOREIGN KEY (`idpago_cliente`)
    REFERENCES `mydb`.`pago_cliente` (`idpago_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = armscii8;


-- -----------------------------------------------------
-- Table `mydb`.`rol_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rol_usuario` (
  `idrol_usuario` INT NOT NULL AUTO_INCREMENT,
  `estado` ENUM('1', '0') NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  `idrol` INT NOT NULL,
  PRIMARY KEY (`idrol_usuario`),
  INDEX `fk_rol_usuario_usuario1_idx` (`usuario_idusuario` ASC) ,
  INDEX `fk_rol_usuario_rol1_idx` (`idrol` ASC) ,
  CONSTRAINT `fk_rol_usuario_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rol_usuario_rol1`
    FOREIGN KEY (`idrol`)
    REFERENCES `mydb`.`rol` (`idrol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`prom_lapso_prom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`prom_lapso_prom` (
  `idprom_lapso_prom` INT NOT NULL AUTO_INCREMENT,
  `estado` ENUM('1', '0') NOT NULL,
  `idpromocion` INT NOT NULL,
  `idlapso_promocion` INT NOT NULL,
  PRIMARY KEY (`idprom_lapso_prom`),
  INDEX `fk_prom_lapso_prom_promocion1_idx` (`idpromocion` ASC) ,
  INDEX `fk_prom_lapso_prom_lapso_promocion1_idx` (`idlapso_promocion` ASC) ,
  CONSTRAINT `fk_prom_lapso_prom_promocion1`
    FOREIGN KEY (`idpromocion`)
    REFERENCES `mydb`.`promocion` (`idpromocion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prom_lapso_prom_lapso_promocion1`
    FOREIGN KEY (`idlapso_promocion`)
    REFERENCES `mydb`.`lapso_promocion` (`idlapso_promocion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`persona_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`persona_usuario` (
  `idpersona_usuario` INT NOT NULL AUTO_INCREMENT,
  `estado` ENUM('1', '0') NOT NULL,
  `idpersona` INT NOT NULL,
  `idusuario` INT NOT NULL,
  PRIMARY KEY (`idpersona_usuario`),
  INDEX `fk_persona_usuario_persona1_idx` (`idpersona` ASC) ,
  INDEX `fk_persona_usuario_usuario1_idx` (`idusuario` ASC) ,
  CONSTRAINT `fk_persona_usuario_persona1`
    FOREIGN KEY (`idpersona`)
    REFERENCES `mydb`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_persona_usuario_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario_empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario_empleado` (
  `idusuario_empleado` INT NOT NULL AUTO_INCREMENT,
  `estado` ENUM('1', '0') NOT NULL,
  `idempleado` INT NOT NULL,
  `idusuario` INT NOT NULL,
  PRIMARY KEY (`idusuario_empleado`),
  INDEX `fk_usuario_empleado_empleado1_idx` (`idempleado` ASC) ,
  INDEX `fk_usuario_empleado_usuario1_idx` (`idusuario` ASC) ,
  CONSTRAINT `fk_usuario_empleado_empleado1`
    FOREIGN KEY (`idempleado`)
    REFERENCES `mydb`.`empleado` (`idempleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_empleado_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
