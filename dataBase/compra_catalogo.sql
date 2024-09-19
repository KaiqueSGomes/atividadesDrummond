create database COMPRA_CATALOGO;
use COMPRA_CATALOGO;

create table funcionarios (
funcId int primary key auto_increment not null,
funcNome varchar(45) not null,
funcSobrenome varchar(45) not null,
funcCEP int not null
);

create table clientes (
clienteId int primary key auto_increment not null,
clienteNome varchar(45) not null,
clienteSobrenome varchar(45) not null,
clienteCEP varchar(45) not null 
);

drop table cliente;

create table pecas (
pecaId int primary key auto_increment not null,
pecaNome varchar(45) not null,
pecaPreco float not null,
pecaQuantidade float not null
);

create table pedido (
pedidoId int primary key auto_increment not null,
pedidoData date not null,
pedidoDataEstimada date not null,
pedidoDataRealizada date not null,
pecaId int not null,
clienteId int not null,
funcId int not null,
foreign key(pecaId) references pecas (pecaId),
foreign key(clienteId) references clientes (clienteId),
foreign key(funcId) references funcionarios (funcId)
);

SELECT * FROM funcionarios;
SELECT * FROM clientes;
SELECT * FROM pecas;
SELECT * FROM pedido;
