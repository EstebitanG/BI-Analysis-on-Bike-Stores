# Fase 2: Análisis en Power BI

Modelo de Datos en Power BI

Se importó el modelo Estrella desarrollado en MySQL, con los mismos roles. Inicialmente no se tuvieron que hacer cambios importantes en
Power Query, dada la limpieza hecha en la herramienta ya mencionada.

Medidas principales en DAX

Se realizaron medidas con el lenguaje DAX para sacar métricas claves de negocio. Las más destacables son:

-Segmento Ticket Promedio: donde clasificamos a los clientes en base a su monto de compra, formando 4 clasificaciones (VIP, Premium, Promedio y Básico)

-Ventas Totales: la clásica multiplicación de precio por cantidad, añadiéndole el descuento correspondiente.

-Facturación promedio por cliente: una medida que divide las ventas totales por el total de clientes.

-Rotación promedio de inventario: representa cuantas veces las ventas de la empresa superaron su inversión en inventario.

Estas y demás medidas destacables se ahondarán en los análisis clientes, productos, geográficos y conclusiones.

# Análisis de Clientes

![Análisis Clientes](../images/Analisis_Clientes_Final.png)


En el análisis de clientes, podemos observar métricas como Facturación Promedio por Cliente, Top 10 Clientes por Ventas, cantidad de clientes por segmento (clasificando por facturación) y el comportamiento de ventas totales con granularidad año-mes. Al interactuar con estos gráficos dinámicos, se puede observar que la mayoria de nuestra ventas provenían desde un principio de nuestros clientes Básico y Promedio (facturación menor a $10.000 USD), pero al pasar los años, los clientes tipo Premium y VIP empiezan a tomar un porcentaje importante de nuestro total de ventas, que puede señalar los esfuerzos de la empresa por vender productos de una gama superior. Respecto al comportamiento de las ventas, si bien no se puede decir con exactitud que existe un comportamiento cíclico, sí existe un patrón heterogéneo. La particularidad está en que, desde abril de 2018, hubo un pick importante de ventas a nivel histórico, para luego tener una caída brutal hasta fin de año.

Las principales medidas DAX de este análisis fueron:

Facturación Promedio por Cliente: usando las funciones DIVIDE, SUM Y DISTINCT COUNT sobre columnas de la tabla Hechos y Clientes.

Ventas Totales: usando la función SUMX para multiplicar horizontalmente las 3 columnas que conforman las ventas.

Cliente Top Cantidad Dinámico: una medida que exhibe el cliente que nos ha comprado la mayor cantidad de productos (de manera histórica y por período). Usa funciones como SUMMARIZE, TOPN, SELECTCOLUMNS, CALCULATE, MAX y FILTER, junto con la creación de variables (VAR).

Clientes Segmentados Visual: se basa en la segmentación por ticket promedio ya descrita, pero se añaden funciones para poder hacer la visualización dinámica. Es necesario usar CALCULATE, DISTINCTCOUNT, VALUES Y SWITCH, de manera de poder ver la evolución de la segmentación por años.

# Análisis Producto



