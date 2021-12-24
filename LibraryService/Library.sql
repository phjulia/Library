CREATE SCHEMA IF NOT EXISTS Library;
USE Library;

DROP TABLE IF EXISTS Publisher;
DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Author;
CREATE TABLE Author(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL
    );
CREATE TABLE Publisher(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
	address VARCHAR(60) NOT NULL
    );
CREATE TABLE Book(
	id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(20) NOT NULL,
    authorID INT NOT NULL,
    ISBN VARCHAR(60) NOT NULL UNIQUE,
    PublisherID INT,
	FOREIGN KEY(authorID) REFERENCES Author(id),
    FOREIGN KEY(PublisherID) REFERENCES Publisher(id)
    );
    
    DELIMITER $$
	CREATE TRIGGER checkISBN 
	BEFORE INSERT 
	ON Book FOR EACH ROW
	BEGIN
		DECLARE errorMessage VARCHAR(255);
		IF LENGTH(new.ISBN)!=13 THEN
		SET errorMessage = 'THE LENGTH OF THE ISBN NUMBER SHOULD BE 13';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
    END IF;
	END$$
    
INSERT INTO Publisher(name,address) VALUES('ABC','London, Washington str. 39');
INSERT INTO Publisher(name,address) VALUES('Penguin Random House','New York, Clinton str. 21');
INSERT INTO Publisher(name,address) VALUES('HarperCollins','2341 W Keim Dr, Phoenix, AZ 85015, US');

INSERT INTO Author(name) VALUES('William Shakespeare');
INSERT INTO Author(name) VALUES('Homer');
INSERT INTO Author(name) VALUES('J.K. Rowling');
INSERT INTO Author(name) VALUES('Taras Shevchenko');
INSERT INTO Author(name) VALUES('Stephen King');
INSERT INTO Author(name) VALUES('Bolesław Prus');
INSERT INTO Author(name) VALUES('Taras Shevchenko');
INSERT INTO Book(title, authorID,ISBN,PublisherID) VALUES('Romeo and Juliet',1,'6453682931222',1);
INSERT INTO Book(title, authorID,ISBN,PublisherID) VALUES('Makbet',1,'8473662227189',1);
INSERT INTO Book(title, authorID,ISBN,PublisherID) VALUES('Hamlet',1,'4432847263528',1);
INSERT INTO Book(title, authorID,ISBN,PublisherID) VALUES('Odyssey',2,'1112223345555',1);
INSERT INTO Book(title, authorID,ISBN,PublisherID) VALUES('Harry Potter',3,'0928371828392',1);
INSERT INTO Book(title, authorID,ISBN,PublisherID) VALUES('Katerina',4,'2314345523423',1);
INSERT INTO Book(title, authorID,ISBN,PublisherID) VALUES('The Shining',5,'9780345806789',1);
INSERT INTO Book(title, authorID,ISBN,PublisherID) VALUES('Carrie',5,'9789871138999',1);
INSERT INTO Book(title, authorID, ISBN, PublisherID) VALUES('Cat\'s Eye',5,'9780385491020',2);
INSERT INTO Book(title, authorID, ISBN, PublisherID) VALUES('Later',5,'9781789096491',2);
INSERT INTO Book(title, authorID, ISBN, PublisherID) VALUES('The Doll',6,'9780686309185',2);
