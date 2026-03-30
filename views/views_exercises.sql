--Exercicio 1
--Crie uma view para retornar o id do usuário, o seu 
--nome, cpf (no caso de hospede) ou cnpj (no caso de 
--locatario) e email. 

SELECT * FROM usuario;

CREATE VIEW view_Users
AS SELECT COUNT(id_usuario, nome, email)
FROM usuario
WHERE = (SELECT cpf FROM hospede);

--DROP VIEW view_Users;

SELECT * FROM view_Users;

--Exercicio 2
--Crie uma view para retornar o id do imovel, o título do 
--imóvel, o valor da diária e o nome do tipo do imóvel.

SELECT * FROM tipo_imovel;
SELECT * FROM imovel;

drop view view_Houses;

CREATE VIEW view_Houses AS
SELECT id_imovel, titulo, tipo_imovel.rotulo, AVG(valor_diaria) AS day_value
FROM imovel
INNER JOIN tipo_imovel
ON imovel.tipo_codigo = tipo_imovel.codigo
GROUP BY imovel.id_imovel, imovel.titulo, tipo_imovel.rotulo;

SELECT * FROM view_Houses;

--Exercicio 3
--Crie uma view para mostrar o nome do imóvel
--reservado, a data de checkin e checkout, a quantidade
--de dias reservados, o valor total da reserva, e o nome
--do hospede que reservou
SELECT id_reserva, COUNT(status_codigo) FROM reserva WHERE status_codigo = 2
GROUP BY id_reserva;

SELECT * FROM reserva;
SELECT * FROM hospede;
SELECT * FROM imovel;
SELECT * FROM status_pagamento;

DROP VIEW view_Reservation;

CREATE VIEW view_Reservation AS
SELECT checkin, checkout, (checkout - checkin) AS total_days, valor_total, hospede.cpf
FROM reserva
INNER JOIN hospede
ON reserva.id_reserva = hospede.id_hospede
INNER JOIN imovel
ON hospede.id_hospede = imovel.id_imovel
INNER JOIN status_pagamento
ON reserva.status_codigo = status_pagamento.codigo  --reserva.status_codigo
WHERE status_codigo = 2 --status_codigo = 2
GROUP BY reserva.id_reserva, hospede.cpf;

SELECT * FROM view_Reservation;

--Exercicio 4
--Crie uma view para apresentar o id_reserva, data do
--checkin e o status da reserva
DROP VIEW view_SimpleReservationInfo;

--CREATE VIEW view_SimpleReservationInfo AS
--SELECT id_reserva, checkin, status_codigo
--FROM reserva
--INNER JOIN status_pagamento

CREATE VIEW view_SimpleReservationInfo AS
SELECT id_reserva, checkin, status_codigo, metodo_pagamento.codigo, metodo_pagamento.rotulo
FROM reserva
INNER JOIN metodo_pagamento
ON metodo_pagamento.codigo = reserva.status_codigo
INNER JOIN status_pagamento
ON reserva.status_codigo = status_pagamento.codigo;

SELECT * FROM view_SimpleReservationInfo;

--Exercicio 5
--Crie uma view para apresentar
--o id_pagamento, imovel da reserva, valor_total da
--reserva, método do pagamento e status do pagamento
drop view view_Payment;
CREATE VIEW view_Payment AS
SELECT id_pagamento, id_imovel, pagamento.valor_total, metodo_pagamento.rotulo, reserva.status_codigo
FROM reserva
INNER JOIN pagamento
ON reserva.id_reserva = pagamento.id_pagamento
INNER JOIN metodo_pagamento
ON metodo_pagamento.codigo = reserva.status_codigo
ORDER BY id_pagamento ASC; --GROUP BY id_pagamento, id_imovel, metodo_pagamento.rotulo, reserva.status_codigo;

SELECT * FROM view_Payment;

--Exercicio 6
--Usando a view do exercício 3, encontre as reservas
--mais de 3 dias (considerando checkin e checkout)
SELECT * FROM view_Reservation
WHERE total_days > 3;

--Exercicio 7
--Usando a view do exercício 4, encontre todos os
--pagamentos feitos utilizado pix
SELECT * FROM view_SimpleReservationInfo
WHERE codigo = 1;