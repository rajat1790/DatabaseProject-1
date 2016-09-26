CREATE TABLE `rhljain08-db`.`movies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `year` INT NULL,
  `duration` INT NULL,
  `certificate` VARCHAR(10) NULL,
  `summary` VARCHAR(500) NULL,
  `director` VARCHAR(100) NULL,
  `imdb_rating` DECIMAL(1,1) NULL,
  `poster` BLOB NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC));