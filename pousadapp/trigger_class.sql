--Creating reservations history table with triggers
CREATE OR REPLACE FUNCTION mudanca_reserva_fnc()
RETURNS trigger AS
$BODY$
BEGIN
IF NEW.status_codigo <> OLD.status_codigo THEN
INSERT INTO historico_reserva (id_reserva,
data_hora, status_codigo, observacao)
VALUES (OLD.id_reserva, now(), OLD.status_codigo,
'Mudança de estado da reserva');
END IF;
RETURN NEW;
END;
$BODY$ LANGUAGE plpgsql;

CREATE or REPLACE TRIGGER
guardar_mudancas_reservas_trg
BEFORE UPDATE
ON reserva
FOR EACH ROW
EXECUTE FUNCTION mudanca_reserva_fnc();


SELECT setval(
pg_get_serial_sequence('historico_reserva
', 'id_historico'),
COALESCE((SELECT MAX(id_historico) FROM
historico_reserva), 0) + 1,false);

UPDATE reserva SET status_codigo = 4
WHERE id_hospede = 75;

SELECT * FROM historico_reserva WHERE
observacao = 'Mudança de estado da reserva';

SELECT * FROM historico_reserva ORDER BY id_historico DESC;

SELECT * FROM hospede ORDER BY id_hospede DESC;

DROP TABLE IF EXISTS historico_imovel CASCADE;
CREATE TABLE historico_imovel (
id_historico BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
id_imovel BIGINT,
data_hora TIMESTAMP DEFAULT NOW(),
valor_diaria SMALLINT,
observacao TEXT,
FOREIGN KEY (id_imovel)
REFERENCES imovel (id_imovel)
);

CREATE OR REPLACE FUNCTION guardar_hist_imovel_fnc ()
RETURNS trigger AS
$BODY$
BEGIN
IF NEW.valor_diaria <> OLD.valor_diaria THEN
INSERT INTO historico_imovel (id_imovel, valor_diaria, data_hora, observacao)
VALUES
(OLD.id_imovel, OLD.valor_diaria, now(), 'Mudança preço');
END IF;
RETURN NEW;
END
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER guardar_hist_iml_trg
AFTER UPDATE
ON imovel
FOR EACH ROW
EXECUTE FUNCTION guardar_hist_imovel_fnc();

UPDATE imovel SET valor_diaria = 500.0
WHERE id_imovel = 2;

SELECT * FROM historico_imovel;