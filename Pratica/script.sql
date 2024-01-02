
/*
	DDL
	/Cria banco de dados
	create schema cfbcursos; 

	/Cria uma tabela
	create table cliente(
		i_cliente_cliente int primary key not null auto_increment,
		s_nome_cliente varchar(50) not null,
		s_cpf_cliente varchar(11) not null,
		d_nasc_cliente datetime
	);

	Create table tipocliente(
		i_tipocliente_tipocliente int primary key auto_increment,
		s_dsctipocliente_tipocliente varchar(100) not null
	);
*/

/*
	/Deleta um banco de dados
	drop schema cfbcursos;
    
    /Deleta uma tabela
	drop table cliente;
    
    /Modifica colunas de uma tabela
	alter table cliente modify column s_nome_cliente varchar(50) not null;
    alter table cliente modify column i_idade_cliente tinyint;
    
    /Adiciona coluna
    alter table cliente add i_tipo_cliente int not null;
    alter table cliente add i_idade_cliente int;
    
    /Exclui coluna
    alter table cliente drop column i_tipo_cliente;
    alter table cliente drop column i_idade_cliente;

	Como adicionar chave estrangeira
	alter table <tabela_origem> 
    add constraint <nome_restrição> 
    foreing key (<campo_tabela_origem>) 
    references <tabela_destino> (<campo_da_tabela_destino>);

	alter table cliente
	add constraint fk_tipocliente
	foreign key (i_tipo_cliente) 
	references tipocliente(i_tipocliente_tipocliente);
    
    DML - INSERT
    insert into <tabela> (colunas) values (valores) 
    
    insert into tipocliente values (01, "Pessoa Física");
	insert into tipocliente values (02, "Pessoa Jurídica");
	insert into tipocliente values (03, "Cliente Especial");

	insert into cliente values (01, 'Bruno', '12345678912','1978-03-07', 03);
	insert into cliente values (02, 'Astrogirson', '11111111111','1978-03-07', 03);
	insert into cliente values (03, 'Benegilda', '22222222222','1978-03-07', 01);
	insert into cliente values (04, 'Clovismarson', '33333333333','1978-03-07', 02);
	insert into cliente values (05, 'Marisbelena', '44444444444','1978-03-07', 01);
	insert into cliente values (06, 'Xingustrildo', '55555555555','1978-03-07', 02);
	insert into cliente values (07, 'Tramonstila', '66666666666','1978-03-07', 02);
	insert into cliente values (08, 'Arguinelson', '77777777777','1978-03-07', 03);
	insert into cliente values (09, 'Claresterna', '88888888888','1978-03-07', 01);
	insert into cliente values (10, 'Nelgrismar', '99999999999','1978-03-07', 01);
    
    insert into cliente (i_cliente_cliente, s_nome_cliente, s_cpf_cliente, d_nasc_cliente, i_tipo_cliente) values (11, 'Bartoldo', '99999999991','1954-02-02', 01);
	insert into cliente (i_cliente_cliente, s_nome_cliente) values (10, 'Nelgrismar');

    Insert com select
    
    insert into cliente_aux 
		(i_cliente_cliente, s_nome_cliente, s_cpf_cliente, d_nasc_cliente, i_tipo_cliente)
	select
		i_cliente_cliente, 
		s_nome_cliente, 
		s_cpf_cliente, 
		d_nasc_cliente, 
		i_tipo_cliente
	from cliente
    
    Todos os dados da tabela cliente são jogados no cliente_aux
    
    insert into cliente select * from cliente_aux;
    
    Update - Atualizar dados da tabela
    update cliente set i_tipo_cliente = 1 where i_cliente_cliente > 0;
    
    Delete - Deleta dados da tabela
    delete from cliente where I_cliente_cliente > 0;
    
    DQL - SELECT
    SELECT * FROM tipocliente;
	select * from cliente;
    select * from cliente_aux;
    
    SELECT - CLAUSULAS
    select - seleciona dados da tabela
    from - Indica qual tabela vou utilizar
    where - filtros da consulta select
    group by - agrupa linhas
    having - filtros do group by
    order by - ordenação dos registros
    
    É possível realizar cálculos no select: select s_nome_cliente, i_tipo_cliente * 2 from cliente;
	
    Função UPPER() no Select
    select i_cliente_cliente, upper(s_nome_cliente), i_tipo_cliente from cliente;
	
    Apelidos as colunas e tabela com o AS
    select 
		tbc.i_cliente_cliente as idCliente, 
		upper(tbc.s_nome_cliente) as nomeCliente, 
		tbc.i_tipo_cliente as tipoCliente ,
		tbc.i_cliente_cliente * 2 as valorCliente
	from 
		cliente tbc;
	
    'distinct' retira os registros duplicados da consulta
    select distinct i_cliente_cliente from venda 
    
    SubSelect, incremento para campo chave
    
	insert into cliente values ((select max(c.i_cliente_cliente) + 1 from cliente c), 'Vespertino', '12345678999', '2021-06-03', 1);
    
    Utilização da Cláusula FROM com tabelas temporárias
    select * from (select i_cliente_cliente, s_nome_cliente from cliente) c;
    
    Utilização da Cláusula FROM com uma view
    create view nomescli as 
	select i_cliente_cliente, s_nome_cliente from cliente;

	select * from nomescli;
    
    Views
    
    Uma view executa uma consulta pré definida, facilitando as consultas
    
    Criando uma view: create view cpfcliente as select i_cliente_cliente, s_cpf_cliente from cliente;
    
    Chamando a view: select * from cpfcliente;
    
    Criando uma view para aniversariantes do mês:
    
	create view aniversariantesDoMes as
	select 
		i_cliente_cliente, 
		s_nome_cliente, 
		day(d_nasc_cliente) as 'Dia Aniversário' 
	from cliente 
	where 
		month(d_nasc_cliente) = month(curdate());
        
     Chamando a view: select * from aniversariantesdomes;   
     
     Cláusula WHERE - Filtra a consulta
     
     Exemplos: select * from cliente where s_cpf_cliente = '00000000000' or s_cpf_cliente = '11111111111';
			   select * from cliente where i_tipo_cliente in(2,3) and (month(d_nasc_cliente) >= 4 and month(d_nasc_cliente) <= 9);
	 
     Inner Join - Usado para vincular duas tabelas que se relacionam em uma consulta
     
     Exemplos:
     select 
		c.i_cliente_cliente, 
		c.s_nome_cliente, 
		c.s_cpf_cliente, 
		c.d_nasc_cliente, 
		tc.s_dsctipocliente_tipocliente
	 from cliente c
		inner join tipocliente tc on c.i_tipo_cliente = tc.i_tipocliente_tipocliente;
        
	select 
		v.i_venda_venda,
		c.s_nome_cliente as 'Nome do cliente',
		c.s_cpf_cliente as 'CPF do cliente',
		v.d_data_venda,
		v.f_valor_venda,
		tc.s_dsctipocliente_tipocliente as 'Tipo do cliente'
	from venda v
		inner join cliente c on v.i_cliente_cliente = c.i_cliente_cliente
		inner join tipocliente tc on c.i_tipo_cliente = tc.i_tipocliente_tipocliente;
        
	GROUP BY - Faz agrupamentos de dados na consulta
    
    Exemplos
	SELECT 
		tc.s_dsctipocliente_tipocliente, 
		count(c.i_cliente_cliente) as qtde 
	FROM 
		tipocliente tc 
	inner join 
		cliente c on tc.i_tipocliente_tipocliente = c.i_tipo_cliente 
	GROUP BY 
		tc.i_tipocliente_tipocliente;

	select 
		v.d_data_venda,
		count(v.i_venda_venda) as 'Qtde vendas do dia' 
	from 
		venda v
	group by 
		d_data_venda;
        
	Having - Filtra dados do Group By
    
    Exemplo
    
    select 
		v.d_data_venda,
		count(v.i_venda_venda) as 'Qtde vendas do dia' 
	from 
		venda v
	group by 
		v.d_data_venda
	having
		count(v.i_venda_venda) < 2;
        
	Order By - Ordena os resultados de uma consulta
    
    Exemplos:
    
    1) Ordena pelos ultimos 3 digitos do CPF
    select 
	* 
	from
		cliente
	order by
		right(s_cpf_cliente, 3) 
	;
    
    2) Ordena pelo nome do cliente, em ordem alfabética 
    select 
	* 
	from
		cliente
	order by
		s_nome_cliente
	;
    
    3) Palavra 'DESC' inverte a ordem padrão (crescente) por decrescente
    
    select 
	* 
	from
		cliente
	order by
		i_cliente_cliente desc
	;
    
    4) É possível ordenar pela posição das colunas
    
    select 
	* 
	from
		cliente
	order by
		1 desc 
	;
    
    Is Null vs Is Not Null - Filtragem do que é nulo e o que não é no resultado das consultas
    
    INSERTS DE EXEMPLO:
    
    insert into cliente values (default, 'Valkisneide','11223344556',null,1);
	insert into cliente values (default,'Alcinclésio','65544332211',null,2);
	insert into cliente values (default,'Nestisgerson','74125896300',null,3);
	insert into cliente values (default,'Mordonório','36925814799',null,1);
	insert into cliente values (default,'Mordonório','36925814799',null,2);
	insert into cliente values (default,'Salomildo','98765432147',null,3);
    
    Exemplos: 
    Resultados não nulos
    select * from cliente where d_nasc_cliente is not null;
    
    Resultados nulos
    select * from cliente where d_nasc_cliente is null;
    
    Operadores AND, OR e NOT
    
    Exemplos:
    As duas condições precisam retornar verdadeiro
    select * from cliente where d_nasc_cliente is not null and i_tipo_cliente = 1;
    
    Apenas uma condição precisa retornar verdadeiro
    select * from cliente where d_nasc_cliente is null or i_tipo_cliente = 1;
    
    Inverte a condição
	select * from cliente where not i_tipo_cliente = 1;
*/












