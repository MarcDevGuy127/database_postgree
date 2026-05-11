--Tarefa

CREATE OR REPLACE FUNCTION alertAddPecaEstoque()
RETURNS TRIGGER AS
$$
BEGIN
 IF NEW.id_peca <> OLD.id_peca THEN
   RAISE NOTICE 'A peça do ID % foi adicionada no estoque da loja %.',
     NEW.id_peca, NEW.id_loja;
 END IF;
 RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE or REPLACE TRIGGER 
trgAlertAddPecaEstoque
AFTER INSERT
ON estoque
FOR EACH ROW
EXECUTE FUNCTION alertAddPecaEstoque();

INSERT INTO estoque(id_estoque, id_loja, id_peca, preco, qtde)
VALUES(
	14,
	4,
	8,
	180,
	105
);

select * from estoque;


CREATE OR REPLACE FUNCTION alertChangePecaEstoque()
RETURNS TRIGGER AS
$$
BEGIN
 IF NEW.nome <> OLD.nome THEN
   RAISE NOTICE 'A peça do ID % teve seu nome alterado de % para %.',
     OLD.id_peca, OLD.nome, NEW.nome;
 
 ELSIF NEW.marca <> OLD.marca THEN
   RAISE NOTICE 'A peça do ID % teve sua marca alterada de % para %.',
     OLD.id_peca, OLD.marca, NEW.marca;
 
 ELSIF NEW.cod_referencia <> OLD.cod_referencia THEN
   RAISE NOTICE 'A peça do ID % teve seu código de referencia alterado de % para %.',
     OLD.id_peca, OLD.cod_referencia, NEW.cod_referencia;
	 
 ELSIF NEW.descricao <> OLD.descricao THEN
   RAISE NOTICE 'A peça do ID % teve sua descricao alterada.',
     OLD.id_peca;
 END IF;
 
 RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE or REPLACE TRIGGER 
trgAlertChangePecaEstoque
AFTER UPDATE
ON peca
FOR EACH ROW
EXECUTE FUNCTION alertChangePecaEstoque();

UPDATE peca
SET descricao = 'Correia dentada reforcada e resistente'
WHERE id_peca = 5;

select * from peca;


CREATE OR REPLACE FUNCTION alertRemovePecaEstoque()
RETURNS TRIGGER AS
$$
BEGIN
 RAISE NOTICE 'A peça do ID % foi removida do estoque %.',
 OLD.id_peca, OLD.id_estoque;
 RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE or REPLACE TRIGGER 
trgAlertRemovePecaEstoque
AFTER DELETE
ON estoque
FOR EACH ROW
EXECUTE FUNCTION alertRemovePecaEstoque();

DELETE FROM estoque WHERE id_peca = 14;

select * from estoque;