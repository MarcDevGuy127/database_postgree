CREATE DATABASE MECANICOAPP;

CREATE TABLE IF NOT EXISTS "lojista" (
	"id_lojista" INTEGER NOT NULL UNIQUE,
	"nome" VARCHAR(255) NOT NULL,
	"email" VARCHAR(255) NOT NULL,
	"telefone" VARCHAR(255) NOT NULL,
	PRIMARY KEY("id_lojista")
);




CREATE TABLE IF NOT EXISTS "usuario" (
	"id_usuario" INTEGER NOT NULL UNIQUE,
	"nome" VARCHAR(60) NOT NULL,
	"email" VARCHAR(50) NOT NULL,
	"senha" VARCHAR(16) NOT NULL,
	"telefone" VARCHAR(255) NOT NULL,
	"latitude" DECIMAL NOT NULL,
	"longitude" DECIMAL NOT NULL,
	PRIMARY KEY("id_usuario")
);




CREATE TABLE IF NOT EXISTS "loja" (
	"id_loja" INTEGER NOT NULL UNIQUE,
	"id_lojista" INTEGER NOT NULL,
	"nome" VARCHAR(255) NOT NULL,
	"endereco" VARCHAR(255) NOT NULL,
	"latitude" DECIMAL NOT NULL,
	"longitude" DECIMAL NOT NULL,
	PRIMARY KEY("id_loja")
);




CREATE TABLE IF NOT EXISTS "peca" (
	"id_peca" INTEGER NOT NULL UNIQUE,
	"nome" VARCHAR(255) NOT NULL,
	"marca" VARCHAR(255) NOT NULL,
	"cod_referencia" VARCHAR(255) NOT NULL,
	"descricao" TEXT NOT NULL,
	PRIMARY KEY("id_peca")
);




CREATE TABLE IF NOT EXISTS "estoque" (
	"id_estoque" INTEGER NOT NULL UNIQUE,
	"id_loja" INTEGER NOT NULL,
	"id_peca" INTEGER NOT NULL,
	"preco" DECIMAL NOT NULL,
	"qtde" INTEGER NOT NULL,
	PRIMARY KEY("id_estoque")
);




CREATE TABLE IF NOT EXISTS "pedido" (
	"id_pedido" INTEGER NOT NULL UNIQUE,
	"id_usuario" INTEGER NOT NULL,
	"data" TIMESTAMP NOT NULL,
	"status" VARCHAR(255) NOT NULL,
	PRIMARY KEY("id_pedido")
);




CREATE TABLE IF NOT EXISTS "mecanico" (
	"id_mecanico" INTEGER NOT NULL UNIQUE,
	"nome" VARCHAR(255) NOT NULL,
	"telefone" VARCHAR(255) NOT NULL,
	"especialidade" VARCHAR(255) NOT NULL,
	"endereco" VARCHAR(255) NOT NULL,
	"latitude" DECIMAL NOT NULL,
	"longitude" DECIMAL NOT NULL,
	PRIMARY KEY("id_mecanico")
);




CREATE TABLE IF NOT EXISTS "servico" (
	"id_servico" INTEGER NOT NULL UNIQUE,
	"id_usuario" INTEGER NOT NULL,
	"id_mecanico" INTEGER NOT NULL,
	"id_peca" INTEGER NOT NULL,
	"descricao" TEXT NOT NULL,
	"data_servico" TIMESTAMP NOT NULL,
	"valor_servico" DECIMAL NOT NULL,
	PRIMARY KEY("id_servico")
);





ALTER TABLE "loja"
ADD FOREIGN KEY("id_lojista") REFERENCES "lojista"("id_lojista")
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "estoque"
ADD FOREIGN KEY("id_loja") REFERENCES "loja"("id_loja")
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "estoque"
ADD FOREIGN KEY("id_peca") REFERENCES "peca"("id_peca")
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "pedido"
ADD FOREIGN KEY("id_usuario") REFERENCES "usuario"("id_usuario")
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "servico"
ADD FOREIGN KEY("id_usuario") REFERENCES "usuario"("id_usuario")
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "servico"
ADD FOREIGN KEY("id_mecanico") REFERENCES "mecanico"("id_mecanico")
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "servico"
ADD FOREIGN KEY("id_peca") REFERENCES "peca"("id_peca")
ON UPDATE NO ACTION ON DELETE NO ACTION;INSERT INTO "lojista" ("id_lojista", "nome", "email", "telefone") VALUES
(1, 'Carlos Mendes', 'carlos.mendes@email.com', '(41) 99911-1001'),
(2, 'Fernanda Alves', 'fernanda.alves@email.com', '(41) 99911-1002'),
(3, 'Ricardo Souza', 'ricardo.souza@email.com', '(41) 99911-1003');

