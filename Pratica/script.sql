
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
    
    TOP vs LIMIT - Limita a quantidade de registros retornados na consulta
    
    SQL SERVER - Usa o TOP
    select top 5 * from cliente;
    
    MySQL - Retorna os primeiros 5 registros
    select * from cliente LIMIT 5;
    
    Exemplo: 
    select c.s_nome_cliente, v.i_venda_venda, v.d_data_venda, v.f_valor_venda
	from venda v
	inner join cliente c on c.i_cliente_cliente = v.i_cliente_cliente
	order by f_valor_venda desc limit 3;
    
    Funções MAX e MIN - Seleciona maior e menor valor
    
    Exemplo:
    select c.s_nome_cliente, v.i_venda_venda, v.d_data_venda, v.f_valor_venda from venda v 
	inner join cliente c on c.i_cliente_cliente = v.i_cliente_cliente
	where v.f_valor_venda = (select max(f_valor_venda) from venda);
    
    Funções round, count, sum e avg
    
    Sum = Soma
    AVG = Média
    Count = Contagem
    round = Arredondar
    
    Exemplos - Sum e Round
    
    select round(sum(f_valor_venda), 2) from venda where d_data_venda > '2020-05-01';
    
    select 
		round(sum(f_valor_venda), 2) 
	from 
		venda 
	where 
		f_valor_venda > (select min(f_valor_venda) from venda) 
	and 
		f_valor_venda < (select max(f_valor_venda) from venda);
        
    AVG 
    
    select round(avg(f_valor_venda), 2) from venda;
    
    Count
    
    select 
		count(f_valor_venda) as "Qtde Vendas", 
        round(sum(f_valor_venda), 2) as "Valor médio das vendas"
	from 
		venda;
        
	Operador LIKE - Específica consultas
    
    Coringas
    % - Qualquer caractere antes ou depois
    _ - Quantidade de caracteres antes ou depois
    
    Exemplos %
    
    Começa com a letra B
    select * from cliente where s_nome_cliente like ('b%')
    
    Termina com a letra B
    select * from cliente where s_nome_cliente like ('%b')
    
    Contém a letra B
    select * from cliente where s_nome_cliente like ('%b%')
    
    Contém com a letra B e termina com O
    select * from cliente where s_nome_cliente like ('b%o')
    
    Exemplos _
    
    Começa com B e contém apenas mais 2 caracteres
    select * from cliente where s_nome_cliente like ('b__')
    
    Contém 8 caracteres
    select * from cliente where s_nome_cliente like ('________')
    
    Operador IN 
    Permite que especifique vários valores em uma cláusula WHERE. 
    Serve como uma abreviação para várias condições OR.
	
    Podemos substituir isso
	select * from cliente where right(s_cpf_cliente, 1) = 0 or right(s_cpf_cliente, 1) = 1 or right(s_cpf_cliente, 1) = 2;
	
    Por isso
    select * from cliente where right(s_cpf_cliente, 1) in (0, 1, 2);
    
    Outro exemplo com subconsulta
    select * from cliente
    where d_nasc_cliente in (select d_nasc_cliente from cliente where d_nasc_cliente > '2000-01-01' and d_nasc_cliente < '2010-01-01') ;

	Operador BETWEEN - Filtra os registros ENTRE os valores passados
    
    Exemplos: 
    
    select * from cliente 
	where i_tipo_cliente between 1 and 10;
    
    select * from cliente 
	where d_nasc_cliente between '2000-01-01' and '2010-01-01';
    
    select * from venda 
	where 
		(d_data_venda between '2020-07-01' and '2020-10-15') and 
		i_cliente_cliente not in (3, 10) and
		f_valor_venda > 20;
        
	Tipos de JOIN do SQL
    
    Inner Join - Retorna o que é comum entre as duas tabelas
    
    select 
		c.i_cliente_cliente, c.s_nome_cliente 
	from 
		cliente c 
	inner join venda v 
			on c.i_cliente_cliente = v.i_cliente_cliente;
	----------------------------------------------------------------------
    
    Left Join - Retorna todos os registros da tabela da esquerda (principal) + as correspondencias da tabela da direita
	
    select 
		c.i_cliente_cliente, c.s_nome_cliente, v.i_venda_venda
	from 
		cliente c 
	left join venda v 
			on c.i_cliente_cliente = v.i_cliente_cliente;
	----------------------------------------------------------------------
    
	Right Join - Retorna todos os registros da tabela da direita + as correspondencias da tabela da esquerda

	select 
		c.i_cliente_cliente, c.s_nome_cliente, v.i_venda_venda
	from 
		cliente c 
	right join venda v 
			on c.i_cliente_cliente = v.i_cliente_cliente;
	----------------------------------------------------------------------
    
	Ligando uma tabela a ela mesma (Self Join)
    
    select 
		* 
	from 
		cliente c1, cliente c2
	where
		c1.i_tipo_cliente = c2.i_tipo_cliente and c1.s_nome_cliente = 'Bruno'
	order by c1.i_tipo_cliente
	;
	
    operador UNION
    
    Exemplos: 
    select 'Cliente' as Tabela,  i_cliente_cliente, s_nome_cliente from cliente
	union
	select 'Cliente aux', i_cliente_cliente, s_nome_cliente from cliente_aux
	union
	select 'Venda', v.i_cliente_cliente, c.s_nome_cliente from venda v
		inner join cliente c on v.i_cliente_cliente = c.i_cliente_cliente;
        
	operador EXISTS
    
    Criando a tabela produto venda
    
    create table produtovenda(
		i_produtovenda_produtovenda int NOT NULL AUTO_INCREMENT,
		i_venda_venda int NOT NULL,
		s_dscproduto_produtovenda varchar(50) NOT NULL,
		f_precoun_produtovenda float NOT NULL,
		i_qtde_produtovenda int,
		PRIMARY KEY (i_produtovenda_produtovenda),
		FOREIGN KEY (i_venda_venda) REFERENCES venda (i_venda_venda)
	);
	insert into produtovenda values (1,1,'Mouse',7.89,1);
	insert into produtovenda values (2,1,'Teclado',15.20,1);
	insert into produtovenda values (3,2,'Mouse',7.89,2);
	insert into produtovenda values (4,2,'Monitor',299.80,2);
	insert into produtovenda values (5,2,'Microfone',34.90,2);
	insert into produtovenda values (6,3,'Teclado',15.20,10);
	insert into produtovenda values (7,4,'CPU',569.78,1);
	insert into produtovenda values (8,4,'RAM',325.00,1);
	insert into produtovenda values (9,5,'HD',329.90,2);
	insert into produtovenda values (10,6,'Placa Vídeo',899.49,1);
	insert into produtovenda values (11,6,'Placa Rede',19.90,1);
	insert into produtovenda values (12,6,'Cx.Som',29.90,1);
	insert into produtovenda values (13,6,'CPU',325.00,1);
	insert into produtovenda values (14,6,'Mouse',7.89,1);
	insert into produtovenda values (15,7,'Monitor',299.80,3);
	insert into produtovenda values (16,7,'Mouse',7.89,2);
	insert into produtovenda values (17,8,'HD',249.90,15);
	insert into produtovenda values (18,9,'Placa Mãe',900.00,2);
	insert into produtovenda values (19,10,'Cx.Som',29.90,2);
	insert into produtovenda values (20,10,'Microfone',34.90,2);
	insert into produtovenda values (21,11,'Teclado',15.20,5);
	insert into produtovenda values (22,11,'CPU',989.90,2);
	insert into produtovenda values (23,11,'RAM',325.00,2);
	insert into produtovenda values (24,12,'HD',249.90,1);
	insert into produtovenda values (25,13,'Placa Mãe',149.90,1);
	insert into produtovenda values (26,14,'Impressora',889.99,3);
	insert into produtovenda values (27,14,'Web Cam',599.90,3);
	insert into produtovenda values (28,15,'Cabo Rede',4.99,1);
	insert into produtovenda values (29,16,'Mouse',7.89,7);
	insert into produtovenda values (30,17,'Teclado',15.20,8);
	insert into produtovenda values (31,18,'RAM',325.00,2);
	insert into produtovenda values (32,19,'HD',249.90,1);
	insert into produtovenda values (33,19,'Microfone',34.90,1);
	insert into produtovenda values (34,20,'Impressora',499.90,1);
	insert into produtovenda values (35,20,'Web Cam',329.90,1);

	insert into cliente values (21,'Crisberliston','15935745698','2000-01-01',1);
	insert into cliente values (22,'Malgamorson','32165498700','2001-01-01',1);
	insert into cliente values (23,'Silmastilda','12345678900','2002-01-01',1);
	insert into cliente values (24,'Florasmirtes','14785236911','2003-01-01',1);
    
    Exemplo:
    Retorna true se a consulta dentro de exists retornar verdadeiro e então executa a consulta que chamou o metodo
    select * from cliente c where exists(select * from venda v where v.i_cliente_cliente = c.i_cliente_cliente)

	CASE..WHEN - Trata consultas
    
    Exemplos: 
	select
		i_cliente_cliente,
		s_nome_cliente,
		s_cpf_cliente,
		case
			when d_nasc_cliente is null then now()
			else d_nasc_cliente
		end as 'd_nasc_cliente',
		i_tipo_cliente,
		case
			when (datediff(now(), d_nasc_cliente)/365) > 18 then 'Maior'
			else 'Menor'
		end 'Situação'
	from cliente;
    
    funções IFNULL, ISNULL e NVL - Retorna um valor caso seja nulo
    
    MySQL - IFNULL ou COALESCE
    SqlServer - ISNULL
    ORACLE - NVL
    
    SINTAXE = IFNULL(COLUNA, 0)
    
    Atualizar para null
    update produtovenda set i_qtde_produtovenda = null where i_produtovenda_produtovenda = 1;
    
    Exemplos:
    
    SELECT 
	*, 
    round((f_precoun_produtovenda * ifnull(i_qtde_produtovenda, 0)),2) as 'Total'
	FROM PRODUTOVENDA;
    ----------------------------------------------------------------------------------------
    
    Stored Procedures 
    Stored Procedures são métodos ou funções que podem ser chamadas 
    em qualquer momento do codigo depois de serem declaradas
    
    Criando procedure
    
    Delimiter $$ 
	create procedure canal(in curso INT)
	begin
		declare x varchar(50);
		set x = 'youtube.com/cfbcursos';
		select x, curso;
	end $$
	Delimiter ;
    
    Chamando procedure
    
    call canal(2);
    ----------------------------------------------------------------------------
    
    Como usar parâmetros de entrada, saída e o comando IF em Stored Procedures
    
    Exemplo:
    
    Delimiter $$
	create procedure idade(in idCliente int, OUT idade int, out res varchar(20))
	begin
		Declare dt datetime;
		SET dt = (select d_nasc_cliente from cliente where i_cliente_cliente = idCliente);
		set idade = year(now()) - year(dt);
		
		if(idade >= 18)then
			set res = 'Maior';
		else
			set res = 'Menor';
		end if;
		
	end $$
	Delimiter ;

	call idade(11, @idadeCliente, @resultado);
	select @idadeCliente, @resultado;
	---------------------------------------------------------------------------------------
    
    
*/









