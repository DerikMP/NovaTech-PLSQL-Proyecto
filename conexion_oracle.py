import tkinter as tk
from tkinter import ttk, messagebox
import oracledb

# ========================
# Conexión a la base de datos
# ========================
try:
    connection = oracledb.connect(
        user="DERIK",
        password="150604",
        dsn="localhost:1521/xe"
    )
    cursor = connection.cursor()
    print("✅ Conexión exitosa.")
except Exception as e:
    print("❌ Error de conexión:", e)
    exit()



# ========================
# Funciones CRUD Clientes
# ========================

def insertar_cliente():
    try:
        nombre = entry_nombre.get()
        apellido = entry_apellido.get()
        tipo = entry_tipo.get()
        email = entry_email.get()
        telefono = entry_telefono.get()

        cursor.callproc("PAQ_CLIENTE.insertar_cliente", [nombre, apellido, tipo, email, telefono])
        connection.commit()
        messagebox.showinfo("Éxito", "Cliente insertado correctamente.")
        listar_clientes()
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo insertar cliente: {e}")

def listar_clientes():
    try:
        ref_cursor = cursor.var(oracledb.CURSOR)
        cursor.callproc("PAQ_CLIENTE.listar_clientes", [ref_cursor])
        rows = ref_cursor.getvalue()

        for item in tree_clientes.get_children():
            tree_clientes.delete(item)

        for row in rows:
            tree_clientes.insert("", tk.END, values=row)

    except Exception as e:
        messagebox.showerror("Error", f"No se pudo listar clientes: {e}")

def buscar_cliente():
    try:
        id_cliente = int(entry_buscar_cliente.get())
        ref_cursor = connection.cursor()
        cursor.callproc("PAQ_CLIENTE.buscar_cliente", [id_cliente, ref_cursor])
        row = ref_cursor.fetchone()
        if row:
            messagebox.showinfo("Resultado", f"Cliente encontrado:\n{row}")
        else:
            messagebox.showwarning("Aviso", "Cliente no encontrado.")
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo buscar cliente: {e}")

def eliminar_cliente_seleccionado():
    try:
        seleccionado = tree_clientes.selection()
        if not seleccionado:
            messagebox.showwarning("Aviso", "Debe seleccionar un cliente en la tabla.")
            return

        item = tree_clientes.item(seleccionado[0])
        id_cliente = item['values'][0]

        confirmar = messagebox.askyesno("Confirmar eliminación",
                                        f"¿Seguro que desea eliminar al cliente con ID {id_cliente}?")
        if confirmar:
            cursor.callproc("PAQ_CLIENTE.eliminar_cliente", [id_cliente])
            connection.commit()
            messagebox.showinfo("Éxito", f"Cliente con ID {id_cliente} eliminado correctamente.")
            listar_clientes()

    except Exception as e:
        messagebox.showerror("Error", f"No se pudo eliminar cliente: {e}")


# ========================
# Funciones CRUD Contratos
# ========================
def insertar_contrato():
    try:
        id_contrato = int(entry_id_contrato.get())
        id_cliente = int(entry_id_cliente.get())
        fecha_inicio = entry_fecha_inicio.get()
        fecha_fin = entry_fecha_fin.get()
        tipo = entry_tipo_contrato.get()
        estado = entry_estado.get()

        cursor.callproc("PAQ_CONTRATO.insertar_contrato",
                        [id_cliente, fecha_inicio, fecha_fin, tipo, estado])
        connection.commit()
        messagebox.showinfo("Éxito", "Contrato insertado correctamente.")
        listar_contratos()
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo insertar contrato: {e}")

def listar_contratos():
    try:
        ref_cursor = cursor.var(oracledb.CURSOR)
        cursor.callproc("PAQ_CONTRATO.listar_contratos", [ref_cursor])
        rows = ref_cursor.getvalue()

        for item in tree_contratos.get_children():
            tree_contratos.delete(item)

        for row in rows:
            tree_contratos.insert("", tk.END, values=row)

    except Exception as e:
        messagebox.showerror("Error", f"No se pudo listar contratos: {e}")

def eliminar_contrato_seleccionado():
    try:
        seleccionado = tree_contratos.selection()
        if not seleccionado:
            messagebox.showwarning("Aviso", "Debe seleccionar un contrato en la tabla.")
            return

        item = tree_contratos.item(seleccionado[0])
        id_contrato = item['values'][0]

        confirmar = messagebox.askyesno("Confirmar eliminación",
                                        f"¿Seguro que desea eliminar el contrato con ID {id_contrato}?")
        if confirmar:
            cursor.callproc("PAQ_CONTRATO.eliminar_contrato", [id_contrato])
            connection.commit()
            messagebox.showinfo("Éxito", f"Contrato con ID {id_contrato} eliminado correctamente.")
            listar_contratos()

    except Exception as e:
        messagebox.showerror("Error", f"No se pudo eliminar contrato: {e}")

