create database dados_loja
default character set utf8mb4
default collate utf8mb4_general_ci;

use dados_loja;


create table clientes(
cpf varchar(11) primary key,
nome varchar(100),
cidade varchar(100),
estado char(2)
);



create table produtos(
id_produto int auto_increment primary key,
nome_produto varchar(100),
categoria varchar(100),
preco decimal(10,2)

);

create table pedidos(
id_pedido int auto_increment primary key,
cpf_cliente varchar(11),
data_pedido date,
foreign key (cpf_cliente) references clientes(cpf)
);

create table detalhes_pedido(
id_detalhes_pedido int auto_increment primary key,
id_pedido int,
id_produto int,
quantidade int,
foreign key (id_pedido) references pedidos(id_pedido),
foreign key (id_produto) references produtos(id_produto)
);