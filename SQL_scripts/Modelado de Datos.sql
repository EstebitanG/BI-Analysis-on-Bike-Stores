#Data Modeling (modelado dimensional)

#Dimension Producto (tabla products + tabla brands + tabla categories)
#Creamos una View para Dimensión Producto creando una clave sintética (surrogate key) mediante ROW NUMBER

CREATE VIEW DIMENSION_PRODUCTO AS 
SELECT 
		ROW_NUMBER() OVER (ORDER BY a.product_id) AS sr_prod_key,
		a.product_id,
		a.product_name,
        a.brand_id,
        a.category_id,
        a.model_year,
        a.list_price,
        b.brand_name,
        c.category_name
FROM products AS a
LEFT JOIN brands AS b
ON a.brand_id = b.brand_id

LEFT JOIN categories AS c
ON a.category_id = c.category_id;

SELECT * FROM DIMENSION_PRODUCTO;

#Dimension Store (tabla stores)
#Creamos una View para Dimension Stores, creando una clave sintética (surrogate key) mediante ROW_NUMBER()

CREATE VIEW DIMENSION_STORES AS
SELECT 
	ROW_NUMBER() OVER(ORDER BY store_id) AS sr_store_key,
    store_id,
    store_name,
    phone AS store_phone,
    email AS store_email,
    street AS store_street
FROM stores;

SELECT * FROM DIMENSION_STORES;

#Dimension Stock (tabla stock)
#Creamos una View para Dimension Stores, creando una clave sintética (surrogate key) mediante ROW_NUMBER()

CREATE VIEW DIMENSION_STOCK AS
SELECT
	ROW_NUMBER() OVER(ORDER BY store_id) AS sr_stock_key,
    store_id,
    product_id,
    quantity_stock AS stock_quantity
FROM stocks;

SELECT * FROM DIMENSION_STOCK;

#Dimension Staffs (tabla staffs)
#Creamos una View para Dimension Staffs, creando una clave sintética (surrogate key) mediante ROW_NUMBER()

CREATE VIEW DIMENSION_STAFFS AS
SELECT 
		ROW_NUMBER() OVER(ORDER BY store_id) AS sr_staff_key,
        staff_id,
        first_name AS staff_first_name,
        last_name AS staff_last_name,
        email AS staff_email,
        phone AS staff_phone,
        active_1,
        store_id,
        manager_id
FROM staffs;

SELECT * FROM DIMENSION_STAFFS;


#Dimension Clientes (tabla customers)
#Creamos una View para Dimensión Clientes creando una clave sintética (surrogate key) mediante ROW NUMBER

CREATE VIEW DIMENSION_CLIENTES AS
SELECT 
		ROW_NUMBER() OVER (ORDER BY customer_id) AS sr_cust_key,
        customer_id,
		first_name AS cust_first_name,
		last_name AS cust_last_name,
        email AS cust_email,
        street AS cust_street,
        city AS cust_city,
        state AS cust_state,
        zip_code AS cust_zip_code,
        customer_number
FROM customers_clean;

SELECT * FROM DIMENSION_CLIENTES;



#Hecho Ventas (2 tablas - orders_clean + orders_items)
#Creamos una vista con las tablas de HECHOS, donde las claves sintéticas vienen de las tablas dimensiones como claves foráneas
#De esta forma conectamos las DIMENSIONES con el HECHO (esquema Estrella). Esta tabla está con granularidad a nivel de ítem (por ello para el mismo pedido order_id aparecen distintos productos)

CREATE VIEW HECHO_VENTAS AS
SELECT  
    a.order_id,
    c.sr_cust_key,
    d.sr_store_key,
    e.sr_prod_key,
    f.sr_stock_key,
    g.sr_staff_key, #claves sintéticas Dimensiones
    b.item_id,
    b.quantity AS order_quantity,
    b.list_price,
    b.discount,
    a.order_date,
    a.require_date,
    a.shipped_date
FROM orders_clean AS a
JOIN order_items AS b
  ON a.order_id = b.order_id

LEFT JOIN DIMENSION_CLIENTES AS c
  ON a.customer_id = c.customer_id

LEFT JOIN DIMENSION_STORES AS d
  ON a.store_id = d.store_id

LEFT JOIN DIMENSION_PRODUCTO AS e
  ON b.product_id = e.product_id
  
LEFT JOIN DIMENSION_STOCK AS f
  ON b.product_id = f.product_id
  AND f.store_id = a.store_id
  
LEFT JOIN DIMENSION_STAFFS AS g
  ON a.staff_id = g.staff_id;	
  
SELECT * FROM HECHO_VENTAS;
  
#Comprobación duplicados HECHO_VENTAS

SELECT order_id, item_id, COUNT(*) AS veces_repetido
FROM HECHO_VENTAS
GROUP BY order_id, item_id
HAVING COUNT(*) > 1;

#Tablas Finales (se procede a su exportación a csv mediante Python)

SELECT * FROM DIMENSION_CLIENTES;
SELECT * FROM DIMENSION_PRODUCTO;
SELECT * FROM DIMENSION_STAFFS;
SELECT * FROM DIMENSION_STOCK;
SELECT * FROM DIMENSION_STORES;
SELECT * FROM HECHO_VENTAS;


