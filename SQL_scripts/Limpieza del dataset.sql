#Comprobación limpieza base de datos

DELIMITER //

CREATE PROCEDURE limpieza_tablas_bikes_stores()
BEGIN

	#Querys diagnóstico espacios innecesarios

	SELECT * FROM brands;

	SELECT brand_name FROM brands
	WHERE brand_name <> TRIM(brand_name);

	SELECT * FROM categories;

	SELECT category_name FROM categories
	WHERE category_name <> TRIM(category_name);

	SELECT * FROM customers;

	SELECT customer_id, street FROM customers
	WHERE customer_id <> TRIM(customer_id) AND street <>TRIM(street);


	SELECT product_name FROM products
	WHERE product_name <> TRIM(product_name);

	# Querys diagnóstico chequear nulos, números negativos e incoherencias

	SELECT * FROM customers
	WHERE (first_name = 'NULL' OR '') OR (last_name = 'NULL' OR '') OR (phone = 'NULL' OR '')
	OR (email = 'NULL' OR '') OR (street = 'NULL' OR '') OR (city = 'NULL' OR '')
	OR (state = 'NULL' OR '') OR (zip_code = 'NULL' OR '');

	CREATE TABLE customers_clean AS
	SELECT customer_id, first_name, last_name, email, street, city, state, zip_code,
	CASE 
		WHEN phone = 'NULL' THEN 'Unknown'
		ELSE phone
	END AS 'customer_number'
	FROM customers;

	#Tabla limpia
	SELECT * FROM customers_clean;

	#Query diagnóstico duplicados en customers_clean
	SELECT street, COUNT(street) FROM customers_clean
	GROUP BY street
	HAVING COUNT(street) > 1 OR street = '' OR street IS NULL; #no hay clientes duplicados según su dirección

	#Query diagnóstico incoherencia en fechas de pedido y fechas de envío
	SELECT * FROM orders
	WHERE shipped_date < require_date;

	CREATE TABLE orders_clean AS
	SELECT order_id, customer_id, order_status, order_date, require_date, store_id, staff_id,
	CASE 
		WHEN shipped_date < require_date THEN require_date #reemplazar fecha de envío por fecha de pedido en caso de incoherencia
		WHEN shipped_date IS NULL THEN require_date #asumir pedido y entrega el mismo día en caso de nulo
		ELSE shipped_date
	END AS 'shipped_date'
	FROM orders;

	SELECT order_id, customer_id, order_status, order_date, require_date, shipped_date, store_id, staff_id 
	FROM orders_clean
	WHERE require_date > shipped_date OR shipped_date IS NULL; #comprobación limpieza

	SELECT * FROM products;

	#Query diagnóstico duplicados en product_name
	SELECT product_name, COUNT(product_name) FROM products
	GROUP BY product_name
	HAVING COUNT(product_name) > 1 OR product_name = '' OR product_name IS NULL;

	SELECT * FROM products
	WHERE product_name = "Electra Girl's Hawaii 1 (16-inch) - 2015/2016";

	SELECT * FROM CATEGORIES; #estas últimas 3 querys señalan que hay productos duplicados, pero no es por suciedad del dataset, sino porque 1 producto puede pertenecer a más de 1 categoría

	SELECT * FROM stocks
	WHERE product_id < 0 OR quantity < 0;

END //

DELIMITER ;
