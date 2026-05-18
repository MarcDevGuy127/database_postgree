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
 IF NEW.id_peca <> OLD.id_peca THEN
   RAISE NOTICE 'A peça do ID % foi adicionada no estoque da loja %.',
     NEW.id_peca, NEW.id_loja;
 END IF;
 RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE or REPLACE TRIGGER 
trgAlertAddPecaEstoque
AFTER INSERT ORUPDATE
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
