-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 04-Jun-2023 às 22:10
-- Versão do servidor: 10.4.27-MariaDB
-- versão do PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `empresa2`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `alocacao`
--

CREATE TABLE `alocacao` (
  `projeto_id` int(11) NOT NULL,
  `empregado_id` int(11) NOT NULL,
  `numHoras` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `departamento`
--

CREATE TABLE `departamento` (
  `id` int(11) NOT NULL,
  `nome` varchar(40) DEFAULT NULL,
  `gerente_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `departamento_localizacao`
--

CREATE TABLE `departamento_localizacao` (
  `departamento_id` int(11) NOT NULL,
  `localizacao` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `empregado`
--

CREATE TABLE `empregado` (
  `id` int(11) NOT NULL,
  `cpf` char(11) DEFAULT NULL,
  `nome` varchar(40) DEFAULT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `sexo` varchar(15) DEFAULT NULL,
  `salario` double DEFAULT NULL,
  `supervisor_id` int(11) DEFAULT NULL,
  `departamento_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `empregado_dependente`
--

CREATE TABLE `empregado_dependente` (
  `empregado_id` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `sexo` varchar(20) DEFAULT NULL,
  `data_nascimento` datetime DEFAULT NULL,
  `parentesco` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `projeto`
--

CREATE TABLE `projeto` (
  `id` int(11) NOT NULL,
  `nome` varchar(30) DEFAULT NULL,
  `localizacao` varchar(255) DEFAULT NULL,
  `departamento_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `alocacao`
--
ALTER TABLE `alocacao`
  ADD PRIMARY KEY (`projeto_id`,`empregado_id`),
  ADD KEY `fk_empregado` (`empregado_id`);

--
-- Índices para tabela `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_gerente_id` (`gerente_id`);

--
-- Índices para tabela `departamento_localizacao`
--
ALTER TABLE `departamento_localizacao`
  ADD PRIMARY KEY (`departamento_id`,`localizacao`);

--
-- Índices para tabela `empregado`
--
ALTER TABLE `empregado`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cpf` (`cpf`),
  ADD KEY `fk_supervisor` (`supervisor_id`),
  ADD KEY `fk_departamento` (`departamento_id`);

--
-- Índices para tabela `empregado_dependente`
--
ALTER TABLE `empregado_dependente`
  ADD PRIMARY KEY (`empregado_id`,`nome`);

--
-- Índices para tabela `projeto`
--
ALTER TABLE `projeto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_dptoProj` (`departamento_id`);

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `alocacao`
--
ALTER TABLE `alocacao`
  ADD CONSTRAINT `fk_empregado` FOREIGN KEY (`empregado_id`) REFERENCES `empregado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_proj` FOREIGN KEY (`projeto_id`) REFERENCES `projeto` (`id`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `departamento`
--
ALTER TABLE `departamento`
  ADD CONSTRAINT `fk_gerente_id` FOREIGN KEY (`gerente_id`) REFERENCES `empregado` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Limitadores para a tabela `departamento_localizacao`
--
ALTER TABLE `departamento_localizacao`
  ADD CONSTRAINT `fk_dpto` FOREIGN KEY (`departamento_id`) REFERENCES `departamento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `empregado`
--
ALTER TABLE `empregado`
  ADD CONSTRAINT `fk_departamento` FOREIGN KEY (`departamento_id`) REFERENCES `departamento` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_supervisor` FOREIGN KEY (`supervisor_id`) REFERENCES `empregado` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Limitadores para a tabela `empregado_dependente`
--
ALTER TABLE `empregado_dependente`
  ADD CONSTRAINT `fk_empregadoDependente` FOREIGN KEY (`empregado_id`) REFERENCES `empregado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `projeto`
--
ALTER TABLE `projeto`
  ADD CONSTRAINT `fk_dptoProj` FOREIGN KEY (`departamento_id`) REFERENCES `departamento` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
