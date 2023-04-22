-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 22, 2023 at 07:49 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `empresa`
--

-- --------------------------------------------------------

--
-- Table structure for table `atendimento`
--

CREATE TABLE `atendimento` (
  `protocolo` int(11) DEFAULT NULL,
  `situacao` char(12) DEFAULT NULL,
  `data_atendimento` datetime DEFAULT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `cliente_cpf` char(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `atendimento`
--

INSERT INTO `atendimento` (`protocolo`, `situacao`, `data_atendimento`, `titulo`, `descricao`, `cliente_cpf`) VALUES
(201, 'CONCLUIDO', '2022-04-10 00:00:00', 'Devolução', 'Devolução de geladeira', '11111111111'),
(202, 'EM ANDAMENTO', '2022-05-13 00:00:00', 'Duvida', 'Duvida sobre garantia', '33333333333'),
(203, 'EM ANDAMENTO', '2022-05-19 00:00:00', 'Pagamneto', 'Estorno de pagamento', '33333333333');

-- --------------------------------------------------------

--
-- Table structure for table `cliente`
--

CREATE TABLE `cliente` (
  `cpf` char(11) DEFAULT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `end_estado` char(2) DEFAULT NULL,
  `end_cidade` varchar(255) DEFAULT NULL,
  `end_bairro` varchar(255) DEFAULT NULL,
  `end_rua` varchar(255) DEFAULT NULL,
  `end_num` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cliente`
--

INSERT INTO `cliente` (`cpf`, `nome`, `end_estado`, `end_cidade`, `end_bairro`, `end_rua`, `end_num`) VALUES
('11111111111', 'Bianca', 'CE', 'Crateus', 'Venancios', 'Rua Pedro I', 500),
('22222222222', 'Manoel', 'CE', 'Sobral', 'Jardins', 'Rua Coronel Chico', 1233),
('33333333333', 'Raquel', 'PI', 'Picos', 'Joquei', 'Rua Dr Pessoa', 15);

-- --------------------------------------------------------

--
-- Table structure for table `cliente_produto`
--

CREATE TABLE `cliente_produto` (
  `cliente_cpf` char(11) DEFAULT NULL,
  `produto_codigo` int(11) DEFAULT NULL,
  `data_compra` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cliente_produto`
--

INSERT INTO `cliente_produto` (`cliente_cpf`, `produto_codigo`, `data_compra`) VALUES
('22222222222', 6732, '2022-03-10 00:00:00'),
('11111111111', 4008, '2022-01-22 00:00:00'),
('11111111111', 6732, '2022-04-28 00:00:00'),
('33333333333', 4008, '2021-12-22 00:00:00'),
('33333333333', 5120, '2021-12-22 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `produto`
--

CREATE TABLE `produto` (
  `codigo` int(11) DEFAULT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `produto`
--

INSERT INTO `produto` (`codigo`, `nome`, `descricao`) VALUES
(6732, 'Geladeira Consul X3', 'Geladeira - Consul Modelo X3 - Dual'),
(5120, 'Microondas LG Z4', 'Microondas - LG Modelo Z4 - 20L - 2022'),
(4008, 'Playstation 5', 'Sony - Playstation 5');

-- --------------------------------------------------------

--
-- Table structure for table `telefone`
--

CREATE TABLE `telefone` (
  `cliente_cpf` char(11) DEFAULT NULL,
  `telefone` char(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `telefone`
--

INSERT INTO `telefone` (`cliente_cpf`, `telefone`) VALUES
('11111111111', '85999991111'),
('11111111111', '85988881111'),
('22222222222', '88989892222'),
('33333333333', '86983338833'),
('33333333333', '86999993333');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
