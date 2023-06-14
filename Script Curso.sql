CREATE DATABASE curso_db;

USE curso_db;

CREATE TABLE instrutor(
id int unsigned auto_increment not null,
instrutor varchar(45) not null,
telefone varchar(9) null,

PRIMARY KEY (id)
);

CREATE TABLE curso_tipos(
id int unsigned auto_increment not null,
nome varchar(45) not null,

PRIMARY KEY (id)
);

CREATE TABLE curso(
id int unsigned auto_increment not null,
nome varchar(45) not null,
valor double not null,
tipo_id int unsigned not null,
instrutor_id int unsigned not null,

FOREIGN KEY (instrutor_id) REFERENCES instrutor(id),
FOREIGN KEY (tipo_id) REFERENCES curso_tipos(id),
PRIMARY KEY (id)
);

CREATE TABLE aluno(
id int unsigned auto_increment not null,
nome varchar(45) not null,
endereço varchar(230) not null,
email varchar(128) not null,

PRIMARY KEY (id)
);

CREATE TABLE pedido(
id int unsigned auto_increment not null,
data_pedido date not null,
hora_pedido time not null,
aluno_id int unsigned not null,

FOREIGN KEY (aluno_id) REFERENCES aluno(id),
PRIMARY KEY (id)
);

CREATE TABLE pedido_detalhe(
valor double not null,
pedido_id int unsigned not null,
curso_id int unsigned not null,

FOREIGN KEY (pedido_id) REFERENCES pedido(id),
FOREIGN KEY (curso_id) REFERENCES curso(id),
PRIMARY KEY (pedido_id, curso_id)
);

ALTER TABLE curso_tipos RENAME TO curso_tipo;

ALTER TABLE aluno ADD data_nascimento varchar(10) not null;

ALTER TABLE aluno ADD data_nascimento varchar(10) not null;

ALTER TABLE aluno CHANGE data_nascimento nascimento date not null;

CREATE INDEX aluno_nome ON aluno(nome);

INSERT INTO curso_tipo 
	VALUES 
    (1, 'Banco de dados'),
	(2, 'Programação'),
	(3, 'Modelagem de dados');

INSERT INTO instrutor 
	VALUES
	(1, 'André Milani', '1111-1111'),
	(2, 'Carlos Tosin', '1212-1212');

INSERT INTO curso (id, nome, tipo_id, instrutor_id, valor)
	VALUES
	(1, 'Java Fundamentos', 2, 2, 270),
	(2, 'Java Avançado', 2, 2, 330),
	(3, 'SQL Completo', 1, 1, 170),
	(4, 'Php Básico', 2, 1, 270);

INSERT INTO aluno 
	VALUES 
    (1, 'José', 'Rua XV de Novembro 72', 'jose@softblue.com.br', '1999-10-15'),
	(2, 'Wagner', 'Av. Paulista', 'wagner@softblue.com.br', '1999-10-15'),
	(3, 'Emílio', 'Rua Lajes 103, ap: 701', 'emilio@softblue.com.br', '1999-10-15'),
	(4, 'Cris', 'Rua Tauney 22', 'cris@softblue.com.br', '1999-10-15'),
	(5, 'Regina', 'Rua Salles 305', 'regina@softblue.com.br', '1999-10-15'),
	(6, 'Fernando', 'Av. Central 30', 'fernando@softblue.com.br', '1999-10-15');

INSERT INTO pedido (id, aluno_id, data_pedido, hora_pedido)
	VALUES
	(1, 2, '2010-04-15', '11:23:32'),
	(2, 2, '2010-04-15', '14:36:21'),
	(3, 3, '2010-04-16', '11:17:45'),
	(4, 4, '2010-04-17', '14:27:22'),
	(5, 5, '2010-04-18', '11:18:19'),
	(6, 6, '2010-04-19', '13:47:35'),
	(7, 6, '2010-04-20', '18:13:44');

INSERT INTO pedido_detalhe (pedido_id, curso_id, valor)
	VALUES
	(1, 1, 270),
	(1, 2, 330),
	(2, 1, 270),
	(2, 2, 330),
	(2, 3, 170),
	(3, 4, 270),
	(4, 2, 330),
	(4, 4, 270),
	(5, 3, 170),
	(6, 3, 170),
	(7, 4, 270);
    
SELECT *, nome FROM curso;

SELECT nome FROM curso;

SELECT nome, valor FROM curso WHERE valor > 200;

SELECT nome, valor FROM curso WHERE valor > 200 AND valor < 300;

SELECT * FROM pedido WHERE data_pedido > '2010-04-15' AND data_pedido < '2010-04-18';

SELECT * FROM pedido WHERE data_pedido = '2010-04-15';

UPDATE aluno SET endereço = 'Av. Brasil 777' WHERE nome = 'José';

UPDATE aluno SET email = 'cristiano@softblue.com' WHERE nome = 'Cris';

SET SQL_SAFE_UPDATES = 0;
UPDATE curso SET valor = ROUND(valor *1.1, 2) WHERE valor < 300;


SELECT c.nome, t.nome FROM curso c INNER JOIN curso_tipo t on c.tipo_id = t.id;

