import oracledb

# ========================
# Conexión a la base de datos
# ========================
connection = oracledb.connect(
    user="DERIK",
    password="150604",
    dsn="localhost:1521/xe"
)

print("✅ Conexión exitosa.\n")

cursor = connection.cursor()

# ========================
# Funciones
# ========================

def insertar_cliente():
    nombre = input("Ingrese nombre del cliente: ")
    apellido = input("Ingrese apellido del cliente: ")
    tipo = input("Ingrese tipo de cliente (PERSONA/EMPRESA): ")
    email = input("Ingrese correo del cliente: ")
    telefono = int(input("Ingrese teléfono del cliente: "))

    try:
        cursor.callproc("PAQ_CLIENTE.insertar_cliente", [nombre, apellido, tipo, email, telefono])
        connection.commit()
        print("✅ Cliente insertado correctamente.\n")
    except Exception as e:
        print("❌ Error al insertar cliente:", e, "\n")

def listar_clientes():
    try:
        ref_cursor = cursor.var(oracledb.CURSOR)  # cursor de salida
        cursor.callproc("PAQ_CLIENTE.listar_clientes", [ref_cursor])
        print("===== LISTA DE CLIENTES =====")
        for row in ref_cursor.getvalue():
            print(row)
        print()
    except Exception as e:
        print("❌ Error al listar clientes:", e, "\n")

def buscar_cliente():
    try:
        id_cliente = int(input("Ingrese ID del cliente a buscar: "))
        ref_cursor = cursor.var(oracledb.CURSOR)
        cursor.callproc("PAQ_CLIENTE.buscar_cliente", [id_cliente, ref_cursor])
        row = ref_cursor.getvalue().fetchone()
        if row:
            print("✅ Cliente encontrado:", row, "\n")
        else:
            print("⚠️ Cliente no encontrado.\n")
    except Exception as e:
        print("❌ Error al buscar cliente:", e, "\n")

def eliminar_cliente():
    try:
        id_cliente = int(input("Ingrese ID del cliente a eliminar: "))
        cursor.callproc("PAQ_CLIENTE.eliminar_cliente", [id_cliente])
        connection.commit()
        print("✅ Cliente eliminado correctamente.\n")
    except Exception as e:
        print("❌ Error al eliminar cliente:", e, "\n")

# ========================
# Menú principal
# ========================
while True:
    print("===== MENÚ CLIENTES =====")
    print("1. Insertar cliente")
    print("2. Listar clientes")
    print("3. Buscar cliente por ID")
    print("4. Eliminar cliente")
    print("5. Salir")

    opcion = input("Seleccione una opción: ")

    if opcion == "1":
        insertar_cliente()
    elif opcion == "2":
        listar_clientes()
    elif opcion == "3":
        buscar_cliente()
    elif opcion == "4":
        eliminar_cliente()
    elif opcion == "5":
        print("👋 Saliendo del sistema...")
        break
    else:
        print("⚠️ Opción inválida.\n")

# ========================
# Cerrar conexión
# ========================
cursor.close()
connection.close()
