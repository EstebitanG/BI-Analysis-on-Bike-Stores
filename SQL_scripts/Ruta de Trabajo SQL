# Fase 1: Modelado y preparación de datos

1. Carga e inserción de datos

Para la carga de la información de los csv, primero se crea la base de datos "bike_sales_store", y dentro de ellas cada tabla correspondiente 
a cada archivo csv. Con el comando CREATE TABLE se determinan los tipos de datos de las columnas mediante observación. 
Finalmente, se realiza la importación de la información mediante el comando LOAD DATA INFILE.

2. Limpieza y estandarización

Para la correcta manipulación y análisis posterior de la información, se lleva a cabo la limpieza de datos en MySQL mediante un 
procedimiento almacenado. En él, se limpian espacios innecesarios, se chequean valores nulos, números negativos donde no corresponden y 
demás incoherencias, todo ello mediante comandos SQL.

3. Diseño del modelo estrella

Se busca el esquema estrella por su simplicidad y rendimiento eficiente. Se definen las tablas de hechos y dimensiones. En este caso,
nuestras tablas de dimensiones corresponden a Clientes, Productos, Staffs y Store, mientras que nuestra tabla de hechos corresponde a
Ventas.

4. Exportación del modelo a Power BI

Se hace la exportación vía archivo plano (csv) con la ayuda del script mysql.connector de Python.
