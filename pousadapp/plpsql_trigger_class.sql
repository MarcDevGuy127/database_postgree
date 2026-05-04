
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