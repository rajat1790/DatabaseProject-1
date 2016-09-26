
CREATE TABLE `rhljain08-db`.`user_genre_choices` (
 `user_id` INT NOT NULL,
 `genre_id` INT NOT NULL,
 PRIMARY KEY (`user_id`, `genre_id`),
 INDEX `genre_id_idx` (`genre_id` ASC),
 FOREIGN KEY (`user_id`)
 REFERENCES `rhljain08-db`.`user` (`id`)
 ON DELETE CASCADE
 ON UPDATE CASCADE,
 FOREIGN KEY (`genre_id`)
 REFERENCES `rhljain08-db`.`genre` (`genre_id`)
 ON DELETE CASCADE
 ON UPDATE CASCADE)