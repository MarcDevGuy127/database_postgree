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
pg_get_serial_sequence('historico_reserva', 'id_historico'),
COALESCE((SELECT MAX(id_historico) FROM historico_reserva), 0) + 1,false);

UPDATE reserva set status_codigo = 4 WHERE id_hospede = 18;

SELECT * FROM historico_reserva WHERE 
observacao = 'Mudança de estado da reserva';