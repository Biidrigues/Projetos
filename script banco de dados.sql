-- Schema DybaSftw
DROP DATABASE dybasftw;
CREATE DATABASE DybaSftw;
USE DybaSftw;

-- -----------------------------------------------------
-- Table Cliente
-- -----------------------------------------------------
CREATE TABLE Cliente (
  idCliente INT PRIMARY KEY AUTO_INCREMENT,
  cpf VARCHAR(11) UNIQUE KEY,
  datanasc DATE,
  nome VARCHAR(100),
  genero ENUM('Masculino', 'Feminino'),
  email VARCHAR(100) UNIQUE KEY,
  telefone VARCHAR(11),
  ativo TINYINT DEFAULT 1);
  
INSERT INTO cliente(cpf, datanasc, nome, genero, email, telefone)
	VALUES('14152563607', '1980-02-19', 'Cesar Cristiano', 1, 'cesar.cris@gmail.com', '11978455879'), 
    ('12457832596', '1994-07-24', 'Ana Paula', 2, 'anapaula@outlook.com', '1152414789');
-- -----------------------------------------------------
-- Table Equipamento
-- -----------------------------------------------------
CREATE TABLE Equipamento (
  idEquipamento INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  tipo ENUM('Hardware', 'Software') NOT NULL,
  ativo TINYINT DEFAULT 1);
  
INSERT INTO Equipamento(nome, tipo)
	VALUES('CPU', 1), ('Tela', 1), ('Fonte', 1), ('Mouse', 1);
    
-- -----------------------------------------------------
-- Table Chamado
-- -----------------------------------------------------
CREATE TABLE Chamado (
  idChamado INT PRIMARY KEY AUTO_INCREMENT,
  logAbertura VARCHAR(200) NOT NULL,
  status ENUM('Em Atendimento', 'Interrompido', 'Encaminhado', 'Encerrado', 'Aguardando Visita') DEFAULT 'Em Atendimento',
  procedimentos VARCHAR(400),
  dataAbertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  ultimaAtualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE NOW(),
  dataAgendamento DATE,
  dataEncerrado TIMESTAMP,
  protocolo VARCHAR(10) NOT NULL,
  idCliente INT NOT NULL,
  idEquipamento INT NOT NULL,
  CONSTRAINT fk_Chamado_Cliente
    FOREIGN KEY (idCliente)
    REFERENCES Cliente (idCliente),
  CONSTRAINT fk_Chamado_Equipamento
    FOREIGN KEY (idEquipamento)
    REFERENCES Equipamento (idEquipamento));

INSERT INTO Chamado(logAbertura, protocolo, idCliente, idEquipamento)
	VALUES('Duplo cliqe no mouse', '1234567890', 1, 4);

-- -----------------------------------------------------
-- Table ProblemasComuns
-- -----------------------------------------------------
CREATE TABLE ProblemasComuns (
  idProblemasComuns INT PRIMARY KEY AUTO_INCREMENT,
  descricaoProblema VARCHAR(100) NOT NULL,
  instrucoes VARCHAR(400) NOT NULL,
  idEquipamento INT NOT NULL,
  CONSTRAINT fk_ProblemasComuns_Equipamento
    FOREIGN KEY (idEquipamento)
    REFERENCES Equipamento (idEquipamento) ON DELETE CASCADE);
    
INSERT INTO ProblemasComuns(descricaoProblema, instrucoes, idEquipamento)
	VALUES('Computador não liga', '-Verificar a Tomada -Trocar a fonte', 3),
		  ('Duplo clique', 'trocar o mouse', 4);
    
-- -----------------------------------------------------
-- Table Funcionarios
-- -----------------------------------------------------
CREATE TABLE Funcionarios (
  idFuncionarios INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(45) NOT NULL UNIQUE KEY,
  senha VARCHAR(45) NOT NULL,
  cargo ENUM('Atendente', 'Tecnico', 'Gerente'),
  ativo TINYINT DEFAULT 1);

INSERT INTO Funcionarios(nome, email, senha, cargo)
	VALUES('João da Silva', 'joaosilva@email.com', '123456789', 1),
    ('Mauricio Meireles', 'mauriciomei@email.com', '123deoliveira4', 2),
    ('Ricardo Conceição', 'ricardoconceicao@emial.com', 'senha', 3);
    
-- -----------------------------------------------------
-- Table Chamado_has_Funcionarios
-- -----------------------------------------------------
CREATE TABLE Chamado_has_Funcionarios (
  Chamado_idChamado INT NOT NULL,
  Funcionarios_idFuncionarios INT NOT NULL,
  PRIMARY KEY (Chamado_idChamado, Funcionarios_idFuncionarios),
  CONSTRAINT fk_Chamado_has_Funcionarios_Chamado
    FOREIGN KEY (Chamado_idChamado)
    REFERENCES Chamado (idChamado),
  CONSTRAINT fk_Chamado_has_Funcionarios_Funcionarios
    FOREIGN KEY (Funcionarios_idFuncionarios)
    REFERENCES Funcionarios (idFuncionarios));
    
INSERT INTO Chamado_has_Funcionarios
	VALUES(1, 2);
    
SELECT idFuncionarios, nome, cargo FROM funcionarios WHERE email = 'joaosilva@email.com' AND senha = '123456789' AND ativo = 1;