

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
SELECT id_imovel, titulo, tipo_imovel.rotulo, AVG(valor_diaria) 
FROM imovel
INNER JOIN tipo_imovel
ON imovel.tipo_codigo = tipo_imovel.codigo
GROUP BY imovel.id_imovel, imovel.titulo, tipo_imovel.rotulo;

SELECT * FROM view_Houses;