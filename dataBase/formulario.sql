-- Criação do banco de dados
CREATE DATABASE formulario;
USE formulario;

-- Criação das tabelas
CREATE TABLE departamentos (
    departamento VARCHAR(50) PRIMARY KEY,
    responsavel VARCHAR(100)
);

CREATE TABLE funcionarios (
    matriculaFunc INT PRIMARY KEY,
    nomeFunc VARCHAR(100),
    departamento VARCHAR(50),
    assinaturaFunc VARCHAR(100) UNIQUE, -- Adicionando UNIQUE aqui
    statusFunc VARCHAR(20),
    CONSTRAINT fk_func_departamento 
        FOREIGN KEY (departamento) REFERENCES departamentos(departamento)
);

CREATE TABLE materiais (
    nomeProduto VARCHAR(100) PRIMARY KEY,
    quantProduto INT
);
ALTER TABLE materiais ADD CONSTRAINT chk_quantProduto CHECK (quantProduto >= 0);

CREATE TABLE pedidos (
    idPedido INT PRIMARY KEY AUTO_INCREMENT,
    produtoPedido VARCHAR(100),
    quantPedido INT,
    statusPedido ENUM('Pendente', 'Confirmado', 'Aprovado', 'Cancelado') DEFAULT 'Pendente', -- Adicionando 'Cancelado'
    assinaturaFunc VARCHAR(100),
    confirmado BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_pedidos_materiais
        FOREIGN KEY (produtoPedido) REFERENCES materiais(nomeProduto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_pedidos_funcionarios
        FOREIGN KEY (assinaturaFunc) REFERENCES funcionarios(assinaturaFunc)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
ALTER TABLE pedidos ADD COLUMN dataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE pedidos ADD CONSTRAINT chk_quantPedido CHECK (quantPedido >= 0);
CREATE INDEX idx_produtoPedido ON pedidos(produtoPedido);
CREATE INDEX idx_assinaturaFunc ON pedidos(assinaturaFunc);

CREATE TABLE almoxarifado (
    matriculaFunc INT,
    vistoAlmo VARCHAR(100),
    confirmacao BOOLEAN,
    CONSTRAINT fk_almoxarifado_funcionarios
        FOREIGN KEY (matriculaFunc) REFERENCES funcionarios(matriculaFunc)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Limpar tabelas antes de popular
TRUNCATE TABLE departamentos;
TRUNCATE TABLE funcionarios;
TRUNCATE TABLE materiais;
TRUNCATE TABLE pedidos;
TRUNCATE TABLE almoxarifado;

-- Inserir dados nas tabelas
INSERT INTO departamentos (departamento, responsavel) VALUES
('TI', 'Kaique Gomes'),
('Diretoria', 'Samuel Aparecido'),
('Almoxarifado', 'Luan Henrique'),
('Estoque', 'Gabriel Melo'),
('RH', 'Arthur Ferreira'),
('Marketing', 'Marcos Trajano');

INSERT INTO funcionarios (matriculaFunc, nomeFunc, departamento, assinaturaFunc, statusFunc) VALUES
(1001, 'Kaique Gomes', 'TI', 'KaiqueG', 'Ativo'),
(1002, 'Samuel Aparecido', 'Diretoria', 'SamuelA', 'Ativo'),
(1003, 'Luan Henrique', 'Almoxarifado', 'LuanH', 'Passivo'),
(1004, 'Gabriel Melo', 'Estoque', 'GabrielM', 'Ativo'),
(1005, 'Arthur Ferreira', 'RH', 'ArthurF', 'Passivo'),
(1006, 'Marcos Trajano', 'Marketing', 'MarcosT', 'Ativo');

INSERT INTO materiais (nomeProduto, quantProduto) VALUES
('Caneta', 100),
('Papel A4', 500),
('Lápis', 200),
('Grampeador', 1000),
('Caderno', 5050),
('Agenda', 1020),
('Sufite', 1250),
('Postit', 1450),
('Cola', 2344),
('Cola Bastão', 666),
('Grampo', 1234),
('Clips', 4321);

INSERT INTO pedidos (produtoPedido, quantPedido, statusPedido, dataPedido, assinaturaFunc) VALUES
('Papel A4', 50, 'KaiqueG');

-- Trigger para verificar o estoque antes de inserir um pedido
DELIMITER //

CREATE TRIGGER verifica_estoque_pedido
BEFORE INSERT ON pedidos
FOR EACH ROW
BEGIN
    DECLARE qtd_estoque INT;

    -- Busca a quantidade disponível no estoque para o material do pedido
    SELECT quantProduto INTO qtd_estoque
    FROM materiais
    WHERE nomeProduto = NEW.produtoPedido;

    -- Verifica se o material existe no estoque
    IF qtd_estoque IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Material não encontrado no estoque.';
    -- Verifica se a quantidade do pedido excede o estoque disponível
    ELSEIF NEW.quantPedido > qtd_estoque THEN
        -- Atualiza o status do pedido para 'Cancelado'
        SET NEW.statusPedido = 'Cancelado';
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: A quantidade do pedido excede o estoque disponível. Pedido cancelado.';
    END IF;
END //

-- Trigger para atualizar a quantidade no estoque após a inserção do pedido
CREATE TRIGGER atualiza_estoque_pedido
AFTER INSERT ON pedidos
FOR EACH ROW
BEGIN
    -- Atualiza a quantidade de estoque na tabela materiais
    UPDATE materiais
    SET quantProduto = quantProduto - NEW.quantPedido
    WHERE nomeProduto = NEW.produtoPedido;
END //

-- Trigger para não atualizar o estoque após confirmação ou aprovação do pedido
CREATE TRIGGER nao_atualiza_estoque
AFTER UPDATE ON pedidos
FOR EACH ROW
BEGIN
    IF NEW.confirmado = TRUE AND OLD.confirmado = FALSE THEN
        -- Não faz nada, pois o estoque já foi atualizado na inserção do pedido
    END IF;
END //

DELIMITER ;

-- Procedure para confirmar pedidos
DELIMITER //

CREATE PROCEDURE confirmar_pedido(IN p_idPedido INT)
BEGIN
    DECLARE pedido_status ENUM('Pendente', 'Confirmado', 'Aprovado', 'Cancelado');

    -- Obter o status do pedido
    SELECT statusPedido INTO pedido_status FROM pedidos WHERE idPedido = p_idPedido;

    -- Verifica se o pedido já foi aprovado
    IF pedido_status = 'Aprovado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: O pedido já foi aprovado e não pode ser confirmado.';
    ELSE
        -- Atualiza o pedido para confirmado
        UPDATE pedidos
        SET confirmado = TRUE, statusPedido = 'Confirmado'
        WHERE idPedido = p_idPedido;
    END IF;
END //

DELIMITER ;

-- Procedure para aprovar pedidos
DELIMITER //

CREATE PROCEDURE aprovar_pedido(IN p_idPedido INT)
BEGIN
    DECLARE qtd_estoque INT;
    DECLARE produto VARCHAR(100);
    DECLARE matricula INT;  -- Variável para armazenar a matrícula do funcionário que aprova

    -- Obter o produto do pedido
    SELECT produtoPedido INTO produto FROM pedidos WHERE idPedido = p_idPedido;

    -- Verificar a quantidade disponível no estoque
    SELECT quantProduto INTO qtd_estoque FROM materiais WHERE nomeProduto = produto;

    -- Verifica se a quantidade do pedido não excede o estoque
    IF (SELECT quantPedido FROM pedidos WHERE idPedido = p_idPedido) <= qtd_estoque THEN
        -- Atualiza o status do pedido para 'Aprovado'
        UPDATE pedidos
        SET statusPedido = 'Aprovado'
        WHERE idPedido = p_idPedido;

        -- Inserir registro na tabela almoxarifado
        -- Substitua 'matricula_funcionario' pela matrícula do funcionário que está aprovando
        SET matricula = 1003; -- Exemplo, você pode pegar isso dinamicamente, dependendo do seu fluxo

        INSERT INTO almoxarifado (matriculaFunc, vistoAlmo, confirmacao)
        VALUES (matricula, CONCAT('Aprovado o pedido ID: ', p_idPedido), TRUE);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: A quantidade do pedido excede o estoque disponível. Pedido cancelado.';
        -- Atualiza o status do pedido para 'Cancelado'
        UPDATE pedidos
        SET statusPedido = 'Cancelado'
        WHERE idPedido = p_idPedido;
    END IF;
END //

DELIMITER ;

-- Exemplo de uso
CALL confirmar_pedido(1);  -- Confirma o pedido
CALL aprovar_pedido(1);     -- Aprova o pedido
