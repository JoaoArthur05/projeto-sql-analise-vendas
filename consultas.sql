-- Top 3 produtos mais vendidos 
-- Consulta que retorna os 3 produtos mais vendidos em volume (quantidade total de unidades).
-- Útil para decisões de estoque, promoção e destaque de produtos mais populares.

select prod.nome_produto as `nome do produto`, sum(dtped.quantidade) as `total vendido`, sum(prod.preco) as `faturamento por produto` from produtos as prod
join detalhes_pedido as dtped on prod.id_produto = dtped.id_produto
group by prod.nome_produto 
order by `total vendido` desc
limit 3; 






-- Faturamento por cidade
-- Consulta que agrupa as vendas por cidade e calcula o faturamento total gerado em cada local.
-- Essencial para entender a performance por região e direcionar ações de marketing geográfico.

select cli.cidade, sum(prod.preco * dtped.quantidade) as `faturamento` from produtos as prod
join detalhes_pedido as dtped on prod.id_produto = dtped.id_produto
join pedidos as ped on ped.id_pedido = dtped.id_pedido
join clientes as cli on cli.cpf = ped.cpf_cliente
group by cli.cidade
order by cli.cidade;






-- Top 3 clientes que mais gastaram
-- Consulta que identifica os 3 clientes com maior valor total gasto em compras.
-- Pode ser usada para programas de fidelidade ou ações VIP. 

select cli.cpf, cli.nome, sum(prod.preco * dtped.quantidade) as `Quantidade gasta` from clientes as cli
join pedidos as ped on cli.cpf = ped.cpf_cliente
join detalhes_pedido as dtped on ped.id_pedido = dtped.id_pedido
join produtos as prod on prod.id_produto = dtped.id_produto
group by cli.cpf
order by `Quantidade gasta` desc
limit 3;






-- Tiket de cada pedido
-- Útil para entender quanto cada pedido gerou individualmente, permitindo identificar padrões de consumo e clientes com maior poder de compra.


select ped.id_pedido, sum(prod.preco * dtped.quantidade) as `tiket` from pedidos as ped
join detalhes_pedido as dtped on ped.id_pedido = dtped.id_pedido
join produtos as prod on prod.id_produto = dtped.id_produto
group by ped.id_pedido
order by ped.id_pedido;






-- Ticket médio dos pedido
-- Consulta que calcula o valor médio gasto por pedido.
-- Ajuda a entender o comportamento médio de consumo por cliente.

select avg(tiket) as `Tiket médio dos pedidos` from (

select ped.id_pedido, sum(prod.preco * dtped.quantidade) as `tiket` from pedidos as ped
join detalhes_pedido as dtped on ped.id_pedido = dtped.id_pedido
join produtos as prod on prod.id_produto = dtped.id_produto
group by ped.id_pedido
order by ped.id_pedido


) as `tiket dos pedidos`;






-- Faturamento dos pedidos feitos no primeiro semestre de 2024 
-- Útil para relatórios semestrais ou análises sazonais.

select ped.data_pedido, sum(prod.preco * dtped.quantidade) as `Faturamento` from pedidos as ped
join detalhes_pedido as dtped on dtped.id_pedido = ped.id_pedido
join produtos as prod on prod.id_produto = dtped.id_produto
where ped.data_pedido between '2024-01-01' and '2024-06-30'
group by ped.data_pedido 
order by ped.data_pedido
;






-- Total faturado no primeiro semestre de 2024
-- Útil para mensurar o desempenho financeiro da loja no primeiro semestre de 2024, facilitando comparações com outros períodos ou avaliação de metas.

select sum(`Faturamento`) as `Total faturado em 2024.1` from (

select ped.data_pedido, sum(prod.preco * dtped.quantidade) as `Faturamento` from pedidos as ped
join detalhes_pedido as dtped on dtped.id_pedido = ped.id_pedido
join produtos as prod on prod.id_produto = dtped.id_produto
where ped.data_pedido between '2024-01-01' and '2024-06-30'
group by ped.data_pedido 
order by ped.data_pedido


) as `Faturamento dos pedidos de 2024.1`;






-- Clientes recorrentes
-- Consulta que retorna clientes que realizaram mais de um pedido.
-- Importante para analisar fidelidade e recorrência de clientes.

select cli.nome, count(ped.id_pedido) as `Pedidos realizados` from clientes as cli
join pedidos as ped on cli.cpf = ped.cpf_cliente
group by cli.cpf
having `Pedidos realizados` > 1
order by cli.nome;



