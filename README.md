##1.EXPLICACIÓN DEL MODELO DE DATOS

La base de datos esta compuesto por 6 tablas(entidades):

- clientes: usuarios que publican proyectos en la plataforma.
- freelancers: profesionales independientes con su especialidad y tarifa por hora.
- proyectos: trabajos publicados por los clientes con presupuesto y fecha límite.
- postulaciones: registro de cuando un freelancer aplica a un proyecto.
- asignaciones: postulación ganadora seleccionada por el cliente.
- pagos: pagos parciales realizados por cada proyecto

##2.DECISIONES DE DISEÑO TOMADAS
-'clientes':esta entidad se agrego ya que en el documento se menciona a cliente 
-los identificadores primary key usan AUTO_INCREMENT para que mysql lo genere automaticamente y evitar errores a futuro.
-El modelo cumple con la Tercera forma Normal(3FN) eliminando la redundancia que se encuentran en las tablas dadas como repetir datos existentes

##3. INSTRUCCIONES DE COMO EJECUTAR LOS SCRIPTS

1.Abrir XAMP 
2.Dar en start tanto en apache como sql
3.En la linea de mysql dar clik en admin para ingresar a php admin.
4.En la parte izquierda en el panel dar click en 'crear base de datos '
4.En la parte superior seleccionar el cuadro de SQL e ingresar el contenido.
5.Pegar  y ejecutar el contenido de schema.sql para crear todas las 6 entidades(tablas)
6.Pegar y ejecutar el contenido de inserts.sql para que en cada entidad en la parte de los atributos se inserte la información.
7.Pegar  y ejecutar el contenido de reportes.sql ya que esto mostrara los resportes y busquedas

##4 COMO SE CUMPLIÓ CON EL PORCENTAJE DE CONSULTAS QUE USAN LEFT JOIN O SUBCONSULTAS

-consulta 1 -

llamamos la tabla base freelancers y unimos con postulaciones (en este caso el left join postulaciones  nos asegura que incluso si un freelancer no tiene postulaciones nos mostrará null), y unimos left join  asignaciones (igual mostrara null si hay postulaciones no asginadas), luego, llamamos a group by para evitar filas duplicadas 

-consulta 2 - 

llamamos columna titulo de proyectos, traemos tambien nombre de freelancers y lo renombramos como "freelancer_asignado", si no hay freelancer asignado se muestra NULL. 

hacemos una subconsulta correlacionada, por cada proyecto de consulta, entra a la tabla de pagos y sumamos los montos que correspondan (el coalesce convierte el resultado en 0 si no hay pagos), de la tabla proyectos y unimos con postulaciones (usando left on para que si no hay postulaciones nos aparezca null), unimos postulaciones con asignaciones (usamos left join otra vez) y funalmente el ultumo left join freelancers para poder traer los nombres. 

usamos la condicion WHERE para filtrar solo las filas que si tuvieron asignaciono proyectos q no tienen ninguna postulacion asi garantizamos que aparezcan tanto los proyectos como freenlancers asignados como proyectos que nadie ha postulado. 

-consulta 3 - 

traemos el nombre del freelanccer, y usamos DISTINCT para evitar que aparezca repetido si postulo a varios protyecos. 

Aqui usamos inner join porque queremos ver solo los freelancer que postularon (al menos una vez) y usamos NOT EXIST (que opera por postulacion) para revisar si no existe alguna asignacion para cada postulacion. 

-consulta 4 - 

traemos titulo y presupuesto maximo de cada proyecto de la tabla proyectos (p), y funciones para determinar la propuesta más alta y más baja, y si el proyecto no recibió postulacion devolvemos NULL

usamos LEFT JOIN para que los proyectos sin postulaciones tambien aparezcan en el resultado y agrupamos con GROUP BY por proyecto (para que MAX y MIN se calculen por cada proyecto) y agregamos titulo y presupuesto_maximo

-Consulta 5  -

traemos el nombre del cliente de la tabla clientes, y usamos COUNT para saber cuantos proyectos tiene cada cliente, (no usamos * porque eso contaría todas las filas incluyendo NULL, y count(p.id_proyecto) cuenta filas donde id_proyecto no es null, asi que clientes sin proyectos contará 0

usamos left join para que todos los clientes aparezcan (aunque no tengas proyectos) y los clientes sin proyectos tendrán NULL.

finalmente agrupamos ppor cliente para que count se calcule individualmente para cada uno. 

-Consulta 6 -

traemos el nombre, especialidad y tarifa de la tabla de freelancer, (le damos alias de f1 porque necesitaremos referenciar más adelante)

usamos Where tarifa_hora > para filtrar solo los freelancers que cumplan con la tarifa de la condicion que hacemos en subconsulta. 

y usamos una subconsulta correlacionada (select AVG(tarifa_hora) ... por cada freelancer de f1, entra a f2 y calculamos el promedio (solo de los freelancer con la misma espacialidad) 

-Consulta 7 - 

traemos titulo, presupuesto máximo y suma de los pagos del proyecto, usamos SUM para acumular todos los montos pagados por proyecto. 

Usamos INNER JOIN porque solo queremos ver los que tienen pagos registrados, (inner join nos ayuda a descartar proyectos sin pagos)luego agrupamos (GROUP BY)  para calcular el total pagado por cada proyecto. 

y filtramos los grupos donde el total pagado no alcanza el presupuesto (usamos having y no where porque estamos filtrando un valor agregado, WHERE filtra filas individuales antes de agrupar
HAVING filtra grupos después de la agregación)

-Consulta 8  - 

traemos todos los freelancers con tres valores calculados, mediante subconsultas correlacionadas en el S,ELECT (la primera subconsulta cuenta cuántas postulaciones hizo, la segunda subconsulta cuenta sus asignaciones) unimos asignaciones con postulaciones para poder filtrar por freelancer( ya que la tabla asignaciones no tiene directamente ese dato)
y la tercera subconsulta suma los pagos de los proyectos donde el freelancer fue asignado. 

Usamos IN con una subconsulta interna para obtener primero los proyectos asignados al freelancer y luego
sumar sus pagos sin duplicarlos.

y COALESCE convierte el resultado a 0 si el freelancer no tiene pagos asociados.

