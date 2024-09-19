create database  REVISAO_CONFERENCIA;
use REVISAO_CONFERENCIA;
drop DATABASE REVISAO_CONFERENCIA;

create table autores (
autorEmail varchar(45) primary key not null,
autorNome varchar(45) not null,
autorSobrenome varchar(45) not null,
artigoId int
);

drop table autores;

create table artigos (
artigoId int primary key auto_increment not null,
artigoTitulo varchar(45) not null,
artigoResumo varchar(45) not null,
artigoArquivo varchar(45) not null,
autorEmail varchar(45),
revisorEmail varchar(45),
foreign key (autorEmail) references autores (autorEmail),
foreign key (revisorEmail) references revisores (revisorEmail)
);

drop table artigos;

create table revisores(
revisorEmail varchar(45) primary key not null,
revisorNome varchar(45) not null,
revisorSobrenome varchar(45) not null,
revisorTel char(11) not null,
revisorAfiliacao varchar(45) not null,
revisorInteresse varchar(45) not null
);
drop table revisores;

create table revisoes (
revisaoId int primary key auto_increment not null,
revisaoMerito float not null,
revisaoLegibilidade float not null,
revisaoOriginalidade float not null,
revisaoRelevancia float not null,
revisaoRecomendacao char(8) not null,
comentarioRevisao varchar(45) not null,
comentarioAutor varchar(45) not null,
revisorEmail varchar(45) not null,
foreign key (revisorEmail) references revisores(revisorEmail)
);

ALTER TABLE autores ADD CONSTRAINT artigoId
FOREIGN KEY(artigoId) REFERENCES artigos(artigoId);

select * from autores;
select * from artigos;
select * from revisores;
select * from revisoes;

truncate table autores;
truncate table artigos;

insert into artigos (artigoTitulo, artigoResumo, artigoArquivo, autorEmail) values (
'comida', 'resumo', 'nomeDoArquivo', 'kaique@gmail.com'
);

insert into autores (autorEmail, autorNome, autorSobrenome, artigoId) values (
'kaique@gmail.com', 'Kaique', 'Gomes', '1'
);