# ========================
# Funciones CRUD Técnicos
# ========================
def insertar_tecnico():
    try:
        nombre = entry_nombre_tecnico.get()
        apellido = entry_apellido_tecnico.get()
        especialidad = entry_especialidad_tecnico.get()
        email = entry_email_tecnico.get()
        cursor.callproc("PAQ_TECNICO.insertar_tecnico", [nombre, apellido, especialidad, email])
        connection.commit()
        messagebox.showinfo("Éxito", "Técnico insertado correctamente.")
        listar_tecnicos()
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo insertar técnico: {e}")

def listar_tecnicos():
    try:
        ref_cursor = cursor.var(oracledb.CURSOR)
        cursor.callproc("PAQ_TECNICO.listar_tecnicos", [ref_cursor])
        rows = ref_cursor.getvalue()
        for item in tree_tecnicos.get_children():
            tree_tecnicos.delete(item)
        for row in rows:
            tree_tecnicos.insert("", tk.END, values=row)
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo listar técnicos: {e}")

def buscar_tecnico():
    try:
        id_tecnico = int(entry_buscar_tecnico.get())
        ref_cursor = cursor.var(oracledb.CURSOR)
        cursor.callproc("PAQ_TECNICO.buscar_tecnico", [id_tecnico, ref_cursor])
        rows = ref_cursor.getvalue()
        for item in tree_tecnicos.get_children():
            tree_tecnicos.delete(item)
        if rows:
            for row in rows:
                tree_tecnicos.insert("", tk.END, values=row)
        else:
            messagebox.showwarning("Aviso", "Técnico no encontrado.")
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo buscar técnico: {e}")

def eliminar_tecnico_seleccionado():
    try:
        seleccionado = tree_tecnicos.selection()
        if not seleccionado:
            messagebox.showwarning("Aviso", "Debe seleccionar un técnico en la tabla.")
            return
        item = tree_tecnicos.item(seleccionado[0])
        id_tecnico = item['values'][0]
        confirmar = messagebox.askyesno("Confirmar eliminación", f"¿Seguro que desea eliminar al técnico con ID {id_tecnico}?")
        if confirmar:
            cursor.callproc("PAQ_TECNICO.eliminar_tecnico", [id_tecnico])
            connection.commit()
            messagebox.showinfo("Éxito", f"Técnico con ID {id_tecnico} eliminado correctamente.")
            listar_tecnicos()
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo eliminar técnico: {e}")
        
# ========================
# Ventana principal
# ========================
root = tk.Tk()
root.title("Gestión - NovaTech Solutions")
root.geometry("1000x700")
root.configure(bg="#f0f4f7")

# 🎨 Estilo moderno
style = ttk.Style(root)
style.theme_use("clam")

style.configure("Treeview",
                font=("Arial", 11),
                rowheight=28,
                background="white",
                fieldbackground="white")
style.configure("Treeview.Heading",
                font=("Arial", 12, "bold"),
                background="#4a90e2",
                foreground="white")
style.map("Treeview",
          background=[("selected", "#4a90e2")],
          foreground=[("selected", "white")])

notebook = ttk.Notebook(root)
notebook.pack(fill="both", expand=True)







# ---- TAB CLIENTES ----
frame_clientes = tk.Frame(notebook)
notebook.add(frame_clientes, text="Clientes")

# Insertar cliente
frame_insert_cliente = tk.LabelFrame(frame_clientes, text="Insertar Cliente", padx=10, pady=10)
frame_insert_cliente.pack(fill="x", padx=10, pady=5)

tk.Label(frame_insert_cliente, text="Nombre:").grid(row=0, column=0, sticky="w")
entry_nombre = tk.Entry(frame_insert_cliente)
entry_nombre.grid(row=0, column=1)

tk.Label(frame_insert_cliente, text="Apellido:").grid(row=1, column=0, sticky="w")
entry_apellido = tk.Entry(frame_insert_cliente)
entry_apellido.grid(row=1, column=1)

tk.Label(frame_insert_cliente, text="Tipo:").grid(row=2, column=0, sticky="w")
entry_tipo = tk.Entry(frame_insert_cliente)
entry_tipo.grid(row=2, column=1)

tk.Label(frame_insert_cliente, text="Email:").grid(row=3, column=0, sticky="w")
entry_email = tk.Entry(frame_insert_cliente)
entry_email.grid(row=3, column=1)

tk.Label(frame_insert_cliente, text="Teléfono:").grid(row=4, column=0, sticky="w")
entry_telefono = tk.Entry(frame_insert_cliente)
entry_telefono.grid(row=4, column=1)

