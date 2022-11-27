-- First create the db
-- CHECK IF THE DB EXISTS

CREATE DATABASE IF NOT EXISTS pizza_store;

-- Select it
USE pizza_store;

-- Create customer table
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
	
    customer_id INT NOT NULL AUTO_INCREMENT,
    customer_name VARCHAR(200)  NOT NULL,
	customer_phone_number VARCHAR(100) NOT NULL,
    PRIMARY KEY (customer_id)

);

-- Create orders table
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	order_id INT NOT NULL AUTO_INCREMENT,
    date_time DATETIME,
	order_customer_id INT,
	PRIMARY KEY(order_id),
    FOREIGN KEY(order_customer_id) REFERENCES customers (customer_id)
);



-- Create pizzas table
DROP TABLE IF EXISTS pizzas;
CREATE TABLE pizzas (

	pizza_id INT NOT NULL AUTO_INCREMENT,
    pizza_type VARCHAR(255) NOT NULL,
    pizza_price DECIMAL(4,2) NOT NULL,
    PRIMARY KEY(pizza_id)


);



-- Create join tables
DROP TABLE IF EXISTS pizza_order;
CREATE TABLE pizza_order (
	order_id INT NOT NULL,
    pizza_id INT NOT NULL,
    FOREIGN KEY(order_id) REFERENCES orders (order_id),
    FOREIGN KEY(pizza_id) REFERENCES pizzas (pizza_id)
);

DROP TABLE IF EXISTS customer_pizza;
CREATE TABLE customer_pizza (
	customer_id INT NOT NULL,
    pizza_id INT NOT NULL,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
	FOREIGN KEY(pizza_id) REFERENCES pizzas (pizza_id)
);





-- First populate customers
INSERT INTO customers (customer_name, customer_phone_number)
VALUES ('Trevor Page','226-555-4982');


INSERT INTO customers (customer_name, customer_phone_number)
VALUES  ('John Doe', '555-555-9498');

       
SELECT * FROM customers;




-- Populate pizzas
INSERT INTO pizzas (pizza_type, pizza_price)
VALUES ('Pepperoni & Cheese', 7.99),
	   ('Vegetarian', 9.99),
	   ('Meat Lovers',14.99),
       ('Hawaiian',12.99);

SELECT * FROM pizzas;


-- POPULATE ORDERS
-- ORDER #1
INSERT INTO orders (date_time, order_customer_id)
VALUES ('2014-10-9 9:47:00',1);

INSERT INTO pizza_order(order_id,pizza_id)
VALUES (1,1),
	   (1,3);


INSERT INTO customer_pizza(customer_id,pizza_id)
VALUES	(1,1),
	    (1,3);
        
        
-- ORDER #2
INSERT INTO orders (date_time, order_customer_id)
VALUES ('2014-10-9 13:20:00',2);

INSERT INTO pizza_order(order_id,pizza_id)
VALUES (2,2),
	   (2,3),
	   (2,3);


INSERT INTO customer_pizza(customer_id,pizza_id)
VALUES	(2,2),
	    (2,3),
        (2,3);
        
        
        
-- ORDER #3
INSERT INTO orders (date_time, order_customer_id)
VALUES ('2014-10-9 09:47:00',1);

INSERT INTO pizza_order(order_id,pizza_id)
VALUES (1,3),
	   (1,4);


INSERT INTO customer_pizza(customer_id,pizza_id)
VALUES	(1,3),
	    (1,4);
        
-- TEST
SELECT * FROM customer_pizza;       
SELECT * FROM pizza_order;      
SELECT * FROM orders;
SELECT * FROM customers;
SELECT * FROM pizzas;


-- HOW MUCH MONEY THEY SPEND
SELECT c.customer_name AS 'Customer Name', o.date_time AS 'Date' ,SUM(p.pizza_price) AS 'TOTAL AMOUNT SPENT' FROM pizza_order po

JOIN pizzas p ON p.pizza_id=po.pizza_id
JOIN customer_pizza cp ON cp.pizza_id=po.order_id
JOIN customers c ON c.customer_id=po.order_id
JOIN orders o ON o.order_id = po.order_id
GROUP BY c.customer_id;



                  

