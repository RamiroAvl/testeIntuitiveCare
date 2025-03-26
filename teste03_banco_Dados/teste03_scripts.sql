
CREATE TABLE cadop (
    registro_ans VARCHAR(20) PRIMARY KEY,
    cnpj VARCHAR(18),
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(100),
    logradouro VARCHAR(255),
    numero VARCHAR(50),
    complemento VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf VARCHAR(2),
    cep VARCHAR(10),
    ddd VARCHAR(2),
    telefone VARCHAR(20),
    fax VARCHAR(20),
    endereco_eletronico VARCHAR(100),
    representante VARCHAR(255),
    cargo_representante VARCHAR(100),
    regiao_de_comercializacao VARCHAR(100),
    data_registro_ans DATE
);

--------

CREATE TABLE demonstracoes_contabeis (
    data DATE,
    reg_ans VARCHAR(20),
    cd_conta_contabil VARCHAR(50),
    descricao VARCHAR(255),
    vl_saldo_inicial NUMERIC(15, 2),
    vl_saldo_final NUMERIC(15, 2)
);


--------

COPY cadop (
    registro_ans, cnpj, razao_social, nome_fantasia, modalidade,
    logradouro, numero, complemento, bairro, cidade, uf, cep,
    ddd, telefone, fax, endereco_eletronico, representante, cargo_representante, regiao_de_comercializacao, data_registro_ans
)
FROM '/teste03_banco_Dados/Relatorio_cadop.csv'
WITH (
    FORMAT CSV,
    DELIMITER ';',
    HEADER TRUE,
    ENCODING 'UTF-8'
);

--------

COPY demonstracoes_contabeis (
    data, reg_ans, cd_conta_contabil, descricao, 
    vl_saldo_inicial, vl_saldo_final
)
FROM '/teste03_banco_Dados/1T2023.csv'
WITH (
    FORMAT CSV,
    DELIMITER ';',
    HEADER TRUE,
    ENCODING 'UTF-8'
);

-------

COPY demonstracoes_contabeis (
    data, reg_ans, cd_conta_contabil, descricao, 
    vl_saldo_inicial, vl_saldo_final
)
FROM '/teste03_banco_Dados/1T2024.csv'
WITH (
    FORMAT CSV,
    DELIMITER ';',
    HEADER TRUE,
    ENCODING 'UTF-8'
);

--------

COPY demonstracoes_contabeis (
    data, reg_ans, cd_conta_contabil, descricao, 
    vl_saldo_inicial, vl_saldo_final
)
FROM '/teste03_banco_Dados/2t2023.csv'
WITH (
    FORMAT CSV,
    DELIMITER ';',
    HEADER TRUE,
    ENCODING 'UTF-8'
);

---

COPY demonstracoes_contabeis (
    data, reg_ans, cd_conta_contabil, descricao, 
    vl_saldo_inicial, vl_saldo_final
)
FROM '/teste03_banco_Dados/2T2024.csv'
WITH (
    FORMAT CSV,
    DELIMITER ';',
    HEADER TRUE,
    ENCODING 'UTF-8'
);

----

COPY demonstracoes_contabeis (
    data, reg_ans, cd_conta_contabil, descricao, 
    vl_saldo_inicial, vl_saldo_final
)
FROM '/teste03_banco_Dados/3T2023.csv'
WITH (
    FORMAT CSV,
    DELIMITER ';',
    HEADER TRUE,
    ENCODING 'UTF-8'
);

-------
COPY demonstracoes_contabeis (
    data, reg_ans, cd_conta_contabil, descricao, 
    vl_saldo_inicial, vl_saldo_final
)
FROM '/teste03_banco_Dados/3T2024.csv'
WITH (
    FORMAT CSV,
    DELIMITER ';',
    HEADER TRUE,
    ENCODING 'UTF-8'
);

-------

COPY demonstracoes_contabeis (
    data, reg_ans, cd_conta_contabil, descricao, 
    vl_saldo_inicial, vl_saldo_final
)
FROM '/teste03_banco_Dados/4T2023.csv'
WITH (
    FORMAT CSV,
    DELIMITER ';',
    HEADER TRUE,
    ENCODING 'UTF-8'
);

----

COPY demonstracoes_contabeis (
    data, reg_ans, cd_conta_contabil, descricao, 
    vl_saldo_inicial, vl_saldo_final
)
FROM '/teste03_banco_Dados/4T2024.csv'
WITH (
    FORMAT CSV,
    DELIMITER ';',
    HEADER TRUE,
    ENCODING 'UTF-8'
);

------

/*
1: Ultimos 3 meses a partir da data do registro mais recente
2: Ultimo trimestre completo: out-dez 2024
3: Ultimos 3 meses que nao vai ter nenhum
O registro mais recente está com a data em outubro de 2024, então conclui que o trimestre terminaria no fim de dezembro de 2024
*/
SELECT c.razao_social, c.registro_ans, SUM(d.vl_saldo_inicial - d.vl_saldo_final) AS despesa_total
FROM cadop c
JOIN demonstracoes_contabeis d ON c.registro_ans = d.reg_ans
WHERE d.descricao = 'EVENTOS/SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE HOSPITALAR'
  AND d.data BETWEEN '2024-07-01' AND '2024-12-31'
GROUP BY c.razao_social, c.registro_ans
ORDER BY despesa_total DESC
LIMIT 10;

----------

SELECT c.razao_social, c.registro_ans, SUM(d.vl_saldo_inicial - d.vl_saldo_final) AS despesa_total
FROM cadop c
JOIN demonstracoes_contabeis d ON c.registro_ans = d.reg_ans
WHERE d.descricao = 'EVENTOS/SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE HOSPITALAR'
  AND d.data BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY c.razao_social, c.registro_ans
ORDER BY despesa_total DESC
LIMIT 10;