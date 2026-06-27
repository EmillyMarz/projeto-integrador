-- =============================================================================
-- PROJETO INTEGRADOR - BLOCO 3: ARQUITETURA E MODELAGEM DE DADOS
-- SCRIPT DE CRIAÇÃO DO BANCO DE DADOS RELACIONAL (MySQL)
-- MÍNIMO EXIGIDO: 5 TABELAS COM RELACIONAMENTOS E CHAVES PRIMÁRIAS/ESTRANGEIRAS
-- =============================================================================

CREATE DATABASE IF NOT EXISTS pi_bloco3;
USE pi_bloco3;

-- -----------------------------------------------------------------------------
-- TABELA 1: PERFIS (Gerenciamento de Níveis de Acesso)
-- -----------------------------------------------------------------------------
CREATE TABLE perfis (
    id INT AUTO_INCREMENT,
    nome_perfil VARCHAR(50) NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_perfis PRIMARY KEY (id),
    CONSTRAINT uq_nome_perfil UNIQUE (nome_perfil)
) ENGINE=InnoDB;

-- -----------------------------------------------------------------------------
-- TABELA 2: USUÁRIOS (Cadastro Geral de Membros/Clientes do Sistema)
-- -----------------------------------------------------------------------------
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    perfil_id INT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_usuarios PRIMARY KEY (id),
    CONSTRAINT uq_usuario_email UNIQUE (email),
    CONSTRAINT fk_usuario_perfil FOREIGN KEY (perfil_id) 
        REFERENCES perfis(id) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- -----------------------------------------------------------------------------
-- TABELA 3: CATEGORIAS (Classificação de Itens/Serviços do Sistema)
-- -----------------------------------------------------------------------------
CREATE TABLE categorias (
    id INT AUTO_INCREMENT,
    nome_categoria VARCHAR(100) NOT NULL,
    descricao TEXT,
    CONSTRAINT pk_categorias PRIMARY KEY (id),
    CONSTRAINT uq_nome_categoria UNIQUE (nome_categoria)
) ENGINE=InnoDB;

-- -----------------------------------------------------------------------------
-- TABELA 4: PRODUTOS (Itens, Serviços ou Entidades Principais do Negócio)
-- -----------------------------------------------------------------------------
CREATE TABLE produtos (
    id INT AUTO_INCREMENT,
    nome_produto VARCHAR(150) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    categoria_id INT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_produtos PRIMARY KEY (id),
    CONSTRAINT fk_produto_categoria FOREIGN KEY (categoria_id) 
        REFERENCES categorias(id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- -----------------------------------------------------------------------------
-- TABELA 5: PEDIDOS (Histórico de Operações, Interações ou Transações)
-- -----------------------------------------------------------------------------
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    produto_id INT NOT NULL,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status_pedido VARCHAR(50) DEFAULT 'Pendente',
    CONSTRAINT pk_pedidos PRIMARY KEY (id),
    CONSTRAINT fk_pedido_usuario FOREIGN KEY (usuario_id) 
        REFERENCES usuarios(id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    CONSTRAINT fk_pedido_produto FOREIGN KEY (produto_id) 
        REFERENCES produtos(id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
) ENGINE=InnoDB;