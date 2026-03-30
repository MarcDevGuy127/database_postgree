--1. Mostrar todos os mecânicos da loja, organizados por tipo de especialidade
CREATE VIEW view_Mecanicos AS
SELECT nome, especialidade
FROM mecanico
ORDER BY especialidade ASC;

SELECT * FROM view_Mecanicos;

--2. Mostrar os serviços realizados na loja, com o nome do usuario, do mecânico e da peça, e o preço do serviço
DROP VIEW view_Servicos;
CREATE VIEW view_Servicos AS
SELECT usuario.nome AS username,
mecanico.nome AS mechanic,
servico.descricao AS service,
peca.nome AS piece,
servico.valor_servico AS service_value,
loja.nome AS auto_repair
FROM mecanico
INNER JOIN servico
ON mecanico.id_mecanico = servico.id_usuario
INNER JOIN usuario
ON servico.id_usuario = usuario.id_usuario
INNER JOIN peca
ON usuario.id_usuario = peca.id_peca
INNER JOIN loja
ON peca.id_peca = loja.id_loja
ORDER BY usuario.nome ASC;

SELECT * FROM view_Servicos;
--3. Mostrar o nome das peças e a quantidade em estoque delas
--4. Mostrar o nome dos lojistas e da loja na qual ele trabalha
--5. Mostrar a receita bruta faturada na loja de peças
--6. Mostrar a diferença o valor total pago em um serviço, e do valor total qual é o valor da peça, e qual é o valor do serviço
--7. Mostrar as lojas próximas do usuario (estudar como funciona os Graus Decimais e o que significa uma “loja próxima”)
--8. Mostrar todos os serviços realizados no último mês