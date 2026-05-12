/* I'LL BE CRETING A SIMPLE DATABASE TO OVERSEE A BOOK STORE.
IT WILL CONSIST OF 3 TABLES BOOKS,CUSTOMERS, AND ORDERS SUMMARY AND EACH OF THOSE TABLES WILL HAVE 3 ROWS OF DATA.
AFTER I CREATE THE TABLES AND INSERT DATA I WILL WRITE 5 QUERIES USING THE DATA I INSERTED INT THE TABLES
I WILL HAVE COMMENTS BEFORE EACH COMMAND IS WRITTEN*/

/*creating the needed database*/
CREATE DATABASE book_storedb;

/*use the database*/
USE book_storedb;

/*create the book table*/
CREATE TABLE Books(
book_id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(100) NOT NULL,
author VARCHAR(100) NOT NULL,
genre VARCHAR(50),
price DECIMAL(6,2) NOT NULL CHECK (PRICE >= 0),
stock_quantity INT CHECK (stock_quantity >= 0),
publisher VARCHAR(100),
published_year YEAR CHECK (published_year >= 1900)
);

/*create customers table*/
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    street_address VARCHAR(100),
    city VARCHAR(50),
    state CHAR(2) CHECK (state = UPPER(state)),
    postal_code VARCHAR(10),
    join_date DATE DEFAULT (CURDATE())
);

/* create orders_summary yables*/
CREATE TABLE Orders_Summary(
order_id INT PRIMARY KEY AUTO_INCREMENT,
order_date DATE DEFAULT (CURDATE()) NOT NULL,
customer_name VARCHAR(100),
book_title VARCHAR(100),
quantity INT CHECK(quantity>0),
total_amount DECIMAL(8,2) CHECK (total_amount >0),
payment_mehtod VARCHAR(20) ,
order_status VARCHAR(20)
);
/* inserting data into tabLes*/
USE book_storedb;
INSERT INTO Books (title, author, genre, price, stock_quantity, publisher, published_year)
VALUES
('The Midnight Library', 'Matt Haig', 'Fantasy', 15.99, 120, 'Viking', 2020),
('Dune', 'Frank Herbert', 'Science Fiction', 18.50, 85, 'Chilton Books', 1965),
('Atomic Habits', 'James Clear', 'Self-Help', 22.00, 200, 'Avery', 2018);

/*INSERTING DATA INTO CUSTOMERS*/
INSERT INTO Customers (first_name, last_name, email, phone, street_address, city, state, postal_code)
VALUES
('John', 'Doe', 'John.D@email.com', '941-111-1111', '123 Oak Ave', 'Springfield', 'IL', '62704'),
('Adam', 'Smith', 'Adam.S@email.com', '941-222-2222', '456 Pine St', 'Metropolis', 'NY', '10001'),
('Charlie', 'Brown', 'Charlie.b@email.com', '941-333-3333', '789 Maple Dr', 'Gotham', 'NJ', '07101');

/*INSERTING DATA INTO CUSTOMERS INTO ORDER_SUMMARY*/
INSERT INTO Orders_Summary (customer_name, book_title, quantity, total_amount, payment_mehtod, order_status)
VALUES
('John Doe', 'Dune', 2, 37.00, 'Credit Card', 'Shipped'),
('Adam Smith', 'The Midnight Library', 1, 15.99, 'PayPal', 'Processing'),
('Charlie Brown', 'Atomic Habits', 1, 22.00, 'Debit Card', 'Delivered');

/*TOTALING THE TOTAL QUANTITY OF BOOKS*/
SELECT SUM(STOCK_QUANTITY) AS TOTAL_STOCK
FROM BOOKS;

/*TOTALING THE AMOUNT OF SALES FOR THE DAY*/
SELECT SUM(TOTAL_AMOUNT) AS TOATAL_SALES
FROM ORDERS_SUMMARY;


/* FINDING OUT PRICE OF BOOK WHILE ONLY HAVING PART OF TITLE*/
SELECT PRICE 
FROM BOOKS WHERE TITLE LIKE '%LIBRARY%'


/* TOTAL OF HOW MANY BOOKS WE HAVE FOR EACH GENRE*/
SELECT GENRE, SUM(STOCK_QUANTITY) 
AS TOTAL_BOOKS
FROM BOOKS
GROUP BY GENRE;

/*SHOWS ORDER STATUS, ORDER ID AND ORDER DATE FOR EACH CUSTOMER*/
SELECT
CUSTOMER_NAME,
ORDER_STATUS,
ORDER_ID,
ORDER_DATE
FROM ORDERS_SUMMARY






