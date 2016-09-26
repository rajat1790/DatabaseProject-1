CREATE TABLE `rhljain08-db`.`comments` (
  `movie_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `comment` VARCHAR(500) NULL,
  `time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`movie_id`, `user_id`),
  INDEX `user_id_idx` (`user_id` ASC),
    FOREIGN KEY (`movie_id`)
    REFERENCES `rhljain08-db`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`user_id`)
    REFERENCES `rhljain08-db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
