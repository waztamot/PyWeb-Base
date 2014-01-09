SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `Pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pais` ;

CREATE  TABLE IF NOT EXISTS `Pais` (
  `idPais` INT NOT NULL AUTO_INCREMENT ,
  `Descripcion` VARCHAR(45) NOT NULL ,
  `Abreviacion` VARCHAR(3) NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  PRIMARY KEY (`idPais`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Estado` ;

CREATE  TABLE IF NOT EXISTS `Estado` (
  `idEstado` INT NOT NULL AUTO_INCREMENT ,
  `Descripcion` VARCHAR(45) NOT NULL ,
  `Abreviacion` VARCHAR(3) NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  `Pais_idPais` INT NOT NULL ,
  PRIMARY KEY (`idEstado`, `Pais_idPais`) ,
  CONSTRAINT `fk_Estado_Pais`
    FOREIGN KEY (`Pais_idPais` )
    REFERENCES `Pais` (`idPais` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Estado_Pais_idx` ON `Estado` (`Pais_idPais` ASC) ;


-- -----------------------------------------------------
-- Table `CodigoArea`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CodigoArea` ;

CREATE  TABLE IF NOT EXISTS `CodigoArea` (
  `idCodigoArea` INT NOT NULL ,
  `Numero` VARCHAR(4) NOT NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  PRIMARY KEY (`idCodigoArea`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ciudad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ciudad` ;

CREATE  TABLE IF NOT EXISTS `Ciudad` (
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
    REFERENCES `Estado` (`idEstado` , `Pais_idPais` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ciudad_CodigoArea1`
    FOREIGN KEY (`CodigoArea_idCodigoArea` )
    REFERENCES `CodigoArea` (`idCodigoArea` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Ciudad_Estado1_idx` ON `Ciudad` (`Estado_idEstado` ASC, `Estado_Pais_idPais` ASC) ;

CREATE INDEX `fk_Ciudad_CodigoArea1_idx` ON `Ciudad` (`CodigoArea_idCodigoArea` ASC) ;


-- -----------------------------------------------------
-- Table `Company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Company` ;

CREATE  TABLE IF NOT EXISTS `Company` (
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
    REFERENCES `Ciudad` (`idCiudad` , `Estado_idEstado` , `Estado_Pais_idPais` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresa_CodigoArea10`
    FOREIGN KEY (`CodigoArea_idCodigoArea` )
    REFERENCES `CodigoArea` (`idCodigoArea` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresa_CodigoArea20`
    FOREIGN KEY (`CodigoArea2` )
    REFERENCES `CodigoArea` (`idCodigoArea` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Persona_Ciudad1_idx` ON `Company` (`Ciudad` ASC, `Estado` ASC, `Pais` ASC) ;

CREATE INDEX `fk_Empresa_CodigoArea1_idx` ON `Company` (`CodigoArea_idCodigoArea` ASC) ;

CREATE INDEX `fk_Empresa_CodigoArea2_idx` ON `Company` (`CodigoArea2` ASC) ;


-- -----------------------------------------------------
-- Table `Persona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Persona` ;

CREATE  TABLE IF NOT EXISTS `Persona` (
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
    REFERENCES `Ciudad` (`idCiudad` , `Estado_idEstado` , `Estado_Pais_idPais` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Persona_Company1`
    FOREIGN KEY (`Company_idCompany` )
    REFERENCES `Company` (`idCompany` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Persona_Ciudad1_idx` ON `Persona` (`CiudadNacimiento` ASC, `EstadoNacimiento` ASC, `PaisNacimiento` ASC) ;

CREATE INDEX `fk_Persona_Company1_idx` ON `Persona` (`Company_idCompany` ASC) ;


-- -----------------------------------------------------
-- Table `ContactoPersona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ContactoPersona` ;

CREATE  TABLE IF NOT EXISTS `ContactoPersona` (
  `idContacto` INT NOT NULL AUTO_INCREMENT ,
  `Persona_idPersona` INT NOT NULL ,
  PRIMARY KEY (`idContacto`, `Persona_idPersona`) ,
  CONSTRAINT `fk_Contacto_Persona1`
    FOREIGN KEY (`Persona_idPersona` )
    REFERENCES `Persona` (`idPersona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Contacto_Persona1_idx` ON `ContactoPersona` (`Persona_idPersona` ASC) ;


-- -----------------------------------------------------
-- Table `Empresa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Empresa` ;

CREATE  TABLE IF NOT EXISTS `Empresa` (
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
    REFERENCES `Ciudad` (`idCiudad` , `Estado_idEstado` , `Estado_Pais_idPais` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresa_CodigoArea1`
    FOREIGN KEY (`CodigoArea_idCodigoArea` )
    REFERENCES `CodigoArea` (`idCodigoArea` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresa_CodigoArea2`
    FOREIGN KEY (`CodigoArea2` )
    REFERENCES `CodigoArea` (`idCodigoArea` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresa_Persona1`
    FOREIGN KEY (`PersonaContacto` )
    REFERENCES `Persona` (`idPersona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresa_Company1`
    FOREIGN KEY (`Company_idCompany` )
    REFERENCES `Company` (`idCompany` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Persona_Ciudad1_idx` ON `Empresa` (`Ciudad` ASC, `Estado` ASC, `Pais` ASC) ;

CREATE INDEX `fk_Empresa_CodigoArea1_idx` ON `Empresa` (`CodigoArea_idCodigoArea` ASC) ;

CREATE INDEX `fk_Empresa_CodigoArea2_idx` ON `Empresa` (`CodigoArea2` ASC) ;

CREATE INDEX `fk_Empresa_Persona1_idx` ON `Empresa` (`PersonaContacto` ASC) ;

CREATE INDEX `fk_Empresa_Company1_idx` ON `Empresa` (`Company_idCompany` ASC) ;


-- -----------------------------------------------------
-- Table `TipoUsuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TipoUsuario` ;

CREATE  TABLE IF NOT EXISTS `TipoUsuario` (
  `idTipoUsuario` INT NOT NULL ,
  `Descripcion` VARCHAR(45) NOT NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  PRIMARY KEY (`idTipoUsuario`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Usuario` ;

CREATE  TABLE IF NOT EXISTS `Usuario` (
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
    REFERENCES `Persona` (`idPersona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Empresa1`
    FOREIGN KEY (`Empresa_idEmpresa` )
    REFERENCES `Empresa` (`idEmpresa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_TipoUsuario1`
    FOREIGN KEY (`TipoUsuario_idTipoUsuario` )
    REFERENCES `TipoUsuario` (`idTipoUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuario_Persona1_idx` ON `Usuario` (`Persona_idPersona` ASC) ;

CREATE INDEX `fk_Usuario_Empresa1_idx` ON `Usuario` (`Empresa_idEmpresa` ASC) ;

CREATE INDEX `fk_Usuario_TipoUsuario1_idx` ON `Usuario` (`TipoUsuario_idTipoUsuario` ASC) ;


-- -----------------------------------------------------
-- Table `TipoContacto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TipoContacto` ;

CREATE  TABLE IF NOT EXISTS `TipoContacto` (
  `idTipoContacto` INT NOT NULL ,
  `Descripcion` VARCHAR(45) NOT NULL ,
  `Nivel` VARCHAR(1) NOT NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  PRIMARY KEY (`idTipoContacto`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DetalleContacto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DetalleContacto` ;

CREATE  TABLE IF NOT EXISTS `DetalleContacto` (
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
    REFERENCES `ContactoPersona` (`idContacto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DetalleContacto_TipoContacto1`
    FOREIGN KEY (`TipoContacto_idTipoContacto` )
    REFERENCES `TipoContacto` (`idTipoContacto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DetalleContacto_Ciudad1`
    FOREIGN KEY (`Ciudad_idCiudad` , `Ciudad_Estado_idEstado` , `Ciudad_Estado_Pais_idPais` )
    REFERENCES `Ciudad` (`idCiudad` , `Estado_idEstado` , `Estado_Pais_idPais` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DetalleContacto_CodigoArea1`
    FOREIGN KEY (`CodigoArea_idCodigoArea` )
    REFERENCES `CodigoArea` (`idCodigoArea` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_DetalleContacto_Contacto1_idx` ON `DetalleContacto` (`Contacto_idContacto` ASC) ;

CREATE INDEX `fk_DetalleContacto_TipoContacto1_idx` ON `DetalleContacto` (`TipoContacto_idTipoContacto` ASC) ;

CREATE INDEX `fk_DetalleContacto_Ciudad1_idx` ON `DetalleContacto` (`Ciudad_idCiudad` ASC, `Ciudad_Estado_idEstado` ASC, `Ciudad_Estado_Pais_idPais` ASC) ;

CREATE INDEX `fk_DetalleContacto_CodigoArea1_idx` ON `DetalleContacto` (`CodigoArea_idCodigoArea` ASC) ;


-- -----------------------------------------------------
-- Table `Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Roles` ;

CREATE  TABLE IF NOT EXISTS `Roles` (
  `idRoles` INT NOT NULL AUTO_INCREMENT ,
  `Descripcion` VARCHAR(40) NOT NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  PRIMARY KEY (`idRoles`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Modulo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Modulo` ;

CREATE  TABLE IF NOT EXISTS `Modulo` (
  `idModulo` INT NOT NULL ,
  `Descripcion` VARCHAR(45) NOT NULL ,
  `Abreviacion` VARCHAR(4) NOT NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  PRIMARY KEY (`idModulo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ObjetoAutorizacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ObjetoAutorizacion` ;

CREATE  TABLE IF NOT EXISTS `ObjetoAutorizacion` (
  `idObjetoAutorizacion` INT NOT NULL AUTO_INCREMENT ,
  `Modulo_idModulo` INT NOT NULL ,
  PRIMARY KEY (`idObjetoAutorizacion`) ,
  CONSTRAINT `fk_Permisologia_Modulo1`
    FOREIGN KEY (`Modulo_idModulo` )
    REFERENCES `Modulo` (`idModulo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Permisologia_Modulo1_idx` ON `ObjetoAutorizacion` (`Modulo_idModulo` ASC) ;


-- -----------------------------------------------------
-- Table `Company_has_Modulo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Company_has_Modulo` ;

CREATE  TABLE IF NOT EXISTS `Company_has_Modulo` (
  `Company_idCompany` INT NOT NULL ,
  `Modulo_idModulo` INT NOT NULL ,
  PRIMARY KEY (`Company_idCompany`, `Modulo_idModulo`) ,
  CONSTRAINT `fk_Company_has_Modulo_Company1`
    FOREIGN KEY (`Company_idCompany` )
    REFERENCES `Company` (`idCompany` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Company_has_Modulo_Modulo1`
    FOREIGN KEY (`Modulo_idModulo` )
    REFERENCES `Modulo` (`idModulo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Company_has_Modulo_Modulo1_idx` ON `Company_has_Modulo` (`Modulo_idModulo` ASC) ;

CREATE INDEX `fk_Company_has_Modulo_Company1_idx` ON `Company_has_Modulo` (`Company_idCompany` ASC) ;


-- -----------------------------------------------------
-- Table `Autorizacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Autorizacion` ;

CREATE  TABLE IF NOT EXISTS `Autorizacion` (
  `idAutorizacion` INT NOT NULL ,
  `Descripcion` VARCHAR(45) NOT NULL ,
  `Abreviacion` VARCHAR(1) NOT NULL ,
  `Status` VARCHAR(1) NOT NULL ,
  PRIMARY KEY (`idAutorizacion`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ObjetoAutorizacion_has_Autorizacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ObjetoAutorizacion_has_Autorizacion` ;

CREATE  TABLE IF NOT EXISTS `ObjetoAutorizacion_has_Autorizacion` (
  `ObjetoAutorizacion_idObjetoAutorizacion` INT NOT NULL ,
  `Autorizacion_idAutorizacion` INT NOT NULL ,
  PRIMARY KEY (`ObjetoAutorizacion_idObjetoAutorizacion`, `Autorizacion_idAutorizacion`) ,
  CONSTRAINT `fk_ObjetoAutorizacion_has_Autorizacion_ObjetoAutorizacion1`
    FOREIGN KEY (`ObjetoAutorizacion_idObjetoAutorizacion` )
    REFERENCES `ObjetoAutorizacion` (`idObjetoAutorizacion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ObjetoAutorizacion_has_Autorizacion_Autorizacion1`
    FOREIGN KEY (`Autorizacion_idAutorizacion` )
    REFERENCES `Autorizacion` (`idAutorizacion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_ObjetoAutorizacion_has_Autorizacion_Autorizacion1_idx` ON `ObjetoAutorizacion_has_Autorizacion` (`Autorizacion_idAutorizacion` ASC) ;

CREATE INDEX `fk_ObjetoAutorizacion_has_Autorizacion_ObjetoAutorizacion1_idx` ON `ObjetoAutorizacion_has_Autorizacion` (`ObjetoAutorizacion_idObjetoAutorizacion` ASC) ;


-- -----------------------------------------------------
-- Table `Roles_has_ObjetoAutorizacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Roles_has_ObjetoAutorizacion` ;

CREATE  TABLE IF NOT EXISTS `Roles_has_ObjetoAutorizacion` (
  `Roles_idRoles` INT NOT NULL ,
  `ObjetoAutorizacion_idObjetoAutorizacion` INT NOT NULL ,
  PRIMARY KEY (`Roles_idRoles`, `ObjetoAutorizacion_idObjetoAutorizacion`) ,
  CONSTRAINT `fk_Roles_has_ObjetoAutorizacion_Roles1`
    FOREIGN KEY (`Roles_idRoles` )
    REFERENCES `Roles` (`idRoles` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Roles_has_ObjetoAutorizacion_ObjetoAutorizacion1`
    FOREIGN KEY (`ObjetoAutorizacion_idObjetoAutorizacion` )
    REFERENCES `ObjetoAutorizacion` (`idObjetoAutorizacion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Roles_has_ObjetoAutorizacion_ObjetoAutorizacion1_idx` ON `Roles_has_ObjetoAutorizacion` (`ObjetoAutorizacion_idObjetoAutorizacion` ASC) ;

CREATE INDEX `fk_Roles_has_ObjetoAutorizacion_Roles1_idx` ON `Roles_has_ObjetoAutorizacion` (`Roles_idRoles` ASC) ;


-- -----------------------------------------------------
-- Table `Usuario_has_Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Usuario_has_Roles` ;

CREATE  TABLE IF NOT EXISTS `Usuario_has_Roles` (
  `Usuario_idUsuario` INT NOT NULL ,
  `Roles_idRoles` INT NOT NULL ,
  PRIMARY KEY (`Usuario_idUsuario`, `Roles_idRoles`) ,
  CONSTRAINT `fk_Usuario_has_Roles_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` )
    REFERENCES `Usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Roles_Roles1`
    FOREIGN KEY (`Roles_idRoles` )
    REFERENCES `Roles` (`idRoles` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuario_has_Roles_Roles1_idx` ON `Usuario_has_Roles` (`Roles_idRoles` ASC) ;

CREATE INDEX `fk_Usuario_has_Roles_Usuario1_idx` ON `Usuario_has_Roles` (`Usuario_idUsuario` ASC) ;


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
-- Data for table `TipoUsuario`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `TipoUsuario` (`idTipoUsuario`, `Descripcion`, `Status`) VALUES (0000001, 'Administrador', 'A');

COMMIT;

-- -----------------------------------------------------
-- Data for table `Usuario`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Usuario` (`idUsuario`, `nombre`, `clave`, `TipoUsuario_idTipoUsuario`, `Persona_idPersona`, `Empresa_idEmpresa`, `Status`) VALUES (00000000001, 'userBase', 'claveBASE.12345', 000001, NULL, NULL, 'A');

COMMIT;
