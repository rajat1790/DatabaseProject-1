
CREATE TABLE `rhljain08-db`.`movie_actors` (
 `movie_id` INT NOT NULL,
 `actor_id` INT NOT NULL,
 PRIMARY KEY (`movie_id`, `actor_id`),
 INDEX `actor_id_idx` (`actor_id` ASC),
 FOREIGN KEY (`movie_id`)
 REFERENCES `rhljain08-db`.`movies` (`id`)
 ON DELETE CASCADE
 ON UPDATE CASCADE,
 FOREIGN KEY (`actor_id`)
 REFERENCES `rhljain08-db`.`actors` (`actor_id`)
 ON DELETE CASCADE
 ON UPDATE CASCADE)