SELECT * FROM imovel;

BEGIN
SELECT AVG(valor_diaria) AS media,
MIN(valor_diaria) AS minimo,
MAX(valor_diaria) AS maximo,
SUM(valor_diaria) AS soma
FROM imovel;

UPDATE imovel
SET valor_diaria = valor_diaria + (valor_diaria * 0.10)
WHERE tipo_codigo IN (1,2);

SELECT AVG(valor_diaria) AS media,
MIN(valor_diaria) AS minimo,
MAX(valor_diaria) AS maximo,
SUM(valor_diaria) AS soma
FROM imovel;

ROLLBACK;
