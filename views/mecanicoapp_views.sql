--1. Mostrar todos os mecânicos da loja, organizados por tipo de especialidade
CREATE VIEW view_Mecanicos AS
SELECT nome, especialidade
FROM mecanico
ORDER BY especialidade ASC;

SELECT * FROM view_Mecanicos;
--2. Mostrar os serviços realizados na loja, com o nome do usuario, do mecânico e da peça, e o preço do serviço
--3. Mostrar o nome das peças e a quantidade em estoque delas
--4. Mostrar o nome dos lojistas e da loja na qual ele trabalha
--5. Mostrar a receita bruta faturada na loja de peças
--6. Mostrar a diferença o valor total pago em um serviço, e do valor total qual é o valor da peça, e qual é o valor do serviço
--7. Mostrar as lojas próximas do usuario (estudar como funciona os Graus Decimais e o que significa uma “loja próxima”)
--8. Mostrar todos os serviços realizados no último mês