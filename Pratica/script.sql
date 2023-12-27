
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
*/