btn_insertar_cliente = tk.Button(frame_insert_cliente, text="Insertar", command=insertar_cliente)
btn_insertar_cliente.grid(row=5, column=0, columnspan=2, pady=5)

# Tabla clientes
tree_clientes = ttk.Treeview(frame_clientes,
                             columns=("ID", "Nombre", "Apellido", "Tipo", "Email", "Teléfono"),
                             show="headings")
for col in ("ID", "Nombre", "Apellido", "Tipo", "Email", "Teléfono"):
    tree_clientes.heading(col, text=col)
tree_clientes.pack(fill="both", expand=True, padx=10, pady=5)

btn_listar_cliente = tk.Button(frame_clientes, text="Actualizar Lista", command=listar_clientes)
btn_listar_cliente.pack(pady=5)
btn_eliminar_cliente = tk.Button(frame_clientes, text="Eliminar Seleccionado", command=eliminar_cliente_seleccionado)
btn_eliminar_cliente.pack(pady=5)

# Buscar cliente
frame_buscar_cliente = tk.LabelFrame(frame_clientes, text="Buscar Cliente", padx=10, pady=10)
frame_buscar_cliente.pack(fill="x", padx=10, pady=5)
tk.Label(frame_buscar_cliente, text="ID Cliente:").grid(row=0, column=0, sticky="w")
entry_buscar_cliente = tk.Entry(frame_buscar_cliente)
entry_buscar_cliente.grid(row=0, column=1)
btn_buscar_cliente = tk.Button(frame_buscar_cliente, text="Buscar", command=buscar_cliente)
btn_buscar_cliente.grid(row=0, column=2, padx=5)


# ---- TAB CONTRATOS ----
frame_contratos = tk.Frame(notebook)
notebook.add(frame_contratos, text="Contratos")

# Insertar contrato
frame_insert_contrato = tk.LabelFrame(frame_contratos, text="Insertar Contrato", padx=10, pady=10)
frame_insert_contrato.pack(fill="x", padx=10, pady=5)

tk.Label(frame_insert_contrato, text="ID Contrato:").grid(row=0, column=0, sticky="w")
entry_id_contrato = tk.Entry(frame_insert_contrato)
entry_id_contrato.grid(row=0, column=1)

tk.Label(frame_insert_contrato, text="ID Cliente:").grid(row=1, column=0, sticky="w")
entry_id_cliente = tk.Entry(frame_insert_contrato)
entry_id_cliente.grid(row=1, column=1)

tk.Label(frame_insert_contrato, text="Fecha Inicio (YYYY-MM-DD):").grid(row=2, column=0, sticky="w")
entry_fecha_inicio = tk.Entry(frame_insert_contrato)
entry_fecha_inicio.grid(row=2, column=1)

tk.Label(frame_insert_contrato, text="Fecha Fin (YYYY-MM-DD):").grid(row=3, column=0, sticky="w")
entry_fecha_fin = tk.Entry(frame_insert_contrato)
entry_fecha_fin.grid(row=3, column=1)

tk.Label(frame_insert_contrato, text="Tipo Contrato:").grid(row=4, column=0, sticky="w")
entry_tipo_contrato = tk.Entry(frame_insert_contrato)
entry_tipo_contrato.grid(row=4, column=1)

tk.Label(frame_insert_contrato, text="Estado:").grid(row=5, column=0, sticky="w")
entry_estado = tk.Entry(frame_insert_contrato)
entry_estado.grid(row=5, column=1)

btn_insertar_contrato = tk.Button(frame_insert_contrato, text="Insertar", command=insertar_contrato)
btn_insertar_contrato.grid(row=6, column=0, columnspan=2, pady=5)

# Tabla contratos
tree_contratos = ttk.Treeview(frame_contratos,
                              columns=("ID Contrato", "ID Cliente", "Fecha Inicio", "Fecha Fin", "Tipo", "Estado"),
                              show="headings")
for col in ("ID Contrato", "ID Cliente", "Fecha Inicio", "Fecha Fin", "Tipo", "Estado"):
    tree_contratos.heading(col, text=col)
tree_contratos.pack(fill="both", expand=True, padx=10, pady=5)

btn_listar_contrato = tk.Button(frame_contratos, text="Actualizar Lista", command=listar_contratos)
btn_listar_contrato.pack(pady=5)
btn_eliminar_contrato = tk.Button(frame_contratos, text="Eliminar Seleccionado", command=eliminar_contrato_seleccionado)
btn_eliminar_contrato.pack(pady=5)



# ========================
# TAB TÉCNICOS
# ========================
frame_tecnicos = tk.Frame(notebook)
notebook.add(frame_tecnicos, text="Técnicos")

