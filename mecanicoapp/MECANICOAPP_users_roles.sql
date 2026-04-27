--1
CREATE USER marcelo WITH SUPERUSER 
PASSWORD 'M@rce01';

CREATE USER ravel WITH SUPERUSER 
PASSWORD 'R@vel02';

CREATE USER thiago WITH SUPERUSER 
PASSWORD 'Thi@g03';

--2
CREATE ROLE usuario;
GRANT SELECT(nome, email, senha, telefone, latitude, longitude),
  UPDATE(nome, email, senha, telefone, latitude, longitude) ON usuario TO usuario;
GRANT SELECT ON pedido TO usuario;
GRANT SELECT ON servico TO usuario;

CREATE ROLE loja;
GRANT SELECT, UPDATE, INSERT, DELETE ON lojista TO loja;
GRANT SELECT, INSERT, UPDATE, DELETE ON estoque TO loja;

CREATE ROLE lojista;
GRANT SELECT, INSERT ON pedido TO lojista;
GRANT SELECT ON mecanico TO lojista;
GRANT SELECT, UPDATE, INSERT ON usuario TO lojista;

CREATE ROLE mecanico;
GRANT SELECT, INSERT, UPDATE(descricao, data_servico, valor_servico) ON servico TO mecanico;
GRANT UPDATE(nome, telefone, especialidade, endereco, latitude, longitude) ON mecanico TO mecanico;
GRANT SELECT ON peca to mecanico;
GRANT SELECT ON servico TO mecanico;

CREATE ROLE estoque;
GRANT SELECT, UPDATE, INSERT, DELETE ON peca to estoque;
GRANT SELECT, UPDATE, INSERT, DELETE ON estoque to estoque;

--2.3
CREATE USER lucaspereira
PASSWORD 'Luc@si0p';
GRANT usuario TO lucaspereira;

CREATE USER pexpress_loja
PASSWORD 'Pec@s101';
GRANT loja TO pexpress_loja;

CREATE USER carlos_lojista
PASSWORD 'C@rl0s70';
GRANT lojista TO carlos_lojista;

CREATE USER andre_mecanico
PASSWORD '@Ndre0p1';
GRANT mecanico TO andre_mecanico;

CREATE USER jorge_estoque
PASSWORD 'Est@qu1E';
GRANT estoque TO jorge_estoque;

--3
-- As tabelas mais sensíveis são: estoque, mecanico, lojista, usuario.

--4
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM adalovelace;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO adalovelace;

--5
REVOKE ALL PRIVILEGES ON ALL TABLES 
FROM alanturing;
DROP USER alanturing;
