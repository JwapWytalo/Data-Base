-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 07, 2023 at 11:13 PM
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
-- Database: `loja`
--

-- --------------------------------------------------------

--
-- Table structure for table `categorias`
--

CREATE TABLE `categorias` (
  `nome` varchar(30) DEFAULT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `item_venda`
--

CREATE TABLE `item_venda` (
  `venda_codigo` int(11) DEFAULT NULL,
  `produto_codigo` int(11) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `produtos`
--

CREATE TABLE `produtos` (
  `codigo` int(11) NOT NULL,
  `nome_produto` varchar(100) DEFAULT NULL,
  `preco` double DEFAULT NULL,
  `descricao` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `produto_categoria`
--

CREATE TABLE `produto_categoria` (
  `produto_codigo` int(11) DEFAULT NULL,
  `categoria_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `venda`
--

CREATE TABLE `venda` (
  `vendedor_cpf` char(11) DEFAULT NULL,
  `preco_total` double DEFAULT NULL,
  `data_venda` datetime DEFAULT NULL,
  `itens` varchar(30) DEFAULT NULL,
  `codigo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `vendedor`
--

CREATE TABLE `vendedor` (
  `nome` varchar(24) DEFAULT NULL,
  `data_nascimento` datetime DEFAULT NULL,
  `telefone` char(12) DEFAULT NULL,
  `cpf` char(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item_venda`
--
ALTER TABLE `item_venda`
  ADD KEY `fk_venda_codigo` (`venda_codigo`),
  ADD KEY `fk_produto_codigo` (`produto_codigo`);

--
-- Indexes for table `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`codigo`);

--
-- Indexes for table `produto_categoria`
--
ALTER TABLE `produto_categoria`
  ADD KEY `fk_produtoCodigo` (`produto_codigo`),
  ADD KEY `fk_categoriaId` (`categoria_id`);

--
-- Indexes for table `venda`
--
ALTER TABLE `venda`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `fk_vendedorCpf` (`vendedor_cpf`);

--
-- Indexes for table `vendedor`
--
ALTER TABLE `vendedor`
  ADD PRIMARY KEY (`cpf`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `item_venda`
--
ALTER TABLE `item_venda`
  ADD CONSTRAINT `fk_produto_codigo` FOREIGN KEY (`produto_codigo`) REFERENCES `produtos` (`codigo`),
  ADD CONSTRAINT `fk_venda_codigo` FOREIGN KEY (`venda_codigo`) REFERENCES `venda` (`codigo`);

--
-- Constraints for table `produto_categoria`
--
ALTER TABLE `produto_categoria`
  ADD CONSTRAINT `fk_categoriaId` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`),
  ADD CONSTRAINT `fk_produtoCodigo` FOREIGN KEY (`produto_codigo`) REFERENCES `produtos` (`codigo`);

--
-- Constraints for table `venda`
--
ALTER TABLE `venda`
  ADD CONSTRAINT `fk_vendedorCpf` FOREIGN KEY (`vendedor_cpf`) REFERENCES `vendedor` (`cpf`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