# Insertar técnico
frame_insert_tecnico = tk.LabelFrame(frame_tecnicos, text="Insertar Técnico", padx=10, pady=10)
frame_insert_tecnico.pack(fill="x", padx=10, pady=5)

tk.Label(frame_insert_tecnico, text="Nombre:").grid(row=0, column=0, sticky="w")
entry_nombre_tecnico = tk.Entry(frame_insert_tecnico)
entry_nombre_tecnico.grid(row=0, column=1)

tk.Label(frame_insert_tecnico, text="Apellido:").grid(row=1, column=0, sticky="w")
entry_apellido_tecnico = tk.Entry(frame_insert_tecnico)
entry_apellido_tecnico.grid(row=1, column=1)

tk.Label(frame_insert_tecnico, text="Especialidad:").grid(row=2, column=0, sticky="w")
entry_especialidad_tecnico = tk.Entry(frame_insert_tecnico)
entry_especialidad_tecnico.grid(row=2, column=1)

tk.Label(frame_insert_tecnico, text="Email:").grid(row=3, column=0, sticky="w")
entry_email_tecnico = tk.Entry(frame_insert_tecnico)
entry_email_tecnico.grid(row=3, column=1)

btn_insertar_tecnico = tk.Button(frame_insert_tecnico, text="Insertar", command=insertar_tecnico)
btn_insertar_tecnico.grid(row=4, column=0, columnspan=2, pady=5)

# Tabla técnicos
tree_tecnicos = ttk.Treeview(frame_tecnicos, columns=("ID", "Nombre", "Apellido", "Especialidad", "Email"), show="headings")
for col in ("ID", "Nombre", "Apellido", "Especialidad", "Email"):
    tree_tecnicos.heading(col, text=col)
tree_tecnicos.pack(fill="both", expand=True, padx=10, pady=5)

# Botones técnicos
btn_listar_tecnico = tk.Button(frame_tecnicos, text="Actualizar Lista", command=listar_tecnicos)
btn_listar_tecnico.pack(pady=5)

btn_eliminar_tecnico = tk.Button(frame_tecnicos, text="Eliminar Seleccionado", command=eliminar_tecnico_seleccionado)
btn_eliminar_tecnico.pack(pady=5)

# Buscar técnico
frame_buscar_tecnico = tk.LabelFrame(frame_tecnicos, text="Buscar Técnico por ID", padx=10, pady=10)
frame_buscar_tecnico.pack(fill="x", padx=10, pady=5)

tk.Label(frame_buscar_tecnico, text="ID Técnico:").grid(row=0, column=0, sticky="w")
entry_buscar_tecnico = tk.Entry(frame_buscar_tecnico)
entry_buscar_tecnico.grid(row=0, column=1)
btn_buscar_tecnico = tk.Button(frame_buscar_tecnico, text="Buscar", command=buscar_tecnico)
btn_buscar_tecnico.grid(row=0, column=2, padx=5)





# ---------------- TAB ESTADO_ORDEN ----------------
frame_estado = tk.Frame(notebook)
notebook.add(frame_estado, text="Estado Orden")

# --- Formulario para insertar ---
frame_insert_estado = tk.LabelFrame(frame_estado, text="Insertar Estado Orden", padx=10, pady=10)
frame_insert_estado.pack(fill="x", padx=10, pady=5)

tk.Label(frame_insert_estado, text="Descripción:").grid(row=0, column=0, sticky="w")
entry_descripcion_estado = tk.Entry(frame_insert_estado)
entry_descripcion_estado.grid(row=0, column=1)

def insertar_estado_orden():
    try:
        descripcion = entry_descripcion_estado.get()
        cursor.callproc("PAQ_ESTADO.insertar_estado_orden", [descripcion])
        connection.commit()
        messagebox.showinfo("Éxito", "Estado de orden insertado correctamente.")
        listar_estado_orden()
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo insertar estado de orden: {e}")

# --- Treeview para mostrar datos ---
tree_estado = ttk.Treeview(
    frame_estado,
    columns=("ID Estado", "Descripción"),
    show="headings"
)
for col in ("ID Estado", "Descripción"):
    tree_estado.heading(col, text=col)
tree_estado.pack(fill="both", expand=True, padx=10, pady=5)

# --- Funciones CRUD ---
def listar_estado_orden():
    try:
        ref_cursor = cursor.var(oracledb.CURSOR)
        cursor.callproc("PAQ_ESTADO.listar_estado_orden", [ref_cursor])
        rows = ref_cursor.getvalue()

        for item in tree_estado.get_children():
            tree_estado.delete(item)

        for row in rows:
            tree_estado.insert("", tk.END, values=row)
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo listar estados de orden: {e}")

