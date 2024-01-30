create database tiendasProductos character set utf8mb4 collate utf8mb4_spanish2_ci;

use tiendasProductos;

create table tiendas (
    nif char(10) primary key,
    nombre varchar(20) not null,
    direccion varchar(20) not null,
    poblacion varchar(20) not null,
    provincia varchar(20) not null,
    codPostal smallint not null
);

create table fabricantes (
    cod_fabricante int not null,
    nombre varchar(15),
    pais varchar(15),
    constraint pk_fabricantes primary key(cod_fabricante)
);

create table articulos(
    articulo char(20) not null,
    cod_fabricante int not null,
    peso float not null,
    categoria enum('primera', 'segunda', 'tercera'),
    precio_venta decimal(8,2),
    precio_costo decimal(8,2),
    stock int,
    constraint pk_articulos primary key (articulo, cod_fabricante,peso,categoria),
    constraint fk_articulos_fabricantes foreign key (cod_fabricante) references fabricantes(cod_fabricante)
        on update cascade
        on delete restrict
);

create table pedidos (
    nif char(10) not null,
    articulo varchar(10) not null,
    cod_fabricante int not null,
    peso float not null,
    categoria enum('primera', 'segunda', 'tercera') not null,
    fecha_pedido date not null,
    unidades_pedidas int,
    primary key (nif, articulo, cod_fabricante, peso, categoria,fecha_pedido),
    foreign key (cod_fabricante) references fabricantes(cod_fabricante),
    foreign key (articulo,cod_fabricante,peso,categoria) references articulos(articulo, cod_fabricante,peso,categoria)
        on update cascade
        on delete cascade,
    foreign key (nif) references tiendas(nif)
);

create table ventas (
    nif char(10) not null,
    articulo varchar(10) not null,
    cod_fabricante int not null,
    peso float not null,
    categoria enum('primera', 'segunda', 'tercera') not null,
    fecha_venta date not null,
    unidades_vendidas int,
    primary key (nif, articulo, cod_fabricante, peso, categoria,fecha_venta),
    foreign key (cod_fabricante) references fabricantes(cod_fabricante),
    foreign key (articulo,cod_fabricante,peso,categoria) references articulos(articulo, cod_fabricante,peso,categoria)
        on update cascade
        on delete cascade,
    foreign key (nif) references tiendas(nif)
);

/*ejercicio3*/
alter table pedidos add column precio_pedido decimal(8,2);
alter table ventas add column precio_ventas decimal(8,2);

/*ejercicio4*/
alter table  articulos rename column stock to existencias;

/*ej5*/
rename table tiendas to clientes;

/*ej6*/
alter table pedidos 
    drop foreign key pedidos_ibfk_1,
    drop foreign key pedidos_ibfk_2;

alter table pedidos 
    drop column cod_fabricante,
    drop column peso, 
    drop column categoria;

alter table ventas 
    drop foreign key ventas_ibfk_1,
    drop foreign key ventas_ibfk_2;

alter table ventas
    drop column cod_fabricante,
    drop column peso, 
    drop column categoria;

/*ej7 nuevo*/
alter table articulos
    drop primary key,
    add column idarticulo varchar(20) primary key;

alter table pedidos
    drop column articulo,
    add column articulo varchar(20),
    add foreign key (articulo) references articulos (idarticulo);

alter table ventas
    drop column articulo,
    add column articulo varchar(20),
    add foreign key (articulo) references articulos (idarticulo);