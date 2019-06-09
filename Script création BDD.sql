CREATE DATABASE IF NOT EXISTS `P6_db` DEFAULT CHARACTER SET utf8 ;
USE `P6_db` ;

-- -----------------------------------------------------
-- Table `P6_db`.`Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P6_db`.`Status` (
  `id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `P6_db`.`Addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P6_db`.`Addresses` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NULL,
  `street_number` SMALLINT UNSIGNED NOT NULL,
  `street_name` VARCHAR(100) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `zipcode` CHAR(5) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `P6_db`.`Pizzerias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P6_db`.`Pizzerias` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `address_id` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Pizzerias_Addresses1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pizzerias_Addresses1`
    FOREIGN KEY (`address_id`)
    REFERENCES `P6_db`.`Addresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `P6_db`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P6_db`.`Orders` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` TIMESTAMP NOT NULL DEFAULT NOW(),
  `status_id` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `payed` TINYINT NOT NULL DEFAULT 0,
  `address_id` SMALLINT UNSIGNED NOT NULL,
  `contact` VARCHAR(45) NOT NULL,
  `pizzeria_id` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Orders_Status1_idx` (`status_id` ASC) VISIBLE,
  INDEX `fk_Orders_Addresses1_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_Orders_Pizzerias1_idx` (`pizzeria_id` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `P6_db`.`Status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Addresses1`
    FOREIGN KEY (`address_id`)
    REFERENCES `P6_db`.`Addresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Pizzerias1`
    FOREIGN KEY (`pizzeria_id`)
    REFERENCES `P6_db`.`Pizzerias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `P6_db`.`Pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P6_db`.`Pizzas` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `price` DECIMAL(4,2) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `P6_db`.`Ingredients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P6_db`.`Ingredients` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `P6_db`.`Role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P6_db`.`Role` (
  `id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `P6_db`.`Accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P6_db`.`Accounts` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(20) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `role_id` TINYINT UNSIGNED NOT NULL,
  `pizzeria_id` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) VISIBLE,
  INDEX `fk_Accounts_Role_idx` (`role_id` ASC) VISIBLE,
  INDEX `fk_Accounts_Pizzerias1_idx` (`pizzeria_id` ASC) VISIBLE,
  CONSTRAINT `fk_Accounts_Role`
    FOREIGN KEY (`role_id`)
    REFERENCES `P6_db`.`Role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Accounts_Pizzerias1`
    FOREIGN KEY (`pizzeria_id`)
    REFERENCES `P6_db`.`Pizzerias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `P6_db`.`Stocks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P6_db`.`Stocks` (
  `pizzeria_id` SMALLINT UNSIGNED NOT NULL,
  `ingredient_id` SMALLINT UNSIGNED NOT NULL,
  `quantity` FLOAT UNSIGNED NOT NULL,
  PRIMARY KEY (`pizzeria_id`, `ingredient_id`),
  INDEX `fk_Stocks_Ingredients1_idx` (`ingredient_id` ASC) VISIBLE,
  CONSTRAINT `fk_Stocks_Pizzerias1`
    FOREIGN KEY (`pizzeria_id`)
    REFERENCES `P6_db`.`Pizzerias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Stocks_Ingredients1`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `P6_db`.`Ingredients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `P6_db`.`Pizza_Ingredients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P6_db`.`Pizza_Ingredients` (
  `pizza_id` SMALLINT UNSIGNED NOT NULL,
  `ingredient_id` SMALLINT UNSIGNED NOT NULL,
  `quantity` FLOAT UNSIGNED NOT NULL,
  PRIMARY KEY (`pizza_id`, `ingredient_id`),
  INDEX `fk_Pizza_Ingredients_Ingredients1_idx` (`ingredient_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pizza_Ingredients_Ingredients1`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `P6_db`.`Ingredients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pizza_Ingredients_Pizzas1`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `P6_db`.`Pizzas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `P6_db`.`Coupons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P6_db`.`Coupons` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `value` DECIMAL(6,2) UNSIGNED NOT NULL,
  `code` VARCHAR(15) NOT NULL,
  `used` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `P6_db`.`Order_Content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P6_db`.`Order_Content` (
  `pizza_id` SMALLINT UNSIGNED NOT NULL,
  `order_id` INT UNSIGNED NOT NULL,
  `quantity` SMALLINT UNSIGNED NOT NULL,
  `sum` DECIMAL(6,2) UNSIGNED NOT NULL,
  PRIMARY KEY (`pizza_id`, `order_id`),
  INDEX `fk_Order_Content_Orders1_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order_Content_Pizzas1`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `P6_db`.`Pizzas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Content_Orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `P6_db`.`Orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



INSERT INTO Status (name) VALUES ('En attente'), ('En préparation'), ('En livraison'), ('Livrée'), ('Incident');


INSERT INTO Addresses (name, street_number, street_name, city, zipcode) VALUES ('Point de vente Paris', 13, 'Rue de la Paix', 'Paris', '75001'), 
('Point de vente Lyon', 15, 'Rue mercière', 'Lyon', '69002'), ('Point de vente Berg-en-Brousse', 17, 'Impasse du pas sympa', 'Berg-en-Brousse', '01000'), 
('Bouvier', 74, 'Rue du vieux bouc', 'Lyon', '69005'), ('Priscilla', 40, 'Avenue de la zouk', 'Paris', '75019');


INSERT INTO Pizzerias (address_id) VALUES (1), (2), (3);


INSERT INTO Orders (time, status_id, payed, address_id, contact, pizzeria_id) VALUES (NOW(), 1, 1, 4, 'bouboulebouc@gmail.com', 2), (NOW(), 5, 1, 5, "0600000000", 1);


INSERT INTO Pizzas (name, price) VALUES ('La Arnaqua', 9.00), ('La Esmeralada', 12.10), ('La Alohomora', 13.90), ('La Felindra', 15.50);


INSERT INTO Ingredients (name) VALUES ('Pâte'), ('Sauce tomate'), ('Mozzarella'), ('Chorizo andaloux'), ('Sirop de grenadine'), ('Steak de chat');


INSERT INTO Role (name) VALUES ('Admin'), ('Responsable'), ('Pizzaiolo'), ('Livreur'), ('Vendeur');


INSERT INTO Accounts (login, password, role_id, pizzeria_id) VALUES ('vsadmin', 'vspassword', 1, 1), ('trucresp', 'trucpassword', 2, 1), 
('mucheadmin', 'muchepassword', 2, 2), ('machinpizz', 'machinpassword', 3, 2), ('chosepizz', 'chosepassword', 3, 3), ('gloubilivr', 'gloubipassword', 4, 1),
('boulgalivr', 'boulgapassword', 4, 3), ('logvend', 'logpassword', 5, 3), ('invend', 'inpassword', 5, 2);


INSERT INTO Stocks VALUES (1, 1, 10.0), (1, 2, 15.5), (1, 3, 9.0), (1, 4, 0.25), (1, 5, 25.0), 
(1, 6, 16.2), (2, 1, 11.0), (2, 2, 5.5), (2, 3, 6.0), (2, 4, 5.25), (2, 5, 0.0), (2, 6, 19.1),
(3, 1, 13.0), (3, 2, 5.0), (3, 3, 16.0), (3, 4, 8.0), (3, 5, 20.0), (3, 6, 0.1);


INSERT INTO Pizza_Ingredients VALUES (1, 1, 1.0), (1, 2, 1.5), (1, 3, 0.5), 
(2, 1, 1.0), (2, 2, 1.5), (2, 3, 0.5), (2, 4, 1.0),
(3, 1, 1.0), (3, 2, 1.5), (3, 3, 0.5), (3, 5, 1.0), 
(4, 1, 1.0), (4, 2, 1.5), (4, 3, 0.5), (4, 5, 1.0);


INSERT INTO Coupons (value, code, used) VALUES (42.42, 'OCP4EVER', 0), (13.37, 'DAPYFTW', 1);


INSERT INTO Order_Content VALUES (1, 1, 2, 18.00), (3, 1, 1, 13.90), (2, 2, 1, 12.10), (4, 2, 1, 15.50);