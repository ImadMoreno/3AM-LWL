--Ejercicio1
drop database if exists suministrosProfe;

create database suministrosProfe;

use suministrosProfe;

create table proveedores (
    nif varchar(9) primary key,
    nombre varchar(20) not null,
    direccion varchar(20)
);

create table productos (
    codigo tinyint unsigned auto_increment primary key,
    nombre varchar(20) not null,
    precio decimal(6,2) not null,
    nif_proveedor varchar(9),
    foreign key (nif_proveedor) references proveedores(nif)
        on update cascade
        on delete restrict
);

create table clientes (
    dni varchar(9) primary key,
    nombre varchar(20) not null,
    apellidos varchar(20) not null,
    fecha_nac date,
    direccion varchar(40)
);

create table compras (
    dni_cliente varchar(9),
    codigo_producto tinyint unsigned,
    primary key (dni_cliente,codigo_producto),
    foreign key (dni_cliente) references clientes (dni),
    foreign key (codigo_producto) references productos(codigo)
);