CREATE TABLE `rhljain08-db`.`user_movie_list` (
  `user_id` INT NOT NULL,
  `movie_id` INT NULL,
  `wish_or_watch` TINYINT(1) NULL COMMENT 'Set to 1 if watched.',
  `rating` INT NULL,
  PRIMARY KEY (`user_id`, `movie_id`),
  INDEX `movie_id_idx` (`movie_id` ASC),
    FOREIGN KEY (`user_id`)
    REFERENCES `rhljain08-db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`movie_id`)
    REFERENCES `rhljain08-db`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);