INSERT INTO "usuario" ("id_usuario", "nome", "email", "senha", "telefone", "latitude", "longitude") VALUES
(1, 'Lucas Pereira', 'lucas@email.com', '12345678', '(41) 99888-1001', -25.428400, -49.273300),
(2, 'Mariana Silva', 'mariana@email.com', '12345678', '(41) 99888-1002', -25.429000, -49.270000),
(3, 'Joao Santos', 'joao@email.com', '12345678', '(41) 99888-1003', -25.430500, -49.275000),
(4, 'Ana Costa', 'ana@email.com', '12345678', '(41) 99888-1004', -25.427000, -49.280000),
(5, 'Bruno Lima', 'bruno@email.com', '12345678', '(41) 99888-1005', -25.431200, -49.268500);

INSERT INTO "loja" ("id_loja", "id_lojista", "nome", "endereco", "latitude", "longitude") VALUES
(1, 1, 'Auto Pecas Curitiba Centro', 'Rua XV de Novembro, 500 - Centro, Curitiba/PR', -25.429500, -49.271800),
(2, 1, 'Auto Pecas Curitiba Sul', 'Av. Republica Argentina, 1200 - Portao, Curitiba/PR', -25.476200, -49.292100),
(3, 2, 'Pecas Express', 'Rua Chile, 850 - Reboucas, Curitiba/PR', -25.447800, -49.265400),
(4, 3, 'Oficina e Pecas Boa Vista', 'Rua Holanda, 300 - Boa Vista, Curitiba/PR', -25.395100, -49.246700);

INSERT INTO "peca" ("id_peca", "nome", "marca", "cod_referencia", "descricao") VALUES
(1, 'Pastilha de Freio', 'Bosch', 'BOS-1001', 'Pastilha de freio dianteira para veiculos de passeio'),
(2, 'Filtro de Oleo', 'Mann', 'MAN-2002', 'Filtro de oleo de alta eficiencia'),
(3, 'Amortecedor Dianteiro', 'Cofap', 'COF-3003', 'Amortecedor dianteiro lado esquerdo'),
(4, 'Bateria 60Ah', 'Moura', 'MOU-4004', 'Bateria automotiva 12V 60Ah'),
(5, 'Correia Dentada', 'Gates', 'GAT-5005', 'Correia dentada reforcada'),
(6, 'Vela de Ignicao', 'NGK', 'NGK-6006', 'Jogo de velas de ignicao'),
(7, 'Disco de Freio', 'TRW', 'TRW-7007', 'Disco de freio ventilado'),
(8, 'Filtro de Ar', 'Tecfil', 'TEC-8008', 'Filtro de ar do motor');

INSERT INTO "estoque" ("id_estoque", "id_loja", "id_peca", "preco", "qtde") VALUES
(1, 1, 1, 149.90, 20),
(2, 1, 2, 35.50, 50),
(3, 1, 4, 420.00, 10),
(4, 2, 3, 289.90, 15),
(5, 2, 5, 119.90, 18),
(6, 2, 6, 79.90, 40),
(7, 3, 1, 155.00, 12),
(8, 3, 7, 199.90, 16),
(9, 3, 8, 45.00, 35),
(10, 4, 2, 37.00, 28),
(11, 4, 4, 430.00, 8),
(12, 4, 6, 82.50, 22);

INSERT INTO "pedido" ("id_pedido", "id_usuario", "data", "status") VALUES
(1, 1, '2026-03-10 09:30:00', 'Pendente'),
(2, 2, '2026-03-10 10:15:00', 'Concluido'),
(3, 3, '2026-03-11 14:20:00', 'Em andamento'),
(4, 1, '2026-03-12 16:45:00', 'Cancelado'),
(5, 4, '2026-03-13 11:00:00', 'Concluido'),
(6, 5, '2026-03-14 13:10:00', 'Pendente');

INSERT INTO "mecanico" ("id_mecanico", "nome", "telefone", "especialidade", "endereco", "latitude", "longitude") VALUES
(1, 'Andre Oliveira', '(41) 99777-1001', 'Freios', 'Rua das Oficinas, 101 - Centro, Curitiba/PR', -25.430000, -49.272000),
(2, 'Paulo Henrique', '(41) 99777-1002', 'Suspensao', 'Av. Sete de Setembro, 2020 - Reboucas, Curitiba/PR', -25.440100, -49.268000),
(3, 'Juliana Martins', '(41) 99777-1003', 'Motor', 'Rua Itupava, 1500 - Alto da XV, Curitiba/PR', -25.418200, -49.255900),
(4, 'Roberto Lima', '(41) 99777-1004', 'Eletrica Automotiva', 'Rua Fernando de Noronha, 890 - Boa Vista, Curitiba/PR', -25.397700, -49.248300);

INSERT INTO "servico" ("id_servico", "id_usuario", "id_mecanico", "id_peca", "descricao", "data_servico", "valor_servico") VALUES
(1, 1, 1, 1, 'Troca de pastilhas de freio dianteiras', '2026-03-10 10:00:00', 120.00),
(2, 2, 3, 2, 'Troca de filtro de oleo e revisao basica', '2026-03-11 09:00:00', 80.00),
(3, 3, 2, 3, 'Substituicao de amortecedor dianteiro', '2026-03-11 15:30:00', 250.00),
(4, 4, 4, 4, 'Troca de bateria automotiva', '2026-03-12 11:20:00', 90.00),
(5, 5, 3, 5, 'Troca de correia dentada', '2026-03-13 14:00:00', 300.00),
(6, 1, 4, 6, 'Substituicao de velas de ignicao', '2026-03-14 08:45:00', 110.00),
(7, 2, 1, 7, 'Troca de disco de freio', '2026-03-14 16:10:00', 180.00),
(8, 3, 3, 8, 'Troca de filtro de ar', '2026-03-15 10:25:00', 70.00);--1. Mostrar todos os mecânicos da loja, organizados por tipo de especialidade
DROP VIEW IF EXISTS view_Mecanicos;