def eliminar_estado_orden_seleccionado():
    try:
        seleccionado = tree_estado.selection()
        if not seleccionado:
            messagebox.showwarning("Aviso", "Debe seleccionar un estado en la tabla.")
            return

        item = tree_estado.item(seleccionado[0])
        id_estado = item['values'][0]

        confirmar = messagebox.askyesno("Confirmar eliminación",
                                        f"¿Seguro que desea eliminar el estado con ID {id_estado}?")
        if confirmar:
            cursor.callproc("PAQ_ESTADO.eliminar_estado_orden", [id_estado])
            connection.commit()
            messagebox.showinfo("Éxito", f"Estado con ID {id_estado} eliminado correctamente.")
            listar_estado_orden()
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo eliminar estado de orden: {e}")

# --- Botones ---
btn_insertar_estado = tk.Button(frame_insert_estado, text="Insertar", command=insertar_estado_orden)
btn_insertar_estado.grid(row=1, column=0, columnspan=2, pady=5)

btn_listar_estado = tk.Button(frame_estado, text="Actualizar Lista", command=listar_estado_orden)
btn_listar_estado.pack(pady=5)

btn_eliminar_estado = tk.Button(frame_estado, text="Eliminar Seleccionado", command=eliminar_estado_orden_seleccionado)
btn_eliminar_estado.pack(pady=5)


# ---------------- TAB LOG_TECNICO ----------------
frame_log = tk.Frame(notebook)
notebook.add(frame_log, text="Log Técnico")

# --- Formulario para insertar ---
frame_insert_log = tk.LabelFrame(frame_log, text="Insertar Log Técnico", padx=10, pady=10)
frame_insert_log.pack(fill="x", padx=10, pady=5)

tk.Label(frame_insert_log, text="ID Técnico:").grid(row=0, column=0, sticky="w")
entry_id_tecnico_log = tk.Entry(frame_insert_log)
entry_id_tecnico_log.grid(row=0, column=1)

tk.Label(frame_insert_log, text="Nombre Técnico:").grid(row=1, column=0, sticky="w")
entry_nombre_tecnico_log = tk.Entry(frame_insert_log)
entry_nombre_tecnico_log.grid(row=1, column=1)

tk.Label(frame_insert_log, text="Fecha Eliminación (YYYY-MM-DD):").grid(row=2, column=0, sticky="w")
entry_fecha_eliminacion_log = tk.Entry(frame_insert_log)
entry_fecha_eliminacion_log.grid(row=2, column=1)


def insertar_log_tecnico():
    try:
        id_tecnico = int(entry_id_tecnico_log.get())
        nombre_tecnico = entry_nombre_tecnico_log.get()
        fecha_eliminacion = entry_fecha_eliminacion_log.get()

        cursor.callproc("PAQ_LOG.insertar_log_tecnico",
                        [id_tecnico, nombre_tecnico, fecha_eliminacion])
        connection.commit()
        messagebox.showinfo("Éxito", "Log Técnico insertado correctamente.")
        listar_logs_tecnico()
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo insertar log técnico: {e}")


# --- Treeview para mostrar datos ---
tree_log = ttk.Treeview(
    frame_log,
    columns=("ID Log", "ID Técnico", "Nombre Técnico", "Fecha Eliminación"),
    show="headings"
)
for col in ("ID Log", "ID Técnico", "Nombre Técnico", "Fecha Eliminación"):
    tree_log.heading(col, text=col)
tree_log.pack(fill="both", expand=True, padx=10, pady=5)


# --- Funciones CRUD ---
def listar_logs_tecnico():
    try:
        ref_cursor = cursor.var(oracledb.CURSOR)
        cursor.callproc("PAQ_LOG.listar_logs_tecnico", [ref_cursor])
        rows = ref_cursor.getvalue()

        for item in tree_log.get_children():
            tree_log.delete(item)

        for row in rows:
            tree_log.insert("", tk.END, values=row)
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo listar logs técnicos: {e}")


def eliminar_log_tecnico_seleccionado():
    try:
        seleccionado = tree_log.selection()
        if not seleccionado:
            messagebox.showwarning("Aviso", "Debe seleccionar un log en la tabla.")
            return

        item = tree_log.item(seleccionado[0])
        id_log = item['values'][0]

        confirmar = messagebox.askyesno("Confirmar eliminación",
                                        f"¿Seguro que desea eliminar el log con ID {id_log}?")
        if confirmar:
            cursor.callproc("PAQ_LOG.eliminar_log_tecnico", [id_log])
            connection.commit()
            messagebox.showinfo("Éxito", f"Log con ID {id_log} eliminado correctamente.")
            listar_logs_tecnico()

    except Exception as e:
        messagebox.showerror("Error", f"No se pudo eliminar log técnico: {e}")


