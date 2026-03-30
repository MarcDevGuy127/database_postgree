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
DROP VIEW view_Estoque
CREATE VIEW view_Estoque AS
SELECT loja.nome, peca.nome, estoque.qtde
FROM estoque
INNER JOIN peca
ON estoque.id_peca = peca.id_peca
INNER JOIN loja
ON estoque.id_loja = loja.id_loja 
ORDER BY peca.nome ASC;

select *
from estoque;

SELECT * FROM view_Estoque;
--4. Mostrar o nome dos lojistas e da loja na qual ele trabalha
DROP VIEW view_Lojistas
CREATE VIEW view_Lojistas AS
SELECT lojista.nome AS employee, 
loja.nome AS store_name
FROM lojista
INNER JOIN loja
ON lojista.id_lojista = loja.id_loja
ORDER BY lojista.nome ASC;

SELECT * FROM view_Lojistas;

--5. Mostrar a receita bruta faturada na loja de peças
DROP VIEW view_Fatura

CREATE VIEW view_Fatura AS
SELECT loja.nome AS store_name,
SUM(servico.valor_servico) AS balance
FROM mecanico
INNER JOIN servico
ON mecanico.id_mecanico = servico.id_servico
INNER JOIN loja
ON servico.id_servico = loja.id_loja
GROUP BY loja.nome, servico.descricao;

SELECT * FROM view_Fatura;

--6. Mostrar a diferença o valor total pago em um serviço, e do valor total qual é o valor da peça, e qual é o valor do serviço
--7. Mostrar as lojas próximas do usuario (estudar como funciona os Graus Decimais e o que significa uma “loja próxima”)
--8. Mostrar todos os serviços realizados no último mês