CREATE VIEW view_Mecanicos AS
SELECT nome, especialidade
FROM mecanico
ORDER BY especialidade ASC;

SELECT * FROM view_Mecanicos;

--2. Mostrar os serviços realizados na loja, com o nome do usuario, do mecânico e da peça, e o preço do serviço
DROP VIEW IF EXISTS view_Servicos;

CREATE VIEW view_Servicos AS
SELECT usuario.nome AS username,
mecanico.nome AS mechanic,
servico.descricao AS service,
peca.nome AS piece,
servico.valor_servico AS service_value,
loja.nome AS auto_repair
FROM mecanico
INNER JOIN servico
ON mecanico.id_mecanico = servico.id_usuario
INNER JOIN usuario
ON servico.id_usuario = usuario.id_usuario
INNER JOIN peca
ON usuario.id_usuario = peca.id_peca
INNER JOIN loja
ON peca.id_peca = loja.id_loja
ORDER BY usuario.nome ASC;

SELECT * FROM view_Servicos;
--3. Mostrar o nome das peças e a quantidade em estoque delas
DROP VIEW IF EXISTS view_Estoque;

CREATE VIEW view_Estoque AS
SELECT loja.nome, peca.nome, estoque.qtde
FROM estoque
INNER JOIN peca
ON estoque.id_peca = peca.id_peca
INNER JOIN loja
ON estoque.id_loja = loja.id_loja 
ORDER BY peca.nome ASC;

select *
from estoque;

SELECT * FROM view_Estoque;
--4. Mostrar o nome dos lojistas e da loja na qual ele trabalha
DROP VIEW IF EXISTS view_Lojistas;

CREATE VIEW view_Lojistas AS
SELECT lojista.nome AS employee, 
loja.nome AS store_name
FROM lojista
INNER JOIN loja
ON lojista.id_lojista = loja.id_loja
ORDER BY lojista.nome ASC;

SELECT * FROM view_Lojistas;

--5. Mostrar a receita bruta faturada na loja de peças
DROP VIEW IF EXISTS view_Fatura;

CREATE VIEW view_Fatura AS
SELECT loja.nome AS store_name,
SUM(servico.valor_servico) AS balance
FROM mecanico
INNER JOIN servico
ON mecanico.id_mecanico = servico.id_servico
INNER JOIN loja
ON servico.id_servico = loja.id_loja
GROUP BY loja.nome, servico.descricao;

SELECT * FROM view_Fatura;

--6. Mostrar a diferença: o valor total pago em um serviço e do valor total, qual é o valor da peça e qual é o valor do serviço
DROP VIEW IF EXISTS view_Diferenca;

CREATE VIEW view_Diferenca AS
SELECT 
s.id_servico,
ABS(s.valor_servico - e.preco) AS "difference",
e.preco AS "item_price",
s.valor_servico AS "service_value"
FROM servico s
INNER JOIN peca p ON p.id_peca = s.id_peca
INNER JOIN estoque e ON e.id_peca = s.id_peca
ORDER BY s.id_servico;

SELECT * FROM view_Diferenca;

--7. Mostrar as lojas próximas do usuario (estudar como funciona os Graus Decimais e o que significa uma “loja próxima”)
DROP VIEW IF EXISTS vw_Lojas_Proximas;

CREATE VIEW vw_Lojas_Proximas AS
SELECT 
    l.id_loja,
    u.id_usuario,
    
    6371 * 2 * ASIN(
        SQRT(
            POWER(SIN(RADIANS(l.latitude - u.latitude) / 2), 2) +
            COS(RADIANS(u.latitude)) *
            COS(RADIANS(l.latitude)) *
            POWER(SIN(RADIANS(l.longitude - u.longitude) / 2), 2)
        )
    ) AS distancia_km

FROM loja l
CROSS JOIN usuario u
ORDER BY distancia_km;

SELECT * FROM vw_Lojas_Proximas;

--8. Mostrar todos os serviços realizados no último mês
DROP VIEW IF EXISTS vw_servicos_detalhados;

CREATE VIEW view_Servicos_Realizados AS
SELECT
    s.id_servico,
    u.nome AS usuario,
    m.nome AS mecanico,
    m.especialidade,
    p.nome AS peca,
    s.descricao,
    s.data_servico,
    s.valor_servico
FROM servico s
INNER JOIN usuario u ON u.id_usuario = s.id_usuario
INNER JOIN mecanico m ON m.id_mecanico = s.id_mecanico
INNER JOIN peca p ON p.id_peca = s.id_peca;

SELECT * FROM view_Servicos_Realizados;--1
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
