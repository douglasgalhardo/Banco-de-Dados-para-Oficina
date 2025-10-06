CREATE DATABASE IF NOT EXISTS oficina;
USE oficina;

-- TABELA CLIENTE
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Telefone VARCHAR(20),
    Email VARCHAR(255) UNIQUE,
    Endereco VARCHAR(255)
);

-- TABELA VEÍCULO
CREATE TABLE Veiculo (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    Placa CHAR(7) NOT NULL UNIQUE,
    Modelo VARCHAR(50) NOT NULL,
    Marca VARCHAR(50),
    Ano INT,
    CONSTRAINT fk_veiculo_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- TABELA EQUIPE
CREATE TABLE Equipe (
    idEquipe INT AUTO_INCREMENT PRIMARY KEY,
    NomeEquipe VARCHAR(100) NOT NULL
);

-- TABELA MECÂNICO
CREATE TABLE Mecanico (
    idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    idEquipe INT,
    Nome VARCHAR(255) NOT NULL,
    Endereco VARCHAR(255),
    Especialidade VARCHAR(100),
    CONSTRAINT fk_mecanico_equipe FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe)
);

-- TABELA ORDEM DE SERVIÇO (OS)
CREATE TABLE OrdemServico (
    idOS INT AUTO_INCREMENT PRIMARY KEY,
    idVeiculo INT,
    idEquipe INT,
    NumeroOS VARCHAR(50) NOT NULL UNIQUE,
    DataEmissao DATE NOT NULL,
    DataConclusao DATE,
    ValorTotal FLOAT,
    StatusOS ENUM('Aguardando Aprovação', 'Aprovada', 'Em Execução', 'Concluída', 'Cancelada') NOT NULL DEFAULT 'Aguardando Aprovação',
    CONSTRAINT fk_os_veiculo FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo),
    CONSTRAINT fk_os_equipe FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe)
);

-- TABELA SERVIÇO (TABELA DE REFERÊNCIA)
CREATE TABLE Servico (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(255) NOT NULL,
    ValorMaoDeObra FLOAT NOT NULL
);

-- TABELA PEÇA (TABELA DE REFERÊNCIA)
CREATE TABLE Peca (
    idPeca INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(255) NOT NULL,
    ValorUnitario FLOAT NOT NULL
);

-- TABELA DE RELACIONAMENTO SERVIÇOS NA OS (M:N)
CREATE TABLE Servicos_OS (
    idOS INT,
    idServico INT,
    PRIMARY KEY (idOS, idServico),
    CONSTRAINT fk_servicos_os_os FOREIGN KEY (idOS) REFERENCES OrdemServico(idOS),
    CONSTRAINT fk_servicos_os_servico FOREIGN KEY (idServico) REFERENCES Servico(idServico)
);

-- TABELA DE RELACIONAMENTO PEÇAS NA OS (M:N)
CREATE TABLE Pecas_OS (
    idOS INT,
    idPeca INT,
    Quantidade INT NOT NULL DEFAULT 1,
    PRIMARY KEY (idOS, idPeca),
    CONSTRAINT fk_pecas_os_os FOREIGN KEY (idOS) REFERENCES OrdemServico(idOS),
    CONSTRAINT fk_pecas_os_peca FOREIGN KEY (idPeca) REFERENCES Peca(idPeca)
);
