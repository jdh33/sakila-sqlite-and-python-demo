-- 
-- Adressing first normal form violation of the special_features column in the film table.
-- Below is how the tables could have been defined in the schema.
-- 

--
-- Table structure for table film
--

-- CREATE TABLE film (
--   film_id int NOT NULL,
--   title VARCHAR(255) NOT NULL,
--   description BLOB SUB_TYPE TEXT DEFAULT NULL,
--   release_year VARCHAR(4) DEFAULT NULL,
--   language_id SMALLINT NOT NULL,
--   original_language_id SMALLINT DEFAULT NULL,
--   rental_duration SMALLINT  DEFAULT 3 NOT NULL,
--   rental_rate DECIMAL(4,2) DEFAULT 4.99 NOT NULL,
--   length SMALLINT DEFAULT NULL,
--   replacement_cost DECIMAL(5,2) DEFAULT 19.99 NOT NULL,
--   rating VARCHAR(10) DEFAULT 'G',
--   last_update TIMESTAMP NOT NULL,
--   PRIMARY KEY  (film_id),
--   CONSTRAINT CHECK_special_rating CHECK(rating in ('G','PG','PG-13','R','NC-17')),
--   CONSTRAINT fk_film_language FOREIGN KEY (language_id) REFERENCES language (language_id) ,
--   CONSTRAINT fk_film_language_original FOREIGN KEY (original_language_id) REFERENCES language (language_id)
-- )
-- ;
-- CREATE  INDEX idx_fk_language_id ON film(language_id)
-- ;
-- CREATE  INDEX idx_fk_original_language_id ON film(original_language_id)
-- ;

-- CREATE TRIGGER film_trigger_ai AFTER INSERT ON film
--  BEGIN
--   UPDATE film SET last_update = DATETIME('NOW')  WHERE rowid = new.rowid;
--  END
-- ;
 
-- CREATE TRIGGER film_trigger_au AFTER UPDATE ON film
--  BEGIN
--   UPDATE film SET last_update = DATETIME('NOW')  WHERE rowid = new.rowid;
--  END
-- ;

--
-- Table structure for table special_feature
--

-- CREATE TABLE special_feature (
--   special_feature_id SMALLINT NOT NULL,
--   name VARCHAR(25) NOT NULL,
--   last_update TIMESTAMP NOT NULL,
--   PRIMARY KEY  (special_feature_id),
--   CONSTRAINT CHECK_name CHECK(name like '%Trailers%' or
--                                                            name like '%Commentaries%' or
--                                                            name like '%Deleted Scenes%' or
--                                                            name like '%Behind the Scenes%'),
-- );

-- CREATE TRIGGER special_feature_trigger_ai AFTER INSERT ON special_feature
--  BEGIN
--   UPDATE special_feature SET last_update = DATETIME('NOW')  WHERE rowid = new.rowid;
--  END
-- ;
 
-- CREATE TRIGGER special_feature_trigger_au AFTER UPDATE ON special_feature
--  BEGIN
--   UPDATE special_feature SET last_update = DATETIME('NOW')  WHERE rowid = new.rowid;
--  END
-- ;

--
-- Table structure for table film_special_feature
--

-- CREATE TABLE film_special_feature (
--   film_id INT NOT NULL,
--   special_feature_id SMALLINT  NOT NULL,
--   last_update TIMESTAMP NOT NULL,
--   PRIMARY KEY (film_id, special_feature_id),
--   CONSTRAINT fk_film_special_feature_film FOREIGN KEY (film_id) REFERENCES film (film_id) ON DELETE NO ACTION ON UPDATE CASCADE,
--   CONSTRAINT fk_film_special_feature_special_feature FOREIGN KEY (special_feature_id) REFERENCES special_feature (special_feature_id) ON DELETE NO ACTION ON UPDATE CASCADE
-- )
-- ;

-- CREATE  INDEX idx_fk_film_special_feature_film ON film_special_feature(film_id)
-- ;

-- CREATE  INDEX idx_fk_film_special_feature_special_feature ON film_special_feature(special_feature_id)
-- ;

-- CREATE TRIGGER film_special_feature_trigger_ai AFTER INSERT ON film_special_feature
--  BEGIN
--   UPDATE film_special_feature SET last_update = DATETIME('NOW')  WHERE rowid = new.rowid;
--  END
-- ;
 
-- CREATE TRIGGER film_special_feature_trigger_au AFTER UPDATE ON film_special_feature
--  BEGIN
--   UPDATE film_special_feature SET last_update = DATETIME('NOW')  WHERE rowid = new.rowid;
--  END
-- ;