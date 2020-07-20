CREATE TABLE IF NOT EXISTS books
(
    book_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    author_id INTEGER UNSIGNED,
    title VARCHAR(100) NOT NULL,
    `year` INTEGER UNSIGNED NOT NULL DEFAULT 1900,
    `language` VARCHAR(2) NOT NULL DEFAULT 'es' COMMENT 'ISO 639-1 Language',
    cover_url VARCHAR(500),
    price DOUBLE(6, 2) NOT NULL DEFAULT 10.0,
    sellable TINYINT(1) DEFAULT 1,
    copies INTEGER NOT NULL DEFAULT 1,
    `description` TEXT
);

CREATE TABLE IF NOT EXISTS autors (
    author_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    nationality VARCHAR(3) 
);

CREATE TABLE IF NOT EXISTS clients (
    client_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    birthdate DATETIME,
    gender ENUM('M', 'F', 'ND') NOT NULL,
    active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS operations (
    operation_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    book_id INTEGER UNSIGNED NOT NULL,
    client_id INTEGER UNSIGNED NOT NULL,
    `type` ENUM('S', 'L', 'R') NOT NULL COMMENT 'S=sold, L=lent, R=returned',
    finished TINYINT(1) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO autors(`name`, nationality)
    VALUES('Juan Rulfo', 'MEX');

INSERT INTO autors(`name`, nationality)
    VALUES('Gabriel García Marquez', 'COL');

INSERT INTO autors
    VALUES('', 'Juan Gabriel Vasquez', 'COL');

INSERT INTO autors(`name`, nationality)
    VALUES('Juan Gabriel Vasquez', 'COL');

INSERT INTO autors(`name`, nationality)
    VALUES
        ('Julio Coltazar', 'ARG'),
        ('Isabel Allende', 'CHI'),
        ('Octavio Paz', 'MEX'),
        ('Juan Carlos Oneti', 'URU');
        
INSERT INTO `clients`(`name`, email, birthdate, gender, active) VALUES
    ('Maria Dolores Gomez','Maria Dolores.95983222J@random.names','1971-06-06','F',1),
    ('Adrian Fernandez','Adrian.55818851J@random.names','1970-04-09','M',1),
    ('Maria Luisa Marin','Maria Luisa.83726282A@random.names','1957-07-30','F',1),
    ('Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',1);

    INSERT INTO `clients`(`name`, email, birthdate, gender, active) VALUES
        ('Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',0)
        ON DUPLICATE KEY UPDATE active = VALUES(active);

INSERT INTO books(title, author_id, `year`)
	VALUES('El Laberinto de la Soledad', 6, 1952);

INSERT INTO books(title, author_id, `year`)
	VALUES('Vuelta al Laberinto de la Soledad',
    (SELECT author_id FROM autors WHERE `name` = 'Octavio Paz' LIMIT 1),
    1960);

SELECT `name`, email
FROM clients
WHERE gender = 'F';

select birthdate
from clients;

select year(birthdate)
from clients;

select name, year(now()) - year(birthdate)
from clients;

select *
from clients
where name like '%Saave%';

select name, email, year(now()) - year(birthdate) as age, gender
from clients
where gender = 'F'
and name like '%Lop%';
