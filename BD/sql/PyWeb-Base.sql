SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `Base` ;
CREATE SCHEMA IF NOT EXISTS `Base` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `Base` ;

-- -----------------------------------------------------
-- Table `Base`.`Pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`Pais` ;

CREATE  TABLE IF NOT EXISTS `Base`.`Pais` (
  `idPais` INT NOT NULL AUTO_INCREMENT ,
  `Descripcion` VARCHAR(45) NOT NULL ,
  `Abreviacion` VARCHAR(3) NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  PRIMARY KEY (`idPais`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Base`.`Estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`Estado` ;

CREATE  TABLE IF NOT EXISTS `Base`.`Estado` (
  `idEstado` INT NOT NULL AUTO_INCREMENT ,
  `Descripcion` VARCHAR(45) NOT NULL ,
  `Abreviacion` VARCHAR(3) NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  `Pais_idPais` INT NOT NULL ,
  PRIMARY KEY (`idEstado`, `Pais_idPais`) ,
  CONSTRAINT `fk_Estado_Pais`
    FOREIGN KEY (`Pais_idPais` )
    REFERENCES `Base`.`Pais` (`idPais` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Estado_Pais_idx` ON `Base`.`Estado` (`Pais_idPais` ASC) ;


-- -----------------------------------------------------
-- Table `Base`.`CodigoArea`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`CodigoArea` ;

