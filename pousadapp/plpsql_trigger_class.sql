CREATE OR REPLACE FUNCTION normaliza_email_fnc()
RETURNS TRIGGER AS $$
DECLARE
	email_corrigido := varchar(255);
BEGIN
	email_corrigido := LOWER(TRIM(NEW.email));
	NEW.email := email_corrigido;
END;
$$ LANGUAGE plpsql;