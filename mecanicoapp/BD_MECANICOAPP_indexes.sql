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

SELECT * FROM usuario;