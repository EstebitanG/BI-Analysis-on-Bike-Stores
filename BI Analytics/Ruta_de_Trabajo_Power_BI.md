## Fase 2: Análisis en Power BI

Modelo de Datos en Power BI

Se importó el modelo Estrella desarrollado en MySQL, con los mismos roles. Inicialmente no se tuvieron que hacer cambios importantes en
Power Query, dada la limpieza hecha en la herramienta ya mencionada.

Medidas principales en DAX

Se realizaron medidas con el lenguaje DAX para sacar métricas claves de negocio. Las más destacables son:

-Segmento Ticket Promedio: donde clasificamos a los clientes en base a su monto de compra, formando 4 clasificaciones (VIP, Premium, Promedio y Básico)

-Ventas Totales: multiplicación de precio por cantidad, añadiéndole el descuento correspondiente.

-Facturación promedio por cliente: una medida que divide las ventas totales por el total de clientes.

-Rotación promedio de inventario: representa cuantas veces las ventas de la empresa superaron su inversión en inventario.

Estas y demás medidas se ahondarán en los análisis de clientes, productos y geográficos.

# Análisis de Clientes

<img width="858" height="480" alt="Analisis_Clientes_Final" src="https://github.com/user-attachments/assets/5747e00f-9e52-46c8-b2b4-639b36265d0a" />

En el análisis de clientes, podemos observar métricas como Facturación Promedio por Cliente, Top 10 Clientes por Ventas, cantidad de clientes por segmento (clasificando por facturación) y el comportamiento de ventas totales con granularidad año-mes. Al interactuar con estos gráficos dinámicos, se puede observar que la mayoria de nuestra ventas provenían desde un principio de nuestros clientes Básico y Promedio (facturación menor a $10.000 USD), pero al pasar los años, los clientes tipo Premium y VIP empiezan a tomar un porcentaje importante de nuestro total de ventas, que puede señalar los esfuerzos de la empresa por vender productos de una gama superior. Respecto al comportamiento de las ventas, si bien no se puede decir con exactitud que existe un comportamiento cíclico, sí existe un patrón heterogéneo. La particularidad está en que, desde abril de 2018, hubo un pick importante de ventas a nivel histórico, para luego tener una caída brutal hasta fin de año.

Las principales medidas DAX de este análisis fueron:

Facturación Promedio por Cliente: usando las funciones DIVIDE, SUM Y DISTINCT COUNT sobre columnas de la tabla Hechos y Clientes.

Ventas Totales: usando la función SUMX para multiplicar horizontalmente las 3 columnas que conforman las ventas.

Cliente Top Cantidad Dinámico: una medida que exhibe el cliente que nos ha comprado la mayor cantidad de productos (de manera histórica y por período). Usa funciones como SUMMARIZE, TOPN, SELECTCOLUMNS, CALCULATE, MAX y FILTER, junto con la creación de variables (VAR).

Clientes Segmentados Visual: se basa en la segmentación por ticket promedio ya descrita, pero se añaden funciones para poder hacer la visualización dinámica. Es necesario usar CALCULATE, DISTINCTCOUNT, VALUES Y SWITCH, de manera de poder ver la evolución de la segmentación por años.

# Análisis Producto

<img width="835" height="480" alt="Analisis_Producto_Final" src="https://github.com/user-attachments/assets/b466d341-38ed-4968-9a9f-c11d7bafc410" />

