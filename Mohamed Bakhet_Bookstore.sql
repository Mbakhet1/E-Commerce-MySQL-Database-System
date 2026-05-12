/* I'LL BE CRETING A SIMPLE DATABASE TO OVERSEE A BOOK STORE.
IT WILL CONSIST OF 3 TABLES BOOKS,CUSTOMERS, AND ORDERS SUMMARY AND EACH OF THOSE TABLES WILL HAVE 3 ROWS OF DATA.
AFTER I CREATE THE TABLES AND INSERT DATA I WILL WRITE 5 QUERIES USING THE DATA I INSERTED IN THE TABLES
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
('Atomic Habits', 'James Clear', 'Self-Help', 22.00, 200, 'Avery', 2018),
('The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 10.99, 55, 'Scribner', 1925),
('Pride and Prejudice', 'Jane Austen', 'Romance', 12.50, 85, 'T. Egerton', 1913),
('1984', 'George Orwell', 'Dystopian', 14.99, 110, 'Secker & Warburg', 1949),
('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 15.95, 60, 'George Allen & Unwin', 1937),
('A Brief History of Time', 'Stephen Hawking', 'Science', 18.00, 25, 'Bantam Books', 1988);
/*INSERTING DATA INTO CUSTOMERS*/
INSERT INTO Customers (first_name, last_name, email, phone, street_address, city, state, postal_code)
VALUES
('John', 'Doe', 'John.D@email.com', '941-111-1111', '123 Oak Ave', 'Springfield', 'IL', '62704'),
('Adam', 'Smith', 'Adam.S@email.com', '941-222-2222', '456 Pine St', 'Metropolis', 'NY', '10001'),
('Charlie', 'Brown', 'Charlie.b@email.com', '941-333-3333', '789 Maple Dr', 'Gotham', 'NJ', '07101');
INSERT INTO Customers (first_name, last_name, email, phone, street_address, city, state, postal_code)
VALUES
('Jason', 'Tatum' , 'Jason.t@email.com', '941-444-4444', '101 lakewood St', 'Tampa', 'FL','11231'),
('Steph', 'Curry', 'Steph.c@email.com', '941-555-5555', '214 Widdow Ave', 'Sarasota', 'FL', '31010');


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



/* Mohamed Bakhet_bookstore_part2.sql BOOKSTORE DATABASE REFACTOR - EVOLUTION */
USE book_storedb;

/*Modify Books table Rename 'genre' to 'category' and update price precision to DECIMAL(10,2).*/
ALTER TABLE Books
CHANGE COLUMN genre category VARCHAR(50),
MODIFY price DECIMAL(10,2) NOT NULL CHECK (price >= 0);

/*Convert Existing Tables to InnoDB and utf8mb4*/
ALTER TABLE Customers ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
ALTER TABLE Books ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

/*Create New Relational Tables Orders_Summary into Orders and OrderItems.*/
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE DEFAULT (CURDATE()) NOT NULL,
    total_amount DECIMAL(10,2) CHECK (total_amount > 0),
    payment_method VARCHAR(20),
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

