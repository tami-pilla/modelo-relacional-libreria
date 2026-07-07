

CREATE TABLE autores (
    id_autor SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(50)
);

CREATE TABLE editoriales (
    id_editorial SERIAL PRIMARY KEY,
    nombre_editorial VARCHAR(100) NOT NULL,
    pais VARCHAR(50) NOT NULL
);

CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);

CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    fecha_alta DATE NOT NULL
);

CREATE TABLE sucursales (
    id_sucursal SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    barrio VARCHAR(50) NOT NULL, 
    email VARCHAR(100) NOT NULL
);

CREATE TABLE libros (
    id_libro SERIAL PRIMARY KEY,
    id_editorial INT NOT NULL,
    id_categoria INT NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    precio NUMERIC(10,2) NOT NULL,

    CONSTRAINT fk_libros_editoriales
        FOREIGN KEY (id_editorial)
        REFERENCES editoriales(id_editorial),

    CONSTRAINT fk_libros_categorias
        FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria)
);

CREATE TABLE libros_autores (
    id_libro INT NOT NULL,
    id_autor INT NOT NULL,

    PRIMARY KEY (id_libro, id_autor),

    CONSTRAINT fk_la_libro
        FOREIGN KEY (id_libro)
        REFERENCES libros(id_libro),

    CONSTRAINT fk_la_autor
        FOREIGN KEY (id_autor)
        REFERENCES autores(id_autor)
);

CREATE TABLE stock_sucursal (
    id_stock SERIAL PRIMARY KEY,
    id_libro INT NOT NULL,
    id_sucursal INT NOT NULL,
    cantidad INT NOT NULL,

    CONSTRAINT fk_stock_libro
        FOREIGN KEY (id_libro)
        REFERENCES libros(id_libro),

    CONSTRAINT fk_stock_sucursal
        FOREIGN KEY (id_sucursal)
        REFERENCES sucursales(id_sucursal)
);

CREATE TABLE ventas (
    id_venta SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_sucursal INT NOT NULL,
    fecha_venta DATE NOT NULL,
    medio_pago VARCHAR(30) NOT NULL,
    total NUMERIC(10,2) NOT NULL,

    CONSTRAINT fk_ventas_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),

    CONSTRAINT fk_ventas_sucursal
        FOREIGN KEY (id_sucursal)
        REFERENCES sucursales(id_sucursal)
);

CREATE TABLE detalle_ventas (
    id_detalle SERIAL PRIMARY KEY,
    id_venta INT NOT NULL,
    id_libro INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario NUMERIC(10,2) NOT NULL,
    subtotal NUMERIC(10,2) NOT NULL,

    CONSTRAINT fk_detalle_venta
        FOREIGN KEY (id_venta)
        REFERENCES ventas(id_venta),

    CONSTRAINT fk_detalle_libro
        FOREIGN KEY (id_libro)
        REFERENCES libros(id_libro)
);