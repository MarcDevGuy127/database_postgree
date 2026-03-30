

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