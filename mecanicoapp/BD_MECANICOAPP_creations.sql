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