/*Create OrderItems Table*/
CREATE TABLE IF NOT EXISTS OrderItems (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price_at_sale DECIMAL(10,2) NOT NULL CHECK (unit_price_at_sale >= 0),
    UNIQUE KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

/*Inserting Sample Data*/
INSERT INTO Customers (first_name, last_name, email, phone, street_address, city, state, postal_code)
VALUES
('Diana', 'Prince', 'diana.p@email.com', '941-666-6666', '555 Themyscira Way', 'Washington', 'DC', '20001'),
('Bruce', 'Wayne', 'bruce.w@email.com', '941-777-7777', '1007 Mountain Dr', 'Gotham', 'NJ', '07102');

INSERT INTO Books (title, author, category, price, stock_quantity, publisher, published_year)
VALUES
('The Catcher in the Rye', 'J.D. Salinger', 'Classic', 11.00, 45, 'Little, Brown', 1951),
('Sapiens', 'Yuval Noah Harari', 'History', 24.99, 100, 'Harper', 2011);

INSERT INTO Orders (customer_id, order_date, total_amount, payment_method, order_status)
VALUES
(1, '2024-06-01', 50.97, 'Credit Card', 'Shipped'),
(2, '2024-06-05', 40.50, 'PayPal', 'Processing'),
(3, '2024-06-05', 22.00, 'Debit Card', 'Delivered'),
(7, '2024-06-10', 10.99, 'Credit Card', 'Processing'),
(4, '2024-07-01', 77.96, 'Venmo', 'Shipped'),
(5, '2024-07-15', 31.48, 'Credit Card', 'Delivered');

/*Trigger Integrity at Point of Sale*/
DELIMITER $$
CREATE TRIGGER trg_orderitem_set_price
BEFORE INSERT ON OrderItems
FOR EACH ROW
BEGIN
    DECLARE current_price DECIMAL(10,2);
    
    -- Check quantity
    IF NEW.quantity <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantity must be positive';
    END IF;

    -- Get current book price
    SELECT price INTO current_price FROM Books WHERE book_id = NEW.book_id;
    
    -- Set the snapshot price
    SET NEW.unit_price_at_sale = current_price;
END $$
DELIMITER ;

/* Insert Items Into OrderItems*/
INSERT INTO OrderItems (order_id, book_id, quantity)
VALUES
(1, 1, 1),
(1, 2, 2), 
(2, 5, 2),
(2, 4, 1),
(3, 3, 1),
(4, 4, 1),
(5, 1, 1),
(5, 6, 2), 
(6, 6, 1)

/* Creating Indexes*/
CREATE INDEX idx_orders_date ON Orders (order_date);
CREATE INDEX idx_books_category ON Books (category);
CREATE INDEX idx_orderitems_lookup ON OrderItems (order_id, book_id);

/* Creating Views*/
CREATE OR REPLACE VIEW v_order_detail AS
SELECT 
    o.order_id, o.order_date, c.customer_id, c.email,
    b.title AS book_title, oi.quantity, oi.unit_price_at_sale,
    (oi.quantity * oi.unit_price_at_sale) AS line_total
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Books b ON oi.book_id = b.book_id;

CREATE OR REPLACE VIEW v_daily_sales AS
SELECT order_date, COUNT(order_id) AS orders_count, SUM(total_amount) AS revenue_total
FROM Orders GROUP BY order_date;

/* Writing 8 QUeries*/
/*1. Order History for Customer*/
SELECT CONCAT(c.first_name, ' ', c.last_name) AS name, o.order_id, o.order_date, SUM(oi.quantity) as items
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
WHERE c.customer_id = 1
GROUP BY o.order_id, o.order_date;

/* 2. Daily Sales Summary*/
SELECT * FROM v_daily_sales;

/*3. Top 5 Books by Revenue*/
SELECT b.title, SUM(oi.quantity * oi.unit_price_at_sale) as revenue
FROM Books b
JOIN OrderItems oi ON b.book_id = oi.book_id
GROUP BY b.book_id
ORDER BY revenue DESC LIMIT 5;

/*4. Customers With Orders in June 2024*/
SELECT c.customer_id, c.first_name, COUNT(o.order_id) as order_count
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_date BETWEEN '2024-06-01' AND '2024-06-30'
GROUP BY c.customer_id;

/* 5. Books Never Ordered*/
SELECT b.title, b.category
FROM Books b
LEFT JOIN OrderItems oi ON b.book_id = oi.book_id
WHERE oi.order_item_id IS NULL;

/*6. Average Order Value per Customer*/
SELECT c.email,(o.total_amount) as avg_spend
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

/*7. CTE: Monthly Revenue vs Average*/
WITH MonthlyStats AS (
    SELECT DATE_FORMAT(order_date, '%Y-%m') as mth, SUM(total_amount) as rev
    FROM Orders GROUP BY mth
)
SELECT mth, rev, rev - (SELECT AVG(rev) FROM MonthlyStats) as diff_from_avg
FROM MonthlyStats;

/*8. Category Performance*/
SELECT b.category, SUM(oi.quantity) as sold, SUM(oi.quantity * oi.unit_price_at_sale) as rev
FROM Books b
JOIN OrderItems oi ON b.book_id = oi.book_id
GROUP BY b.category
ORDER BY rev DESC;