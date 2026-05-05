
-- FUNCTION
CREATE OR REPLACE FUNCTION normaliza_email_fnc()
RETURNS TRIGGER AS $$
DECLARE
	email_corrigido VARCHAR(255);
BEGIN
	email_corrigido := LOWER(TRIM(NEW.email));
	NEW.email := email_corrigido;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--TRIGGER
DROP TRIGGER IF EXISTS normaliza_email_trg
ON usuario;

CREATE TRIGGER normaliza_email_trg
BEFORE INSERT OR UPDATE OF email
ON usuario
FOR EACH ROW
EXECUTE FUNCTION normaliza_email_fnc();

SELECT setval( 
pg_get_serial_sequence('usuario', 
'id_usuario'),
COALESCE((SELECT MAX(id_usuario) FROM 
usuario), 0) + 1,false);

INSERT INTO usuario (nome, email, telefone)
VALUES ('Maria Souza', 'MARIA.SOUZA@EMAIL.COM', '41988887777');

SELECT * FROM usuario ORDER BY id_usuario DESC;

select * from reserva;
--PRACTICING
CREATE OR REPLACE FUNCTION valor_total_fnc()
RETURNS TRIGGER AS $$
DECLARE
	qntde_hospedes INTEGER;
	qntde_dias INTEGER;
	valor_total NUMERIC(10,2);
BEGIN
	qntde_hospedes := NEW.qtd_hospedes;
	qntde_dias := NEW.checkout - NEW.checkin;

	IF qntde_hospede = 1 THEN
  	valor_total = NEW.valor_total;
	ELSEIF qntde_hospede >= 2 THEN
  	valor_total = NEW.valor_total * 0.50;
	END IF; 
	
	NEW.valor_total := valor_total;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--RAISE EXCEPTION
CREATE OR REPLACE FUNCTION valida_diaria_fnc()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.valor_diaria < 0 THEN
RAISE EXCEPTION 'O preço da diaria não pode 
ser negativo (preço %)', NEW.valor_diaria;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS validar_diaria_trg ON 
imovel;
CREATE TRIGGER trg_validar_diaria
BEFORE INSERT OR UPDATE ON imovel
FOR EACH ROW
EXECUTE FUNCTION valida_diaria_fnc();

UPDATE imovel SET valor_diaria = -50 WHERE id_imovel = 1;
