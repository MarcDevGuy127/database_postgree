--1. Mostrar todos os mecânicos da loja, organizados por tipo de especialidade
DROP VIEW IF EXISTS view_Mecanicos;

CREATE VIEW view_Mecanicos AS
SELECT nome, especialidade
FROM mecanico
ORDER BY especialidade ASC;

SELECT * FROM view_Mecanicos;

--2. Mostrar os serviços realizados na loja, com o nome do usuario, do mecânico e da peça, e o preço do serviço
DROP VIEW IF EXISTS view_Servicos;

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
DROP VIEW IF EXISTS view_Estoque;

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
DROP VIEW IF EXISTS view_Lojistas;

CREATE VIEW view_Lojistas AS
SELECT lojista.nome AS employee, 
loja.nome AS store_name
FROM lojista
INNER JOIN loja
ON lojista.id_lojista = loja.id_loja
ORDER BY lojista.nome ASC;

SELECT * FROM view_Lojistas;

--5. Mostrar a receita bruta faturada na loja de peças
DROP VIEW IF EXISTS view_Fatura;

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

--6. Mostrar a diferença: o valor total pago em um serviço e do valor total, qual é o valor da peça e qual é o valor do serviço
DROP VIEW IF EXISTS view_Diferenca;

CREATE VIEW view_Diferenca AS
SELECT 
s.id_servico,
ABS(s.valor_servico - e.preco) AS "difference",
e.preco AS "item_price",
s.valor_servico AS "service_value"
FROM servico s
INNER JOIN peca p ON p.id_peca = s.id_peca
INNER JOIN estoque e ON e.id_peca = s.id_peca
ORDER BY s.id_servico;

SELECT * FROM view_Diferenca;

--7. Mostrar as lojas próximas do usuario (estudar como funciona os Graus Decimais e o que significa uma “loja próxima”)
DROP VIEW IF EXISTS vw_Lojas_Proximas;

CREATE VIEW vw_Lojas_Proximas AS
SELECT 
    l.id_loja,
    u.id_usuario,
    
    6371 * 2 * ASIN(
        SQRT(
            POWER(SIN(RADIANS(l.latitude - u.latitude) / 2), 2) +
            COS(RADIANS(u.latitude)) *
            COS(RADIANS(l.latitude)) *
            POWER(SIN(RADIANS(l.longitude - u.longitude) / 2), 2)
        )
    ) AS distancia_km

FROM loja l
CROSS JOIN usuario u
ORDER BY distancia_km;

SELECT * FROM vw_Lojas_Proximas;

--8. Mostrar todos os serviços realizados no último mês
DROP VIEW IF EXISTS vw_servicos_detalhados;

CREATE VIEW view_Servicos_Realizados AS
SELECT
    s.id_servico,
    u.nome AS usuario,
    m.nome AS mecanico,
    m.especialidade,
    p.nome AS peca,
    s.descricao,
    s.data_servico,
    s.valor_servico
FROM servico s
INNER JOIN usuario u ON u.id_usuario = s.id_usuario
INNER JOIN mecanico m ON m.id_mecanico = s.id_mecanico
INNER JOIN peca p ON p.id_peca = s.id_peca;

SELECT * FROM view_Servicos_Realizados;