# --- Botones ---
btn_insertar_log = tk.Button(frame_insert_log, text="Insertar", command=insertar_log_tecnico)
btn_insertar_log.grid(row=3, column=0, columnspan=2, pady=5)

btn_listar_log = tk.Button(frame_log, text="Actualizar Lista", command=listar_logs_tecnico)
btn_listar_log.pack(pady=5)

btn_eliminar_log = tk.Button(frame_log, text="Eliminar Seleccionado", command=eliminar_log_tecnico_seleccionado)
btn_eliminar_log.pack(pady=5)


# ---------------- TAB ORDEN_SERVICIO ----------------
frame_orden = tk.Frame(notebook)
notebook.add(frame_orden, text="Orden Servicio")

# --- Formulario para insertar ---
frame_insert_orden = tk.LabelFrame(frame_orden, text="Insertar Orden Servicio", padx=10, pady=10)
frame_insert_orden.pack(fill="x", padx=10, pady=5)

tk.Label(frame_insert_orden, text="ID Equipo:").grid(row=0, column=0, sticky="w")
entry_id_equipo = tk.Entry(frame_insert_orden)
entry_id_equipo.grid(row=0, column=1)

tk.Label(frame_insert_orden, text="ID Técnico:").grid(row=1, column=0, sticky="w")
entry_id_tecnico = tk.Entry(frame_insert_orden)
entry_id_tecnico.grid(row=1, column=1)

tk.Label(frame_insert_orden, text="Fecha Inicio (YYYY-MM-DD):").grid(row=2, column=0, sticky="w")
entry_fecha_inicio_orden = tk.Entry(frame_insert_orden)
entry_fecha_inicio_orden.grid(row=2, column=1)

tk.Label(frame_insert_orden, text="Fecha Fin (YYYY-MM-DD):").grid(row=3, column=0, sticky="w")
entry_fecha_fin_orden = tk.Entry(frame_insert_orden)
entry_fecha_fin_orden.grid(row=3, column=1)

tk.Label(frame_insert_orden, text="Estado:").grid(row=4, column=0, sticky="w")
entry_estado_orden = tk.Entry(frame_insert_orden)
entry_estado_orden.grid(row=4, column=1)

tk.Label(frame_insert_orden, text="Tipo Servicio:").grid(row=5, column=0, sticky="w")
entry_tipo_servicio = tk.Entry(frame_insert_orden)
entry_tipo_servicio.grid(row=5, column=1)

tk.Label(frame_insert_orden, text="ID Estado:").grid(row=6, column=0, sticky="w")
entry_id_estado = tk.Entry(frame_insert_orden)
entry_id_estado.grid(row=6, column=1)


def insertar_orden():
    try:
        id_equipo = int(entry_id_equipo.get())
        id_tecnico = int(entry_id_tecnico.get())
        fecha_inicio = entry_fecha_inicio_orden.get()
        fecha_fin = entry_fecha_fin_orden.get()
        estado = entry_estado_orden.get()
        tipo_servicio = entry_tipo_servicio.get()
        id_estado_val = int(entry_id_estado.get())

        cursor.callproc("PAQ_ORDEN.insertar_orden",
                        [id_equipo, id_tecnico, fecha_inicio, fecha_fin, estado, tipo_servicio, id_estado_val])
        connection.commit()
        messagebox.showinfo("Éxito", "Orden insertada correctamente.")
        listar_ordenes()
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo insertar orden: {e}")


btn_insertar_orden = tk.Button(frame_insert_orden, text="Insertar", command=insertar_orden)
btn_insertar_orden.grid(row=7, column=0, columnspan=2, pady=5)


# --- Treeview para mostrar datos ---
tree_orden = ttk.Treeview(
    frame_orden,
    columns=("ID Orden", "ID Equipo", "ID Técnico", "Fecha Inicio", "Fecha Fin", "Estado", "Tipo Servicio", "ID Estado"),
    show="headings"
)
for col in ("ID Orden", "ID Equipo", "ID Técnico", "Fecha Inicio", "Fecha Fin", "Estado", "Tipo Servicio", "ID Estado"):
    tree_orden.heading(col, text=col)
tree_orden.pack(fill="both", expand=True, padx=10, pady=5)


# --- Funciones CRUD ---
def listar_ordenes():
    try:
        ref_cursor = cursor.var(oracledb.CURSOR)
        cursor.callproc("PAQ_ORDEN.listar_ordenes", [ref_cursor])
        rows = ref_cursor.getvalue()

        for item in tree_orden.get_children():
            tree_orden.delete(item)

        for row in rows:
            tree_orden.insert("", tk.END, values=row)
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo listar órdenes: {e}")