Respecto al Análisis Producto, podemos observar métricas como ventas totales, categoría de producto más vendida, Top Productos por mayor venta total, porcentaje de ventas por categoría, comportamiento top 3 productos más vendidos, rotación promedio global de inventario y la matriz de crecimiento porcentual (pre abril 2018). Estas visualizaciones dinámicas nos ofrecen información complementaria con el análisis clientes: en este caso, podemos observar que la categoría más vendida en términos globales son las Mountain Bikes, con un 35,31%. Podemos observar también que la marca Trek es la líder en ventas de esta tienda, consolidándose en los segmentos promedio, premium y VIP. Podemos ver que el comportamiento de los 3 productos más vendidos ha ido reduciéndose notablemente al pasar los quarters. Tenemos una rotación promedio global de inventario de 0.52, lo que señala que las ventas del giro de esta empresa representaron 0.52 veces lo que la empresa invirtió en sus inventarios. Este ratio se puede profundizar con la matriz de crecimiento porcentual, la cual se asemeja a una matriz BCG, pero en vez de hablar de participación relativa de mercado y crecimiento en ventas, hablamos de cantidad vendida histórica del producto y variación interanual de ventas (%). Bajo estos ejes, se definen 4 segmentos estratégicos de productos:

-Producto Estrella: producto que posee una variación interanual de ventas superior a la media, y una cantidad de ventas histórica superior a la media. Estos productos son y han sido populares por un tiempo considerable, y poseen un comportamiento creciente en sus ventas. 

-Producto Potencial: producto que posee una variación interanual de ventas superior a la media, y una cantidad de ventas histórica inferior a la media. Estos productos muestran un crecimiento reciente de sus ventas, pero no han sido explotados en su totalidad.

-Producto Alta Rotación: producto que posee una variación interanual de ventas inferior a la media, y una cantidad de ventas histórica superior a la media. Estos productos han sido demandados históricamente por los segmentos de clientes, pero muestran una variación interanual de crecimiento de ventas decreciente. Son productos que se compran pero cada vez menos, y que le sirven a la empresa como fuente de liquidez temporal.

-Producto "Necesita Impulso": producto que posee una variación interanual de ventas inferior a la media, y una cantidad de ventas histórica inferior a la media. Estos productos decrecen, y a la vez no son ni han sido populares entre los clientes. Pueden corresponder a productos de una gama muy especial o con un comportamiento atípico en las ventas.

Fijándonos en la matriz, hay que tomar en cuenta el siguiente supuesto: se eliminó de su construcción la información posterior a abril de 2018, donde sucede la abismal caída en las ventas, de manera de capturar el comportamiento de los productos antes de un evento que podríamos considerar irregular. Sin embargo, aún bajo este supuesto, la mayoría de productos de la compañía caen en la categoría de productos que necesitan impulso: baja cantidad histórica vendida y variación interanual decreciente en las ventas. Esta es una señal de alarma para la compañía, y confirma el comportamiento del año 2018: la empresa tiene un comportamiento errático y decreciente en sus ventas, lo que podemos corroborar al comparar las ventas de 2016 (2,43 millones de USD), 2017 (3,45 millones de USD) y 2018 (1,81 millones de USD). La mayoría de sus productos rotan poco y venden poco respecto a la media, y si bien hablamos de bicicletas (producto duradero de compra comparada) una rotación baja y ventas decrecientes (que después se condicen con poca retención y fidelización) no es deseable. A su vez, la empresa cuenta con solo 1 producto potencial, y ningún producto estrella, lo cual está en línea con lo anterior.

Las principales medidas DAX de este análisis fueron:

-Categoría más vendida: medida que nos muestra la categoría top. Usa SUMMARIZE, MAXX, CALCULATE Y FILTER, junto con la creación de variables.

-Ventas totales (ya explicadas en análisis cliente).

-Comportamiento Top 3 Productos más vendidos: si bien esta es una tabla y no una medida, requirió de la creación de una tabla "Calendario", fundamental para hacer análisis de tiempo. En esta tabla se definen distintas granularidades de fecha para personalizar comportamientos temporales. Se relaciona con nuestra tabla de Hechos mediante Date.

-Rotación Promedio Global Inventario: para este ratio, se adaptó la razón clásica de rotación con las ventas y el inventario (dado que no contamos con el costo de ventas). Usa CALCULATE, SUM Y DIVIDE.

-Matriz Crecimiento %: se usan 3 medidas principales -> 
Cantidad_Total_Vendida: donde usamos un SUM con order_quantity filtrando por Calendario[date] para tomar valores anteriores a abril de 2018.

