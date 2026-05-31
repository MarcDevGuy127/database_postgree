
--GENERATING 100K OF REGISTERS
INSERT INTO "usuario"
("id_usuario", "nome", "email", "senha", "telefone", "latitude", "longitude")

SELECT
    generate_series(6,100005),
    'Usuario',
    'usuario' || generate_series(6,100005) || '@email.com',
    '12345678',
    '(41) 99999-9999',
    -25.428400,
    -49.273300;

E
SELECT * FROM usuario;

-- FK QUERY
EXPLAIN ANALYZE
SELECT u.id_usuario, s.id_usuario, u.nome
FROM usuario u
INNER JOIN servico s ON s.id_usuario = u.id_usuario;

-- COMPOSED QUERY
EXPLAIN ANALYZE
SELECT u.id_usuario, s.id_usuario, u.nome, s.id_servico, s.valor_servico
FROM usuario u
INNER JOIN servico s ON s.id_usuario = u.id_usuario
WHERE s.id_servico > 1 AND s.valor_servico < 100;

-- PARTIAL QUERY
EXPLAIN ANALYZE
SELECT *
FROM usuario u
WHERE u.id_usuario % 2 = 0;

-- LOG QUERY
EXPLAIN ANALYZE
SELECT *
FROM pedido p
WHERE p.data BETWEEN '2026-03-10' AND '2026-03-11';

-- INDEXES
-- 1
DROP INDEX IF EXISTS idx_pedido_usuario;
CREATE INDEX idx_pedido_usuario
ON pedido(id_usuario);

-- 2
DROP INDEX IF EXISTS idx_usuario_pedido_status;
CREATE INDEX idx_usuario_pedido_status
ON pedido(id_usuario, id_pedido, status);

-- 3
DROP INDEX IF EXISTS idx_pedidos_pendentes;
CREATE INDEX idx_pedidos_pendentes
ON pedido(status)
WHERE status = 'Pendente';

-- BRIN
DROP INDEX IF EXISTS idx_pedido_logs_data;
CREATE INDEX idx_pedido_logs_data
ON pedido
USING BRIN(data);

-- ANALYZE
ANALYZE usuario;

-- SELECT
EXPLAIN ANALYZE
SELECT *
FROM usuario
WHERE nome LIKE '%o%'
AND telefone LIKE '%9%';