CREATE TABLE `rhljain08-db`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `dob` DATE NULL,
  `pic` BLOB NULL,
  PRIMARY KEY (`id`));