def eliminar_orden_seleccionada():
    try:
        seleccionado = tree_orden.selection()
        if not seleccionado:
            messagebox.showwarning("Aviso", "Debe seleccionar una orden en la tabla.")
            return

        item = tree_orden.item(seleccionado[0])
        id_orden = item['values'][0]

        confirmar = messagebox.askyesno("Confirmar eliminación",
                                        f"¿Seguro que desea eliminar la orden con ID {id_orden}?")
        if confirmar:
            cursor.callproc("PAQ_ORDEN.eliminar_orden", [id_orden])
            connection.commit()
            messagebox.showinfo("Éxito", f"Orden con ID {id_orden} eliminada correctamente.")
            listar_ordenes()

    except Exception as e:
        messagebox.showerror("Error", f"No se pudo eliminar orden: {e}")


# --- Botones ---
btn_listar_orden = tk.Button(frame_orden, text="Actualizar Lista", command=listar_ordenes)
btn_listar_orden.pack(pady=5)

btn_eliminar_orden = tk.Button(frame_orden, text="Eliminar Seleccionado", command=eliminar_orden_seleccionada)
btn_eliminar_orden.pack(pady=5)



  # ---------------- TAB DETALLE_SERVICIO ----------------
frame_detalle = tk.Frame(notebook)
notebook.add(frame_detalle, text="Detalle Servicio")

# --- Formulario para insertar ---
frame_insert_detalle = tk.LabelFrame(frame_detalle, text="Insertar Detalle Servicio", padx=10, pady=10)
frame_insert_detalle.pack(fill="x", padx=10, pady=5)

tk.Label(frame_insert_detalle, text="ID Orden:").grid(row=0, column=0, sticky="w")
entry_id_orden_detalle = tk.Entry(frame_insert_detalle)
entry_id_orden_detalle.grid(row=0, column=1)

tk.Label(frame_insert_detalle, text="Descripción:").grid(row=1, column=0, sticky="w")
entry_descripcion_detalle = tk.Entry(frame_insert_detalle)
entry_descripcion_detalle.grid(row=1, column=1)

tk.Label(frame_insert_detalle, text="Horas Trabajadas:").grid(row=2, column=0, sticky="w")
entry_horas_detalle = tk.Entry(frame_insert_detalle)
entry_horas_detalle.grid(row=2, column=1)

tk.Label(frame_insert_detalle, text="Costo Aproximado:").grid(row=3, column=0, sticky="w")
entry_costo_detalle = tk.Entry(frame_insert_detalle)
entry_costo_detalle.grid(row=3, column=1)

# --- Funciones CRUD ---
def insertar_detalle():
    try:
        id_orden = int(entry_id_orden_detalle.get())
        descripcion = entry_descripcion_detalle.get()
        horas = int(entry_horas_detalle.get())
        costo = float(entry_costo_detalle.get())

        cursor.callproc("PAQ_DETALLE_SERVICIO.insertar_detalle", [id_orden, descripcion, horas, costo])
        connection.commit()
        messagebox.showinfo("Éxito", "Detalle insertado correctamente.")
        listar_detalles()
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo insertar detalle: {e}")

def listar_detalles():
    try:
        ref_cursor = cursor.var(oracledb.CURSOR)
        cursor.callproc("PAQ_DETALLE_SERVICIO.listar_detalles", [ref_cursor])
        rows = ref_cursor.getvalue()

        for item in tree_detalle.get_children():
            tree_detalle.delete(item)

        for row in rows:
            tree_detalle.insert("", tk.END, values=row)
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo listar detalles: {e}")

def eliminar_detalle_seleccionado():
    try:
        seleccionado = tree_detalle.selection()
        if not seleccionado:
            messagebox.showwarning("Aviso", "Debe seleccionar un detalle en la tabla.")
            return

        item = tree_detalle.item(seleccionado[0])
        id_detalle = item['values'][0]

        confirmar = messagebox.askyesno("Confirmar eliminación",
                                        f"¿Seguro que desea eliminar el detalle con ID {id_detalle}?")
        if confirmar:
            cursor.callproc("PAQ_DETALLE_SERVICIO.eliminar_detalle", [id_detalle])
            connection.commit()
            messagebox.showinfo("Éxito", f"Detalle con ID {id_detalle} eliminado correctamente.")
            listar_detalles()
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo eliminar detalle: {e}")

# --- Botones ---
btn_insertar_detalle = tk.Button(frame_insert_detalle, text="Insertar", command=insertar_detalle)
btn_insertar_detalle.grid(row=4, column=0, columnspan=2, pady=5)

btn_listar_detalle = tk.Button(frame_detalle, text="Actualizar Lista", command=listar_detalles)
btn_listar_detalle.pack(pady=5)

btn_eliminar_detalle = tk.Button(frame_detalle, text="Eliminar Seleccionado", command=eliminar_detalle_seleccionado)
btn_eliminar_detalle.pack(pady=5)