CREATE  TABLE IF NOT EXISTS `Base`.`CodigoArea` (
  `idCodigoArea` INT NOT NULL ,
  `Numero` VARCHAR(4) NOT NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  PRIMARY KEY (`idCodigoArea`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Base`.`Ciudad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`Ciudad` ;

CREATE  TABLE IF NOT EXISTS `Base`.`Ciudad` (
  `idCiudad` INT NOT NULL AUTO_INCREMENT ,
  `Descripcion` VARCHAR(45) NOT NULL ,
  `Abreviacion` VARCHAR(3) NULL ,
  `CodigoPostal` VARCHAR(7) NOT NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  `Estado_idEstado` INT NOT NULL ,
  `Estado_Pais_idPais` INT NOT NULL ,
  `CodigoArea_idCodigoArea` INT NOT NULL ,
  PRIMARY KEY (`idCiudad`, `Estado_idEstado`, `Estado_Pais_idPais`) ,
  CONSTRAINT `fk_Ciudad_Estado1`
    FOREIGN KEY (`Estado_idEstado` , `Estado_Pais_idPais` )
    REFERENCES `Base`.`Estado` (`idEstado` , `Pais_idPais` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ciudad_CodigoArea1`
    FOREIGN KEY (`CodigoArea_idCodigoArea` )
    REFERENCES `Base`.`CodigoArea` (`idCodigoArea` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Ciudad_Estado1_idx` ON `Base`.`Ciudad` (`Estado_idEstado` ASC, `Estado_Pais_idPais` ASC) ;

CREATE INDEX `fk_Ciudad_CodigoArea1_idx` ON `Base`.`Ciudad` (`CodigoArea_idCodigoArea` ASC) ;


-- -----------------------------------------------------
-- Table `Base`.`Company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`Company` ;

CREATE  TABLE IF NOT EXISTS `Base`.`Company` (
  `idCompany` INT NOT NULL AUTO_INCREMENT ,
  `Rif` VARCHAR(10) NOT NULL ,
  `Nombre1` VARCHAR(45) NOT NULL ,
  `Nombre2` VARCHAR(45) NULL ,
  `FechaRegistro` DATE NULL ,
  `Pais` INT NOT NULL ,
  `Estado` INT NOT NULL ,
  `Ciudad` INT NOT NULL ,
  `Direccion` VARCHAR(80) NOT NULL ,
  `CodigoArea_idCodigoArea` INT NOT NULL ,
  `Telefono` VARCHAR(7) NOT NULL ,
  `CodigoArea2` INT NULL ,
  `Telefono2` VARCHAR(7) NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  PRIMARY KEY (`idCompany`) ,
  CONSTRAINT `fk_Persona_Ciudad100`
    FOREIGN KEY (`Ciudad` , `Estado` , `Pais` )
    REFERENCES `Base`.`Ciudad` (`idCiudad` , `Estado_idEstado` , `Estado_Pais_idPais` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresa_CodigoArea10`
    FOREIGN KEY (`CodigoArea_idCodigoArea` )
    REFERENCES `Base`.`CodigoArea` (`idCodigoArea` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresa_CodigoArea20`
    FOREIGN KEY (`CodigoArea2` )
    REFERENCES `Base`.`CodigoArea` (`idCodigoArea` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Persona_Ciudad1_idx` ON `Base`.`Company` (`Ciudad` ASC, `Estado` ASC, `Pais` ASC) ;

CREATE INDEX `fk_Empresa_CodigoArea1_idx` ON `Base`.`Company` (`CodigoArea_idCodigoArea` ASC) ;

CREATE INDEX `fk_Empresa_CodigoArea2_idx` ON `Base`.`Company` (`CodigoArea2` ASC) ;


-- -----------------------------------------------------
-- Table `Base`.`Persona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`Persona` ;

CREATE  TABLE IF NOT EXISTS `Base`.`Persona` (
  `idPersona` INT NOT NULL AUTO_INCREMENT ,
  `CedulaRif` VARCHAR(10) NOT NULL ,
  `Nombres` VARCHAR(45) NOT NULL ,
  `Apellido1` VARCHAR(45) NOT NULL ,
  `Apellido2` VARCHAR(45) NULL ,
  `FechaNacimiento` DATE NOT NULL ,
  `Sexo` VARCHAR(1) NOT NULL ,
  `Nacionalidad` VARCHAR(1) NOT NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  `PaisNacimiento` INT NOT NULL ,
  `EstadoNacimiento` INT NOT NULL ,
  `CiudadNacimiento` INT NOT NULL ,
  `Company_idCompany` INT NOT NULL ,
  PRIMARY KEY (`idPersona`, `Company_idCompany`) ,
  CONSTRAINT `fk_Persona_Ciudad1`
    FOREIGN KEY (`CiudadNacimiento` , `EstadoNacimiento` , `PaisNacimiento` )
    REFERENCES `Base`.`Ciudad` (`idCiudad` , `Estado_idEstado` , `Estado_Pais_idPais` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Persona_Company1`
    FOREIGN KEY (`Company_idCompany` )
    REFERENCES `Base`.`Company` (`idCompany` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Persona_Ciudad1_idx` ON `Base`.`Persona` (`CiudadNacimiento` ASC, `EstadoNacimiento` ASC, `PaisNacimiento` ASC) ;

CREATE INDEX `fk_Persona_Company1_idx` ON `Base`.`Persona` (`Company_idCompany` ASC) ;


-- -----------------------------------------------------
-- Table `Base`.`ContactoPersona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`ContactoPersona` ;

CREATE  TABLE IF NOT EXISTS `Base`.`ContactoPersona` (
  `idContacto` INT NOT NULL AUTO_INCREMENT ,
  `Persona_idPersona` INT NOT NULL ,
  PRIMARY KEY (`idContacto`, `Persona_idPersona`) ,
  CONSTRAINT `fk_Contacto_Persona1`
    FOREIGN KEY (`Persona_idPersona` )
    REFERENCES `Base`.`Persona` (`idPersona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Contacto_Persona1_idx` ON `Base`.`ContactoPersona` (`Persona_idPersona` ASC) ;


-- -----------------------------------------------------
-- Table `Base`.`Empresa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`Empresa` ;

CREATE  TABLE IF NOT EXISTS `Base`.`Empresa` (
  `idEmpresa` INT NOT NULL AUTO_INCREMENT ,
  `Rif` VARCHAR(10) NOT NULL ,
  `Nombre1` VARCHAR(45) NOT NULL ,
  `Nombre2` VARCHAR(45) NULL ,
  `FechaRegistro` DATE NULL ,
  `Pais` INT NOT NULL ,
  `Estado` INT NOT NULL ,
  `Ciudad` INT NOT NULL ,
  `Direccion` VARCHAR(80) NOT NULL ,
  `CodigoArea_idCodigoArea` INT NOT NULL ,
  `Telefono` VARCHAR(7) NOT NULL ,
  `CodigoArea2` INT NULL ,
  `Telefono2` VARCHAR(7) NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  `PersonaContacto` INT NOT NULL ,
  `Company_idCompany` INT NOT NULL ,
  PRIMARY KEY (`idEmpresa`, `Company_idCompany`) ,
  CONSTRAINT `fk_Persona_Ciudad10`
    FOREIGN KEY (`Ciudad` , `Estado` , `Pais` )
    REFERENCES `Base`.`Ciudad` (`idCiudad` , `Estado_idEstado` , `Estado_Pais_idPais` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresa_CodigoArea1`
    FOREIGN KEY (`CodigoArea_idCodigoArea` )
    REFERENCES `Base`.`CodigoArea` (`idCodigoArea` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresa_CodigoArea2`
    FOREIGN KEY (`CodigoArea2` )
    REFERENCES `Base`.`CodigoArea` (`idCodigoArea` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresa_Persona1`
    FOREIGN KEY (`PersonaContacto` )
    REFERENCES `Base`.`Persona` (`idPersona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresa_Company1`
    FOREIGN KEY (`Company_idCompany` )
    REFERENCES `Base`.`Company` (`idCompany` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Persona_Ciudad1_idx` ON `Base`.`Empresa` (`Ciudad` ASC, `Estado` ASC, `Pais` ASC) ;

CREATE INDEX `fk_Empresa_CodigoArea1_idx` ON `Base`.`Empresa` (`CodigoArea_idCodigoArea` ASC) ;

CREATE INDEX `fk_Empresa_CodigoArea2_idx` ON `Base`.`Empresa` (`CodigoArea2` ASC) ;

CREATE INDEX `fk_Empresa_Persona1_idx` ON `Base`.`Empresa` (`PersonaContacto` ASC) ;

CREATE INDEX `fk_Empresa_Company1_idx` ON `Base`.`Empresa` (`Company_idCompany` ASC) ;


-- -----------------------------------------------------
-- Table `Base`.`TipoUsuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`TipoUsuario` ;

CREATE  TABLE IF NOT EXISTS `Base`.`TipoUsuario` (
  `idTipoUsuario` INT NOT NULL ,
  `Descripcion` VARCHAR(45) NOT NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  PRIMARY KEY (`idTipoUsuario`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Base`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`Usuario` ;

CREATE  TABLE IF NOT EXISTS `Base`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(30) NOT NULL ,
  `clave` VARCHAR(20) NOT NULL ,
  `TipoUsuario_idTipoUsuario` INT NOT NULL ,
  `Persona_idPersona` INT NULL ,
  `Empresa_idEmpresa` INT NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  PRIMARY KEY (`idUsuario`) ,
  CONSTRAINT `fk_Usuario_Persona1`
    FOREIGN KEY (`Persona_idPersona` )
    REFERENCES `Base`.`Persona` (`idPersona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Empresa1`
    FOREIGN KEY (`Empresa_idEmpresa` )
    REFERENCES `Base`.`Empresa` (`idEmpresa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_TipoUsuario1`
    FOREIGN KEY (`TipoUsuario_idTipoUsuario` )
    REFERENCES `Base`.`TipoUsuario` (`idTipoUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuario_Persona1_idx` ON `Base`.`Usuario` (`Persona_idPersona` ASC) ;

CREATE INDEX `fk_Usuario_Empresa1_idx` ON `Base`.`Usuario` (`Empresa_idEmpresa` ASC) ;

CREATE INDEX `fk_Usuario_TipoUsuario1_idx` ON `Base`.`Usuario` (`TipoUsuario_idTipoUsuario` ASC) ;


-- -----------------------------------------------------
-- Table `Base`.`TipoContacto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`TipoContacto` ;

CREATE  TABLE IF NOT EXISTS `Base`.`TipoContacto` (
  `idTipoContacto` INT NOT NULL ,
  `Descripcion` VARCHAR(45) NOT NULL ,
  `Nivel` VARCHAR(1) NOT NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  PRIMARY KEY (`idTipoContacto`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Base`.`DetalleContacto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`DetalleContacto` ;

CREATE  TABLE IF NOT EXISTS `Base`.`DetalleContacto` (
  `idDetalleContacto` INT NOT NULL AUTO_INCREMENT ,
  `Contacto_idContacto` INT NOT NULL ,
  `TipoContacto_idTipoContacto` INT NOT NULL ,
  `Descripcion` VARCHAR(20) NOT NULL ,
  `Direccion` VARCHAR(80) NULL ,
  `CodigoArea_idCodigoArea` INT NULL ,
  `Telefono` VARCHAR(7) NULL ,
  `Ciudad_Estado_Pais_idPais` INT NULL ,
  `Ciudad_Estado_idEstado` INT NULL ,
  `Ciudad_idCiudad` INT NULL ,
  PRIMARY KEY (`idDetalleContacto`, `Contacto_idContacto`) ,
  CONSTRAINT `fk_DetalleContacto_Contacto1`
    FOREIGN KEY (`Contacto_idContacto` )
    REFERENCES `Base`.`ContactoPersona` (`idContacto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DetalleContacto_TipoContacto1`
    FOREIGN KEY (`TipoContacto_idTipoContacto` )
    REFERENCES `Base`.`TipoContacto` (`idTipoContacto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DetalleContacto_Ciudad1`
    FOREIGN KEY (`Ciudad_idCiudad` , `Ciudad_Estado_idEstado` , `Ciudad_Estado_Pais_idPais` )
    REFERENCES `Base`.`Ciudad` (`idCiudad` , `Estado_idEstado` , `Estado_Pais_idPais` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DetalleContacto_CodigoArea1`
    FOREIGN KEY (`CodigoArea_idCodigoArea` )
    REFERENCES `Base`.`CodigoArea` (`idCodigoArea` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_DetalleContacto_Contacto1_idx` ON `Base`.`DetalleContacto` (`Contacto_idContacto` ASC) ;

CREATE INDEX `fk_DetalleContacto_TipoContacto1_idx` ON `Base`.`DetalleContacto` (`TipoContacto_idTipoContacto` ASC) ;

CREATE INDEX `fk_DetalleContacto_Ciudad1_idx` ON `Base`.`DetalleContacto` (`Ciudad_idCiudad` ASC, `Ciudad_Estado_idEstado` ASC, `Ciudad_Estado_Pais_idPais` ASC) ;

CREATE INDEX `fk_DetalleContacto_CodigoArea1_idx` ON `Base`.`DetalleContacto` (`CodigoArea_idCodigoArea` ASC) ;


-- -----------------------------------------------------
-- Table `Base`.`Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`Roles` ;

CREATE  TABLE IF NOT EXISTS `Base`.`Roles` (
  `idRoles` INT NOT NULL AUTO_INCREMENT ,
  `Descripcion` VARCHAR(40) NOT NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  PRIMARY KEY (`idRoles`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Base`.`Modulo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`Modulo` ;

CREATE  TABLE IF NOT EXISTS `Base`.`Modulo` (
  `idModulo` INT NOT NULL ,
  `Descripcion` VARCHAR(45) NOT NULL ,
  `Abreviacion` VARCHAR(4) NOT NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  PRIMARY KEY (`idModulo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Base`.`ObjetoAutorizacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`ObjetoAutorizacion` ;

CREATE  TABLE IF NOT EXISTS `Base`.`ObjetoAutorizacion` (
  `idObjetoAutorizacion` INT NOT NULL AUTO_INCREMENT ,
  `Modulo_idModulo` INT NOT NULL ,
  PRIMARY KEY (`idObjetoAutorizacion`) ,
  CONSTRAINT `fk_Permisologia_Modulo1`
    FOREIGN KEY (`Modulo_idModulo` )
    REFERENCES `Base`.`Modulo` (`idModulo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Permisologia_Modulo1_idx` ON `Base`.`ObjetoAutorizacion` (`Modulo_idModulo` ASC) ;


-- -----------------------------------------------------
-- Table `Base`.`Company_has_Modulo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`Company_has_Modulo` ;

CREATE  TABLE IF NOT EXISTS `Base`.`Company_has_Modulo` (
  `Company_idCompany` INT NOT NULL ,
  `Modulo_idModulo` INT NOT NULL ,
  PRIMARY KEY (`Company_idCompany`, `Modulo_idModulo`) ,
  CONSTRAINT `fk_Company_has_Modulo_Company1`
    FOREIGN KEY (`Company_idCompany` )
    REFERENCES `Base`.`Company` (`idCompany` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Company_has_Modulo_Modulo1`
    FOREIGN KEY (`Modulo_idModulo` )
    REFERENCES `Base`.`Modulo` (`idModulo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Company_has_Modulo_Modulo1_idx` ON `Base`.`Company_has_Modulo` (`Modulo_idModulo` ASC) ;

CREATE INDEX `fk_Company_has_Modulo_Company1_idx` ON `Base`.`Company_has_Modulo` (`Company_idCompany` ASC) ;


-- -----------------------------------------------------
-- Table `Base`.`Autorizacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`Autorizacion` ;

CREATE  TABLE IF NOT EXISTS `Base`.`Autorizacion` (
  `idAutorizacion` INT NOT NULL ,
  `Descripcion` VARCHAR(45) NOT NULL ,
  `Abreviacion` VARCHAR(1) NOT NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  PRIMARY KEY (`idAutorizacion`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Base`.`ObjetoAutorizacion_has_Autorizacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`ObjetoAutorizacion_has_Autorizacion` ;

CREATE  TABLE IF NOT EXISTS `Base`.`ObjetoAutorizacion_has_Autorizacion` (
  `ObjetoAutorizacion_idObjetoAutorizacion` INT NOT NULL ,
  `Autorizacion_idAutorizacion` INT NOT NULL ,
  PRIMARY KEY (`ObjetoAutorizacion_idObjetoAutorizacion`, `Autorizacion_idAutorizacion`) ,
  CONSTRAINT `fk_ObjetoAutorizacion_has_Autorizacion_ObjetoAutorizacion1`
    FOREIGN KEY (`ObjetoAutorizacion_idObjetoAutorizacion` )
    REFERENCES `Base`.`ObjetoAutorizacion` (`idObjetoAutorizacion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ObjetoAutorizacion_has_Autorizacion_Autorizacion1`
    FOREIGN KEY (`Autorizacion_idAutorizacion` )
    REFERENCES `Base`.`Autorizacion` (`idAutorizacion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_ObjetoAutorizacion_has_Autorizacion_Autorizacion1_idx` ON `Base`.`ObjetoAutorizacion_has_Autorizacion` (`Autorizacion_idAutorizacion` ASC) ;

CREATE INDEX `fk_ObjetoAutorizacion_has_Autorizacion_ObjetoAutorizacion1_idx` ON `Base`.`ObjetoAutorizacion_has_Autorizacion` (`ObjetoAutorizacion_idObjetoAutorizacion` ASC) ;


-- -----------------------------------------------------
-- Table `Base`.`Roles_has_ObjetoAutorizacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`Roles_has_ObjetoAutorizacion` ;

CREATE  TABLE IF NOT EXISTS `Base`.`Roles_has_ObjetoAutorizacion` (
  `Roles_idRoles` INT NOT NULL ,
  `ObjetoAutorizacion_idObjetoAutorizacion` INT NOT NULL ,
  PRIMARY KEY (`Roles_idRoles`, `ObjetoAutorizacion_idObjetoAutorizacion`) ,
  CONSTRAINT `fk_Roles_has_ObjetoAutorizacion_Roles1`
    FOREIGN KEY (`Roles_idRoles` )
    REFERENCES `Base`.`Roles` (`idRoles` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Roles_has_ObjetoAutorizacion_ObjetoAutorizacion1`
    FOREIGN KEY (`ObjetoAutorizacion_idObjetoAutorizacion` )
    REFERENCES `Base`.`ObjetoAutorizacion` (`idObjetoAutorizacion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Roles_has_ObjetoAutorizacion_ObjetoAutorizacion1_idx` ON `Base`.`Roles_has_ObjetoAutorizacion` (`ObjetoAutorizacion_idObjetoAutorizacion` ASC) ;

CREATE INDEX `fk_Roles_has_ObjetoAutorizacion_Roles1_idx` ON `Base`.`Roles_has_ObjetoAutorizacion` (`Roles_idRoles` ASC) ;


-- -----------------------------------------------------
-- Table `Base`.`Usuario_has_Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Base`.`Usuario_has_Roles` ;

CREATE  TABLE IF NOT EXISTS `Base`.`Usuario_has_Roles` (
  `Usuario_idUsuario` INT NOT NULL ,
  `Roles_idRoles` INT NOT NULL ,
  PRIMARY KEY (`Usuario_idUsuario`, `Roles_idRoles`) ,
  CONSTRAINT `fk_Usuario_has_Roles_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` )
    REFERENCES `Base`.`Usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Roles_Roles1`
    FOREIGN KEY (`Roles_idRoles` )
    REFERENCES `Base`.`Roles` (`idRoles` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuario_has_Roles_Roles1_idx` ON `Base`.`Usuario_has_Roles` (`Roles_idRoles` ASC) ;

CREATE INDEX `fk_Usuario_has_Roles_Usuario1_idx` ON `Base`.`Usuario_has_Roles` (`Usuario_idUsuario` ASC) ;

USE `Base` ;

SET SQL_MODE = '';
GRANT USAGE ON *.* TO userDBA;
 DROP USER userDBA;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'userDBA' IDENTIFIED BY 'passwordDBA.12345';

GRANT ALL ON `Base`.* TO 'userDBA';
GRANT SELECT ON TABLE `Base`.* TO 'userDBA';
GRANT SELECT, INSERT, TRIGGER ON TABLE `Base`.* TO 'userDBA';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `Base`.* TO 'userDBA';
GRANT EXECUTE ON ROUTINE `Base`.* TO 'userDBA';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Base`.`TipoUsuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `Base`;
INSERT INTO `Base`.`TipoUsuario` (`idTipoUsuario`, `Descripcion`, `Status`) VALUES (0000001, 'Administrador', 'A');

COMMIT;

-- -----------------------------------------------------
-- Data for table `Base`.`Usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `Base`;
INSERT INTO `Base`.`Usuario` (`idUsuario`, `nombre`, `clave`, `TipoUsuario_idTipoUsuario`, `Persona_idPersona`, `Empresa_idEmpresa`, `Status`) VALUES (00000000001, 'userBase', 'claveBASE.12345', 000001, NULL, NULL, 'A');

COMMIT;
