CREATE TABLE `rhljain08-db`.`movie_genres` (
  `movie_id` INT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`movie_id`, `genre_id`),
  INDEX `genre_id_idx` (`genre_id` ASC),
  CONSTRAINT `movie_id`
    FOREIGN KEY (`movie_id`)
    REFERENCES `rhljain08-db`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `genre_id`
    FOREIGN KEY (`genre_id`)
    REFERENCES `rhljain08-db`.`genre` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);