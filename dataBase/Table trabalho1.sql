CREATE DATABASE trabalho1;
use trabalho1;

DROP TABLE cadastroCarros;
drop table informacoes;
drop table clientes;
drop table vendas;
drop table funcionarios;

create table cadastroCarros(
placaId int primary key NOT NULL,
chassi VARCHAR(45) NOT NULL,
ano FLOAT NOT NULL,
modelo CHAR(15) NOT NULL,
marca CHAR(15) NOT NULL
);

create table informacoes(
placaId int NOT NULL,
cor CHAR(20) NOT NULL,
aro FLOAT NOT NULL,
motor CHAR(20) NOT NULL,
potencia VARCHAR(45) NOT NULL,
kilometragem FLOAT NOT NULL,
transmissao VARCHAR(45) NOT NULL,
direcao VARCHAR(45) NOT NULL,
portas FLOAT NOT NULL,
combustivel VARCHAR (45) NOT NULL,
foreign key(placaId) references cadastroCarros(placaId)
);

create table clientes(
clienteId int primary key auto_increment NOT NULL,
cpfCliente CHAR(20) NOT NULL,
nomeCliente VARCHAR(45) NOT NULL,
clienteNasc date NOT NULL,
sexoCliente CHAR(9) NOT NULL,
clienteTel CHAR(20) NOT NULL,
email VARCHAR(45) NOT NULL,
enderecoCliente VARCHAR(45) NOT NULL,
placaId int NOT NULL,
foreign key(placaId) references cadastroCarros(placaId)
);

create table funcionarios(
funcionarioId int primary key auto_increment NOT NULL,
nomeFuncionario VARCHAR(45) NOT NULL,
cpf CHAR(20) NOT NULL,
funcionarioNasc date NOT NULL,
sexoFuncionario CHAR(9) NOT NULL,
funcionarioTel CHAR(20) NOT NULL,
funcionarioEmail VARCHAR(45) NOT NULL, 
salario FLOAT NOT NULL,
funcao VARCHAR(45) NOT NULL,
periodo VARCHAR(45) NOT NULL,
dataInicio date NOT NULL
);

create table vendas(
vendaId int primary key auto_increment NOT NULL,
vendaValor decimal(10,2) NOT NULL,
vendaData date NOT NULL,
clienteId int NOT NULL,
funcionarioId int NOT NULL,
placaId int NOT NULL,
foreign key(clienteId) references clientes(clienteId),
foreign key(funcionarioId) references funcionarios(funcionarioId),
foreign key(placaId) references cadastroCarros(placaId)
);
