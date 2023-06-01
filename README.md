# DDL - Definir/Criar
## CREATE
```
CREATE DATABASE databasename;

CREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    column3 datatype,
   ....
);
```

## ALTER
```
ALTER TABLE table_name (OPERATION)
```

Operations:

- ADD

  * ```ADD column_name datatype;```

- DROP

  * ```DROP COLUMN column_name;```

- MODIFY

  * ```MODIFY COLUMN column_name datatype;```

- RENAME

  * ```RENAME COLUMN old_name to new_name;```

- CHANGE

  * ```CHANGE COLUMN old_name new_name datatype;```


## DROP
```
DROP DATABASE databasename;

DROP TABLE table_name;
```

# DML - Manipular
## INSERT
```
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);
```

## UPDATE
```
UPDATE table_name
SET column1 = value1, column2 = value2, ...
(ADDONS)
```

#### Desabilitar o SQL_SAFE_UPDATES para poder fazer UPDATE sem WHERE
```SET SQL_SAFE_UPDATES = 0;```

## DELETE
```
DELETE FROM table_name
WHERE condition;
```

# DQL - Consultar
## SELECT
```
SELECT column1, column2, ...
FROM table_name;
```

## JOIN
  * GROUP BY
  Agrupa linhas com os mesmos valores, normalmente usada com funções agregadoras
```
GROUP BY column1, column2, ...;
```

  * HAVING
  Funciona como o WHERE para funções agregadoras
```
HAVING condition;
```


### INNER JOIN
```
INNER JOIN table ON old_table.common_field = new_table.common_field;
```

### LEFT JOIN
```
LEFT JOIN table ON old_table.common_field = new_table.common_field;
```


### FULL JOIN
```
LEFT JOIN table ON old_table.common_field = new_table.common_field

UNION

RIGHT JOIN table ON old_table.common_field = new_table.common_field;
```

### SELF JOIN
```
SELECT column1, column2, ...
FROM table_X a, table_X b
WHERE a.common_field = b.common_field;
```


# DCL - Controle de Dados
```
CREATE USER 'name'@'ipadress || localhost' IDENTIFIED BY 'password';
```

## GRANT
```
GRANT type ON database.table TO 'name'@'ipadress';
```

## REVOKE
```
REVOKE type ON database.table FROM 'name'@'ipadress';
```

# DTL - Transação de Dados
Utilizar o comando SHOW ENGINE para visualizar informações sobre o banco de dados.

Escolher o que possui suporte para transações (InnoDB - Default no MySQL)

## START TRANSACTION
Expressão inicial para começar transação.

## COMMIT
Expressão final para quando a transação for bem sucedida.

## ROLLBACK
Expressão final para quando a transação falhar.

Data base volta para o estado inicial.

# Addons

## WHERE
```
WHERE condition;
```
  * LIKE
```
LIKE 'pattern';

WHERE CustomerName LIKE 'a%'	#Finds any values that starts with "a"
WHERE CustomerName LIKE '%a'	#Finds any values that ends with "a"
WHERE CustomerName LIKE '%or%'	#Finds any values that have "or" in any position
```

  * IN
```
IN (value1, value2, ...);
```

  * BETWEEN
```
BETWEEN value1 AND value2;
```

## Pagination
  * ORDER BY
```
ORDER BY column1, column2, ... ASC|DESC;
```

  * LIMIT
```
LIMIT number;
```

  * DISTINCT
```
DISTINCT column1, column2, ...;
```

  * OFFSET
```
OFFSET number;
```



# Aggregate Functions
## COUNT
```
COUNT(column_name);
```

## SUM
```
SUM(column_name);
```

## AVG
```
AVG(column_name);
```

## MIN
```
MIN(column_name);
```

## MAX
```
MAX(column_name);
```

## IF
```
IF(condition, value_if_true, value_if_false);
```


