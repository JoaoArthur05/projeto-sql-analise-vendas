alter table clientes 
modify cpf varchar(14);

alter table pedidos
modify cpf_cliente varchar(14);

alter table detalhes_pedido
modify quantidade int not null check (quantidade > 0);