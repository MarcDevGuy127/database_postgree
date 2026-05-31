-- Exercise 1 - Transactions
-- Add new user, transform into an entity and associate with the main table
BEGIN;

INSERT INTO mecanico(id_mecanico, nome, telefone, especialidade, endereco, latitude, longitude)
VALUES(5, 'Marcelo Silva', '(41) 99777-1005', 'Customização Automotiva', 'Rua Pedro Alvarez Cabral, 1500 - Bairro Alto, Curitiba/PR', '-25.4300', '-49.248300');

INSERT INTO peca(id_peca, nome, marca, cod_referencia, descricao)
VALUES(9, 'Insulfilm G20', 'Grundhay Inc', 'GINK-9009', 'Película de proteção solar que filtra 20% da iluminação externa');

INSERT INTO estoque(id_estoque, id_loja, id_peca, preco, qtde)
VALUES(15, 3, 9, 210, 8);

UPDATE usuario
SET nome = 'Pedro Macedo'
WHERE id_usuario = 6;

INSERT INTO servico(id_servico, id_usuario, id_mecanico, id_peca, descricao, data_servico, valor_servico)
VALUES(9, 6, 5, 9, 'Aplicação de Insulfilm G20', NOW(), 170.50);

COMMIT;

SELECT * FROM mecanico;
SELECT * FROM peca;
SELECT * FROM estoque;
SELECT * FROM usuario
WHERE id_usuario = 6;
SELECT * FROM servico;

ROLLBACK;