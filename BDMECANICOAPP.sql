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
ON UPDATE NO ACTION ON DELETE NO ACTION;

INSERT INTO "lojista" ("id_lojista", "nome", "email", "telefone") VALUES
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
(8, 3, 3, 8, 'Troca de filtro de ar', '2026-03-15 10:25:00', 70.00);


