--Exercicio 1
--Crie uma view para retornar o id do usuário, o seu 
--nome, cpf (no caso de hospede) ou cnpj (no caso de 
--locatario) e email. 

SELECT * FROM usuario;

CREATE VIEW view_Users
AS SELECT COUNT(id_usuario, nome, email
FROM usuario
WHERE = (SELECT cpf FROM hospede);

--DROP VIEW view_Users;

SELECT * FROM view_Users;