->Variación interanual Dinámica: donde tomamos medidas de ventas que seleccionan meses particulares para que se comparen de forma interanual. Para ello se usan funciones como SAMEPERIODLASTYEAR y KEEPFILTERS.

->Segmento_Estratégico: donde es necesario hacer un SWITCH para clasificar a los productos según los ejes definidos por la matriz, y usando las 2 medidas anteriores.

# Análisis Geográfico

<img width="837" height="473" alt="Analisis_Geografico_Final" src="https://github.com/user-attachments/assets/a35b9be9-35b8-49ff-b83c-5a0849bf0c4c" />

Respecto al análisis geográfico, podemos visualizar la concentración de clientes en los 3 estados en los que opera la tienda: California (CA), Texas (TX) y Nueva York (NY). Se puede ver que la ciudad con mayores ventas de manera histórica es Mount Vernon, y que la mayoría de las ciudades con mayores ventas provienen de Nueva York, que se lleva el 67.83% de los clientes en total. Podemos filtrar por segmento de clientes y categoría de producto, para saber el comportamiento particular de cada grupo. 

En este análisis geográfico, al ser más visual, no se calcularon nuevas medidas respecto a los análisis anteriores. Sin embargo, fue necesario concatenar correctamente la ciudad con el estado para que el motor de geolocalización de Bing pudiera identificar correctamente la ubicación de los clientes. Un análisis más certero podría haber sido usar la dirección exacta de cada cliente, pero para ello eran necesarias herramientas externas a Power BI, lo cual representa una limitación en este análisis.

# Conclusiones 

<img width="855" height="479" alt="Conclusion_final" src="https://github.com/user-attachments/assets/2ae51bc7-500f-496d-b9f9-4105a9aa12f1" />

En el apartado de las conclusiones, luego de haber explorado los 3 apartados principales del negocio, podemos repasar métricas fundamentales, a su vez de explorar nuevas que las complementen.

Se poseen 1445 clientes a lo largo de la historia de la tienda, de los cuales la mayoría corresponden a clientes básico y promedio. De los 315 productos que la empresa ha poseído en inventario, 42 no han sido recomprados. La variación anual % en ventas a sido de -47,36%, lo que refleja una tendencia a la baja en todos sus productos de manera general. La empresa posee una tasa de retención de clientes de un 9.07%, lo que se condice en gran parte con la baja rotación de su catálogo y sus ventas decrecientes. Sus ventas se concentran bastante en un solo estado (NY), y no se han desarrollado suficiente los segmentos Premium y VIP, que pueden representar un potencial considerable de aumento de márgenes de la empresa.

Teniendo esta información presente, y tal como aparece en los cuadros de texto del dashboard, podemos intuir:

A través del análisis de clientes, productos y geografía, se identifican patrones críticos que limitan el crecimiento sostenible del negocio. La caída en las ventas no responden solo a estacionalidad, sino también:

-Un modelo centrado en ventas únicas sin estrategias de recompra.

-Ciclos de vida del producto muy breves, sin continuidad en el catálogo.

-Falta de retención de clientes y rotación pobre de productos.

-Concentración geográfica que podría ampliarse a nuevas estrategias.

Este análisis no busca predecir, sino diagnosticar estructuralmente la situación actual de la empresa los últimos 3 años, que permita tomar acciones para un modelo más sostenible a largo plazo.

Siguientes pasos sugeridos:

-Explorar campañas de retención y fidelización de clientes.

-Diversificar catálogo con productos complementarios y servicios de mantención.

-Incentivar recompras con promociones personalizadas.

-Ampliar mercado geográfico con presencia online.

Las principales medidas DAX de este análisis fueron:

-Variación Anual % Ventas = usando DIVIDE y medidas calculadas con anterioridad que reflejaban las ventas del año actual y anterior.

-Productos sin recompra = productos que se vendieron 1 sola vez. Se usó CALCULATE, DISTINCTCOUNT, FILTER Y VALUES, junto con una medida calculada con anterioridad, para identificar estos productos mediante su ID.

