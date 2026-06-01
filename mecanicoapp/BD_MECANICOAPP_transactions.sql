-- Exercise 1 - Transactions
-- Add new user, transform into an entity and associate with the main table
BEGIN;

INSERT INTO mecanico(id_mecanico, nome, telefone, especialidade, endereco, latitude, longitude)
VALUES(5, 'Marcelo Silva', '(41) 99777-1005', 'Customização Automotiva', 'Rua Pedro Alvarez Cabral, 1500 - Bairro Alto, Curitiba/PR', '-25.4300', '-49.248300');

INSERT INTO peca(id_peca, nome, marca, cod_referencia, descricao)
VALUES(9, 'Insulfilm G20', 'Grundhay Inc', 'GINK-9009', 'Pelicula de protecao solar que filtra 20% da iluminacao externa');

INSERT INTO estoque(id_estoque, id_loja, id_peca, preco, qtde)
VALUES(15, 3, 9, 210, 8);

UPDATE usuario
SET nome = 'Pedro Macedo'
WHERE id_usuario = 6;

INSERT INTO servico(id_servico, id_usuario, id_mecanico, id_peca, descricao, data_servico, valor_servico)
VALUES(9, 6, 5, 9, 'Aplicacao de Insulfilm G20', NOW(), 170.50);

COMMIT;

SELECT * FROM peca;
SELECT * FROM estoque;
SELECT * FROM usuario
WHERE id_usuario = 6;
SELECT * FROM servico;

-- Exercise 2
BEGIN;

CREATE OR REPLACE FUNCTION alertAddPecaEstoque()
RETURNS TRIGGER AS $$
BEGIN

	RAISE NOTICE 'A peça do ID % foi adicionada no estoque da loja %.',
     NEW.id_peca, NEW.id_loja;
 
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

SAVEPOINT sp_alert_add_peca_estoque;

CREATE or REPLACE TRIGGER 
trgAlertAddPecaEstoque
AFTER INSERT
ON estoque
FOR EACH ROW
EXECUTE FUNCTION alertAddPecaEstoque();

SAVEPOINT sp_trg_add_peca_estoque;

INSERT INTO peca(id_peca, nome, marca, cod_referencia, descricao)
VALUES(10, 'Farol Xenon', 'Grundhay Inc', 'GINK-9010', 'Farol xenon esportivo');

SAVEPOINT sp_insertion_peca;

INSERT INTO estoque(id_estoque, id_loja, id_peca, preco, qtde)
VALUES(16, 4, 10, 1000, 150);

SAVEPOINT sp_insertion_estoque;

select * from estoque;

SAVEPOINT sp_insertion_query;

COMMIT;
ROLLBACK;

-- Exercise 3
-- É temporada de verão, muitos motoristas estão garantindo que os seus veículos durem durante as suas viagens.
-- Com isso, os serviços sofreram aumento de 30% nos preços cobrados devido a demanda.
BEGIN;

SELECT * FROM servico;

SAVEPOINT sp_servicos_sem_demanda;

UPDATE servico
SET valor_servico = valor_servico + valor_servico * 0.30;

SELECT * FROM servico;

SAVEPOINT sp_servicos_com_demanda;

-- Todos os serviços aumentaram 30% a mais do que o preço comum

ROLLBACK;