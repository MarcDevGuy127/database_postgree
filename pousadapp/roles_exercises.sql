CREATE ROLE adiministrador;
CREATE ROLE atendente;
CREATE ROLE financeiro;

--admin
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public
TO administrador;

--atendente
GRANT SELECT ON ALL TABLES IN SCHEMA public
TO atendente;
GRANT UPDATE ON reserva TO atendente;
GRANT INSERT ON reserva TO atendente;

--financeiro
GRANT UPDATE ON pagamento TO financeiro;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO financeiro;