-Tasa Retención Clientes % = se usan FORMAT y DIVIDE para calcular una razón entre clientes retenidos y clientes únicos. Los clientes únicos son un COUNT de los clientes. En el caso de los clientes retenidos, se usan CALCULATE, DISTINCTCOUNT, FILTER Y VALUES para contar los clientes que nos han comprado más de una vez. Es un criterio pesimista, del cual nos aparece un resultado desfavorable (si subieramos el criterio ej. > 5, la tasa de retención hubiera sido aún menor).

# Limitaciones del proyecto

Este proyecto de modelado de datos y analítica de negocios usando MySQL y Power BI sirve principalmente para diagnosticar la situación pasada del negocio de bicicletas, no es un dataset orientado a predicción robusta ni modelos avanzados de Machine Learning.

A su vez, si bien el dataset cuenta con información suficiente para sacar métricas útiles para el área comercial, se queda corto para sacar métricas clave como Valor de Vida del Cliente (CLTV), márgenes de contribución, tasas de adopción de nuevos productos, comportamiento de ventas online vs offline, y análisis de Time Intelligence. Si bien se mencionó que la mayoría de estas limitaciones son una debilidad de la empresa al tener poca retención y baja rotación de productos, haber tenido un comportamiento más marcado de estos factores que son tan clave para el área comercial podría haber enriquecido el análisis. 

Al mismo tiempo, el comportamiento irregular y errático de las ventas impiden hacer un análisis de sensibilidad de las variables de interés principales (precio, cantidad, periodo del año, entre otras), de manera de no solamente poder predecir comportamientos futuros, sino también entender parte del efecto de los determinantes actuales en los KPIs calculados.

Por otro lado, el hecho de no poder haber geolocalizado a los clientes con mayor precisión usando una herramienta externa, nos limita a sacar conclusiones respecto al comportamiento geográfico real de los clientes. Si bien en las conclusiones no afecta mucho, entender con mayor precisión este apartado puede darnos una mejor idea de cómo se comportan los clientes, en este caso en EEUU. Sin embargo, el uso de una herramienta externa a Power BI (junto con MySQL y Python) escapa del propósito de este proyecto.

Por último, los KPIs y medidas calculadas no tienen otra base de comparación que la evolución temporal de la misma empresa. No tenemos información de la competencia directa de la tienda de bicicletas, ni información del contexto económico de la época y cómo pudo haberle afectado directamente, ni tampoco estándares de la industria en la que se desenvuelve para evaluar el rendimiento en términos relativos.

# Lecciones Aprendidas

Esta es una breve reflexión personal que trata sobre lo que significó abordar este proyecto de inicio a fin, resaltando los principales aprendizajes.

En términos técnicos, este proyecto me permitió desenvolverme aún más con la herramienta de MySQL, poniendo en práctica sus comandos y sintaxis en un proyecto práctico. Ahondo en lo que es el modelado de datos y la importancia de esta fase en un proyecto de analítica de datos para un correcto procesamiento posterior, entendiendo el formato de los datos y cómo relacionarlos coherentemente.

Respecto a Power BI, este proyecto logra adentrarme de lleno en sus funcionalidades más importantes, interactuar con sus visualizaciones dinámicas para presentar KPIs relevantes desarrollando criterio de cuál visualización es más adecuada para cada situación, y lo más importante, familiarizarme con el lenguaje DAX llegando a un nivel intermedio del mismo, fundamental para lograr análisis más complejos y adaptados a los requerimientos del área. 

En términos de analista de datos BI, haber obtenido un dataset de estas características representó un desafío que logró desarrollar pensamiento crítico, ya que en un momento no se contaba con la información suficiente o "ideal" para sacar los insights más atractivos, sin embargo, esto no representó una limitación sino una oportunidad para saber leer el contexto completo de un negocio, identificando fortalezas y debilidades de manera de poder proponer planes de acción.
