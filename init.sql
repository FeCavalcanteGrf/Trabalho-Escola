DROP TABLE IF EXISTS atividade_aluno;
DROP TABLE IF EXISTS atividade;
DROP TABLE IF EXISTS presenca;
DROP TABLE IF EXISTS pagamento;
DROP TABLE IF EXISTS aluno;
DROP TABLE IF EXISTS turma;
DROP TABLE IF EXISTS professor;
DROP TABLE IF EXISTS usuario;

CREATE TABLE professor (
    id_professor INTEGER PRIMARY KEY,
    nome_completo VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20)
);

CREATE TABLE turma (
    id_turma INTEGER PRIMARY KEY,
    nome_turma VARCHAR(50) NOT NULL,
    id_professor INT,
    horario VARCHAR(100),
    FOREIGN KEY (id_professor) REFERENCES professor(id_professor)
);

CREATE TABLE aluno (
    id_aluno INTEGER PRIMARY KEY,
    nome_completo VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    id_turma INT,
    nome_responsavel VARCHAR(255),
    telefone_responsavel VARCHAR(20),
    email_responsavel VARCHAR(100),
    informacoes_adicionais TEXT,
    endereco VARCHAR(255),  -- Adicionada a coluna endereco
    cidade VARCHAR(100),
    estado VARCHAR(100),
    cep VARCHAR(20),
    pais VARCHAR(100),
    telefone VARCHAR(20),
    FOREIGN KEY (id_turma) REFERENCES turma(id_turma)
);

CREATE TABLE pagamento (
    id_pagamento INTEGER PRIMARY KEY,
    id_aluno INT,
    data_pagamento DATE NOT NULL,
    valor_pago DECIMAL(10, 2) NOT NULL,
    forma_pagamento VARCHAR(50),
    referencia VARCHAR(100),
    status VARCHAR(20),
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
);

CREATE TABLE presenca (
    id_presenca INTEGER PRIMARY KEY,
    id_aluno INT,
    data_presenca DATE NOT NULL,
    presente BOOLEAN,
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
);

CREATE TABLE atividade (
    id_atividade INTEGER PRIMARY KEY,
    descricao TEXT NOT NULL,
    data_realizacao DATE NOT NULL
);

CREATE TABLE atividade_aluno (
    id_atividade INT,
    id_aluno INT,
    PRIMARY KEY (id_atividade, id_aluno),
    FOREIGN KEY (id_atividade) REFERENCES atividade(id_atividade),
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
);

CREATE TABLE usuario (
    id_usuario INTEGER PRIMARY KEY,
    login VARCHAR(50) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    nivel_acesso VARCHAR(20),
    id_professor INT,
    FOREIGN KEY (id_professor) REFERENCES professor(id_professor)
);

INSERT INTO professor (id_professor, nome_completo, email, telefone) VALUES 
(1, 'Carlos Mendes', 'carlos@escola.com', '11987654321'),
(2, 'Fernanda Lima', 'fernanda@escola.com', '21987654321');

INSERT INTO turma (id_turma, nome_turma, id_professor, horario) VALUES 
(1, 'Turma C', 1, '14:00 - 16:00'),
(2, 'Turma D', 2, '16:00 - 18:00');

INSERT INTO aluno (id_aluno, nome_completo, data_nascimento, id_turma, nome_responsavel, telefone_responsavel, email_responsavel, endereco, cidade, estado, cep, pais, telefone) VALUES 
(1, 'Ana Costa', '2012-01-10', 1, 'João Costa', '11912345678', 'joao@escola.com', 'Rua D, 101', 'Curitiba', 'PR', '80000-000', 'Brasil', '41987654321'),
(2, 'Lucas Silva', '2011-11-25', 1, 'Maria Silva', '21912345678', 'maria@escola.com', 'Rua E, 202', 'Fortaleza', 'CE', '60000-000', 'Brasil', '85987654321'),
(3, 'Mariana Oliveira', '2010-09-15', 2, 'Carlos Oliveira', '31912345678', 'carlos@escola.com', 'Rua F, 303', 'Belo Horizonte', 'MG', '30000-000', 'Brasil', '31987654321');

INSERT INTO pagamento (id_pagamento, id_aluno, data_pagamento, valor_pago, forma_pagamento, referencia, status) VALUES 
(1, 1, '2025-04-01', 250.00, 'Pix', 'Mensalidade Abril', 'Pago'),
(2, 2, '2025-04-01', 250.00, 'Boleto', 'Mensalidade Abril', 'Pendente');

INSERT INTO presenca (id_presenca, id_aluno, data_presenca, presente) VALUES 
(1, 1, '2025-04-01', TRUE),
(2, 2, '2025-04-01', TRUE);

INSERT INTO atividade (id_atividade, descricao, data_realizacao) VALUES 
(1, 'Atividade de Ciências', '2025-04-10'),
(2, 'Atividade de História', '2025-04-15');

INSERT INTO atividade_aluno (id_atividade, id_aluno) VALUES 
(1, 1),
(1, 2),
(2, 2),
(2, 3);

INSERT INTO usuario (id_usuario, login, senha, nivel_acesso, id_professor) VALUES 
(1, 'professor1', 'senha_hash_123', 'professor', 1),
(2, 'admin1', 'senha_hash_456', 'administrador', NULL);