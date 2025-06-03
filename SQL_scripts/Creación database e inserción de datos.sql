CREATE DATABASE Bike_Sales_Store;

USE Bike_Sales_Store;

CREATE TABLE Brands (brand_id INT NOT NULL, 
					brand_name VARCHAR (30));
                    
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/brands.csv' 
INTO TABLE Brands CHARACTER SET latin1 
COLUMNS TERMINATED BY ',' LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE Categories (category_id INT NOT NULL,
						category_name VARCHAR(50));
                        
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/categories.csv' 
INTO TABLE Categories CHARACTER SET latin1 
COLUMNS TERMINATED BY ',' LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE customers (customer_id INT NOT NULL,
						first_name VARCHAR (50),
						last_name VARCHAR(50),
                        phone VARCHAR(50),
                        email VARCHAR(50),
                        street VARCHAR(50),
                        city VARCHAR(50),
                        state VARCHAR(10),
                        zip_code INT);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv' 
INTO TABLE customers CHARACTER SET latin1 
COLUMNS TERMINATED BY ',' LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE order_items (order_id INT NOT NULL,
						item_id INT,
                        product_id INT,
                        quantity INT,
                        list_price DECIMAL(8,2),
                        discount DECIMAL(5,2));
                        
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/order_items.csv' 
INTO TABLE order_items CHARACTER SET latin1 
COLUMNS TERMINATED BY ',' LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE orders (order_id INT NOT NULL,
					customer_id INT,
                    order_status INT,
                    order_date DATE NULL,
                    require_date DATE NULL,
                    shipped_date DATE NULL, 
                    store_id INT,
                    staff_id INT);
                    
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders.csv' 
INTO TABLE orders CHARACTER SET latin1 
COLUMNS TERMINATED BY ',' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(order_id, customer_id, order_status, order_date, require_date, @shipped_date, store_id, staff_id)
SET shipped_date = NULLIF(@shipped_date, 'NULL'); #creamos variable temporal para identificar nulos del csv y cargarlos

CREATE TABLE products (product_id INT NOT NULL,
						product_name VARCHAR(150),
                        brand_id INT, 
                        category_id INT,
                        model_year INT,
                        list_price DECIMAL(8,2));
                        
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products.csv' 
INTO TABLE products CHARACTER SET latin1 
COLUMNS TERMINATED BY ',' LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE staffs (staff_id INT NOT NULL,
					first_name VARCHAR(50),
                    last_name VARCHAR(50),
                    email VARCHAR(100),
                    phone VARCHAR (50),
                    active_1 INT,
                    store_id INT, 
                    manager_id VARCHAR(50) NULL);
                    
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/staffs.csv'
INTO TABLE staffs
CHARACTER SET latin1
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE stocks (store_id INT NOT NULL,
					product_id INT,
                    quantity INT);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/stocks.csv' 
INTO TABLE stocks CHARACTER SET latin1 
COLUMNS TERMINATED BY ',' LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE stores (store_id INT NOT NULL,
					store_name VARCHAR(50),
                    phone VARCHAR(50),
                    email VARCHAR(50),
                    street VARCHAR(50),
                    city VARCHAR(50),
					state VARCHAR(10),
					zip_code INT);
                    
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/stores.csv' 
INTO TABLE stores CHARACTER SET latin1 
COLUMNS TERMINATED BY ',' LINES TERMINATED BY '\n'
IGNORE 1 LINES;





