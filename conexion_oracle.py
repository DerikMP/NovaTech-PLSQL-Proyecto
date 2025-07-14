import oracledb

# Conexión a Oracle
connection = oracledb.connect(
    user="DERIK",
    password="150604",
    dsn="localhost:1521/xe"
)

# Crear un cursor para ejecutar sentencias SQL
cursor = connection.cursor()

# Ejecutar una consulta de prueba
cursor.execute("SELECT * FROM CLIENTE")

# Mostrar resultados
for row in cursor:
    print(row)

# Cerrar conexión
cursor.close()
connection.close()