# ---------------- TAB EQUIPO ----------------
frame_equipo = tk.Frame(notebook)
notebook.add(frame_equipo, text="Equipo")

# --- Formulario para insertar ---
frame_insert_equipo = tk.LabelFrame(frame_equipo, text="Insertar Equipo", padx=10, pady=10)
frame_insert_equipo.pack(fill="x", padx=10, pady=5)

tk.Label(frame_insert_equipo, text="ID Cliente:").grid(row=0, column=0, sticky="w")
entry_id_cliente_equipo = tk.Entry(frame_insert_equipo)
entry_id_cliente_equipo.grid(row=0, column=1)

tk.Label(frame_insert_equipo, text="Tipo:").grid(row=1, column=0, sticky="w")
entry_tipo_equipo = tk.Entry(frame_insert_equipo)
entry_tipo_equipo.grid(row=1, column=1)

tk.Label(frame_insert_equipo, text="Marca:").grid(row=2, column=0, sticky="w")
entry_marca_equipo = tk.Entry(frame_insert_equipo)
entry_marca_equipo.grid(row=2, column=1)

tk.Label(frame_insert_equipo, text="Modelo:").grid(row=3, column=0, sticky="w")
entry_modelo_equipo = tk.Entry(frame_insert_equipo)
entry_modelo_equipo.grid(row=3, column=1)

tk.Label(frame_insert_equipo, text="Nro Serie:").grid(row=4, column=0, sticky="w")
entry_nro_serie_equipo = tk.Entry(frame_insert_equipo)
entry_nro_serie_equipo.grid(row=4, column=1)

tk.Label(frame_insert_equipo, text="Fecha Ingreso (YYYY-MM-DD):").grid(row=5, column=0, sticky="w")
entry_fecha_ingreso_equipo = tk.Entry(frame_insert_equipo)
entry_fecha_ingreso_equipo.grid(row=5, column=1)

# --- Funciones CRUD ---
def insertar_equipo():
    try:
        id_cliente = int(entry_id_cliente_equipo.get())
        tipo = entry_tipo_equipo.get()
        marca = entry_marca_equipo.get()
        modelo = entry_modelo_equipo.get()
        nro_serie = int(entry_nro_serie_equipo.get())
        fecha_ingreso = entry_fecha_ingreso_equipo.get()

        cursor.callproc("PAQ_EQUIPO.insertar_equipo", [id_cliente, tipo, marca, modelo, nro_serie, fecha_ingreso])
        connection.commit()
        messagebox.showinfo("Éxito", "Equipo insertado correctamente.")
        listar_equipos()
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo insertar equipo: {e}")

def listar_equipos():
    try:
        ref_cursor = cursor.var(oracledb.CURSOR)
        cursor.callproc("PAQ_EQUIPO.listar_equipos", [ref_cursor])
        rows = ref_cursor.getvalue()

        for item in tree_equipo.get_children():
            tree_equipo.delete(item)

        for row in rows:
            tree_equipo.insert("", tk.END, values=row)
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo listar equipos: {e}")

def eliminar_equipo_seleccionado():
    try:
        seleccionado = tree_equipo.selection()
        if not seleccionado:
            messagebox.showwarning("Aviso", "Debe seleccionar un equipo en la tabla.")
            return

        item = tree_equipo.item(seleccionado[0])
        id_equipo = item['values'][0]

        confirmar = messagebox.askyesno("Confirmar eliminación",
                                        f"¿Seguro que desea eliminar el equipo con ID {id_equipo}?")
        if confirmar:
            cursor.callproc("PAQ_EQUIPO.eliminar_equipo", [id_equipo])
            connection.commit()
            messagebox.showinfo("Éxito", f"Equipo con ID {id_equipo} eliminado correctamente.")
            listar_equipos()
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo eliminar equipo: {e}")

# --- Botones ---
btn_insertar_equipo = tk.Button(frame_insert_equipo, text="Insertar", command=insertar_equipo)
btn_insertar_equipo.grid(row=6, column=0, columnspan=2, pady=5)

btn_listar_equipo = tk.Button(frame_equipo, text="Actualizar Lista", command=listar_equipos)
btn_listar_equipo.pack(pady=5)

btn_eliminar_equipo = tk.Button(frame_equipo, text="Eliminar Seleccionado", command=eliminar_equipo_seleccionado)
btn_eliminar_equipo.pack(pady=5)




# ========================
# Cargar listas iniciales
# ========================
listar_clientes()
listar_contratos()
listar_tecnicos()

# Ejecutar GUI
root.mainloop()

# ========================
# Cerrar conexión al salir
# ========================
cursor.close()
connection.close()
