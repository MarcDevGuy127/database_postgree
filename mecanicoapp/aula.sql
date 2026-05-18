CREATE INDEX idx_imovel_locatario
ON imovel(id_locatario);

EXPLAIN ANALYZE
SELECT u.nome, i.titulo, 
i.valor_diaria
FROM imovel i
JOIN locatario l ON i.id_locatario 
= l.id_locatario
JOIN usuario u ON l.id_usuario = 
u.id_usuario
WHERE l.id_locatario = 3;

DROP INDEX idx_imovel_locatario

SELECT setval(
  pg_get_serial_sequence('imovel', 
'id_imovel'), COALESCE((SELECT 
MAX(id_imovel) + 1 FROM imovel), 
1), false);

WITH ids AS (
  SELECT
    ARRAY(SELECT id_locatario FROM locatario) AS locatarios,
    ARRAY(SELECT codigo FROM tipo_imovel) AS tipos
)
INSERT INTO imovel (id_locatario,titulo,descricao, 
valor_diaria,tipo_codigo) SELECT
  locatarios[(floor(random() * array_length(locatarios, 1)) + 
1)::int],
  'Imóvel de teste ' || g,
  'Descrição gerada automaticamente para teste de desempenho. 
Registro ' || g,
  round((80 + random() * 920)::numeric, 2),
  tipos[(floor(random() * array_length(tipos, 1)) + 1)::int]
FROM generate_series(1, 100000) AS g
CROSS JOIN ids;

ANALYZE imovel;

EXPLAIN ANALYZE 
SELECT * FROM imovel 
WHERE id_locatario = 3;