SELECT c.nome, t.nome, i.instrutor, i.telefone FROM curso c 
INNER JOIN curso_tipo t on c.tipo_id = t.id
INNER JOIN instrutor i on c.instrutor_id = i.id;

SELECT p.id, p.data_pedido, p.hora_pedido, d.curso_id FROM pedido p
INNER JOIN pedido_detalhe d on p.id = d.pedido_id;

SELECT p.id, p.data_pedido, p.hora_pedido, c.nome FROM pedido p
INNER JOIN pedido_detalhe d on p.id = d.pedido_id
INNER JOIN curso c on d.curso_id = c.id
ORDER BY p.id;

CREATE VIEW prog_cursos AS 
SELECT c.nome, c.valor FROM curso c
JOIN curso_tipo t on c.tipo_id = t.id 
WHERE t.nome = 'Programação';

CREATE VIEW inst_cursos AS
SELECT c.nome, t.nome AS 'Tipo', i.instrutor FROM curso c
JOIN curso_tipo t on c.tipo_id = t.id
JOIN instrutor i on c.instrutor_id = i.id;

CREATE VIEW pedi_realizados AS
SELECT p.id, a.nome, p.data_pedido FROM pedido p
JOIN aluno a on a.id = p.aluno_id;

DROP VIEW prog_cursos;

SELECT * FROM pedi_realizados;
SELECT * FROM pedido;


SELECT DISTINCT(nome) FROM aluno;

SELECT DISTINCT(a.nome) FROM aluno a
JOIN pedido p ON a.id = p.aluno_id;

SELECT DISTINCT(a.nome) FROM aluno a
JOIN pedido p ON a.id = p.aluno_id
ORDER BY p.data_pedido
LIMIT 1;

SELECT DISTINCT(a.nome) FROM aluno a
JOIN pedido p ON a.id = p.aluno_id
ORDER BY p.data_pedido DESC
LIMIT 1;

SELECT DISTINCT(a.nome) FROM aluno a
JOIN pedido p ON a.id = p.aluno_id
ORDER BY p.data_pedido
LIMIT 1
OFFSET 2;

SELECT COUNT(id) FROM pedido;

SELECT SUM(valor) FROM pedido_detalhe;

SELECT AVG(valor) FROM pedido_detalhe WHERE pedido_id = 2;

SELECT MAX(valor) FROM curso;

SELECT MIN(valor) FROM curso;

SELECT * FROM pedido_detalhe;

SELECT pedido_id, SUM(valor) FROM pedido_detalhe GROUP BY pedido_id;

SELECT i.instrutor, COUNT(c.id) AS 'qtd_cursos' FROM instrutor i
JOIN curso c ON i.id = c.instrutor_id
GROUP BY i.instrutor;

SELECT p.id, a.nome, SUM(d.valor) AS 'Total' FROM pedido p 
JOIN aluno a ON p.aluno_id = a.id
JOIN pedido_detalhe d ON p.id = d.pedido_id
GROUP BY p.id
HAVING SUM(d.valor) > 500;

SELECT p.id, a.nome, COUNT(d.curso_id) FROM pedido p
JOIN aluno a ON p.aluno_id = a.id
JOIN pedido_detalhe d ON d.pedido_id = p.id
GROUP BY p.id
HAVING COUNT(d.curso_id) >= 2;

SELECT aluno, endereço FROM aluno WHERE endereço LIKE 'Av%';

SELECT curso FROM curso WHERE curso LIKE '%java%';

SELECT nome, (SELECT MIN(valor) FROM pedido_detalhe WHERE pedido_detalhe.curso_id = curso.id) AS MENOR_VALOR FROM curso;

SELECT nome FROM curso WHERE tipo_id = (SELECT id FROM curso_tipo WHERE nome = "Programação");
SELECT c.nome FROM curso c JOIN curso_tipo t ON c.tipo_id = t.id WHERE t.nome = "Programação";


SELECT nome FROM curso WHERE EXISTS (SELECT id FROM curso_tipo WHERE curso_tipo.id = curso.tipo_id AND nome = "Programação");

SELECT instrutor, 
	(
    SELECT SUM(valor) FROM pedido_detalhe 
    WHERE curso_id IN 
		(
        SELECT id FROM curso
        WHERE instrutor_id = instrutor.id
        )
    ) AS "Total vendas"
FROM instrutor;

CREATE VIEW gasto_aluno AS SELECT nome, 
	(
    SELECT SUM(d.valor) FROM pedido_detalhe d 
    INNER JOIN pedido p ON d.pedido_id = p.id 
    WHERE p.aluno_id = a.id
    ) AS total 
FROM aluno a;

SELECT * FROM gasto_aluno;

CREATE USER 'larry'@'localhost' IDENTIFIED BY 'larry123';
GRANT ALL ON curso_db.* TO 'larry'@'localhost';
GRANT SELECT ON curso_db.curso TO 'larry'@'localhost';
REVOKE SELECT ON curso_db.curso FROM 'larry'@'localhost';

DROP USER 'larry'@'localhost';

start transaction;
UPDATE curso SET valor = 200 WHERE id = 3;
rollback;

start transaction;
UPDATE curso SET valor = 200 WHERE id = 3;
commit;

SELECT * FROM curso;