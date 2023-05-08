-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 08, 2023 at 04:54 AM
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
-- Database: `clinica`
--

-- --------------------------------------------------------

--
-- Table structure for table `atendentes`
--

CREATE TABLE `atendentes` (
  `nome` varchar(40) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `ender_cidade` varchar(30) DEFAULT NULL,
  `ender_cep` int(11) DEFAULT NULL,
  `ender_rua` varchar(30) DEFAULT NULL,
  `ender_bairro` varchar(30) DEFAULT NULL,
  `ender_estado` varchar(30) DEFAULT NULL,
  `ender_numero` int(11) DEFAULT NULL,
  `cpf` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cadastra_medico`
--

CREATE TABLE `cadastra_medico` (
  `medico_crm` int(11) DEFAULT NULL,
  `atendente_cpf` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cadastra_paciente`
--

CREATE TABLE `cadastra_paciente` (
  `data` datetime DEFAULT NULL,
  `paciente_cpf` int(11) DEFAULT NULL,
  `atendente_cpf` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `consulta`
--

CREATE TABLE `consulta` (
  `codigo` int(11) NOT NULL,
  `data` datetime DEFAULT NULL,
  `tipo` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `email_paciente`
--

CREATE TABLE `email_paciente` (
  `email` varchar(30) DEFAULT NULL,
  `paciente_cpf` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `endereco_paciente`
--

CREATE TABLE `endereco_paciente` (
  `rua` varchar(30) DEFAULT NULL,
  `cidade` varchar(30) DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `bairro` varchar(30) DEFAULT NULL,
  `cep` int(11) DEFAULT NULL,
  `numero` int(11) DEFAULT NULL,
  `paciente_cpf` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `medico`
--

CREATE TABLE `medico` (
  `estado_crm` varchar(30) DEFAULT NULL,
  `crm` int(11) NOT NULL,
  `nome` varchar(30) DEFAULT NULL,
  `especialidade` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `medico_consulta`
--

CREATE TABLE `medico_consulta` (
  `medico_crm` int(11) DEFAULT NULL,
  `consulta_codigo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `paciente`
--

CREATE TABLE `paciente` (
  `nome` varchar(30) DEFAULT NULL,
  `cpf` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `paciente_consulta`
--

CREATE TABLE `paciente_consulta` (
  `paciente_cpf` int(11) DEFAULT NULL,
  `consulta_codigo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `registra_consulta`
--

CREATE TABLE `registra_consulta` (
  `atendente_cpf` int(11) DEFAULT NULL,
  `consulta_codigo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `atendentes`
--
ALTER TABLE `atendentes`
  ADD PRIMARY KEY (`cpf`);

--
-- Indexes for table `cadastra_medico`
--
ALTER TABLE `cadastra_medico`
  ADD KEY `fk_medico_crm` (`medico_crm`),
  ADD KEY `fk_atendente_cpf_consulta` (`atendente_cpf`);

--
-- Indexes for table `cadastra_paciente`
--
ALTER TABLE `cadastra_paciente`
  ADD KEY `fk_paciente_cpf_cadastro` (`paciente_cpf`),
  ADD KEY `fk_atendente_cpf_cadastro` (`atendente_cpf`);

--
-- Indexes for table `consulta`
--
ALTER TABLE `consulta`
  ADD PRIMARY KEY (`codigo`);

--
-- Indexes for table `email_paciente`
--
ALTER TABLE `email_paciente`
  ADD KEY `fk_paciente_cpf` (`paciente_cpf`);

--
-- Indexes for table `endereco_paciente`
--
ALTER TABLE `endereco_paciente`
  ADD KEY `fk_pacientecpf` (`paciente_cpf`);

--
-- Indexes for table `medico`
--
ALTER TABLE `medico`
  ADD PRIMARY KEY (`crm`);

--
-- Indexes for table `medico_consulta`
--
ALTER TABLE `medico_consulta`
  ADD KEY `fk_medico_crm_consulta` (`medico_crm`),
  ADD KEY `fk_consulta_codigo_consultaMedico` (`consulta_codigo`);

--
-- Indexes for table `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`cpf`);

--
-- Indexes for table `paciente_consulta`
--
ALTER TABLE `paciente_consulta`
  ADD KEY `fk_paciente_cpf_consulta` (`paciente_cpf`),
  ADD KEY `fk_consulta_codigo_consulta` (`consulta_codigo`);

--
-- Indexes for table `registra_consulta`
--
ALTER TABLE `registra_consulta`
  ADD KEY `fk_consulta_codigo_registra` (`consulta_codigo`),
  ADD KEY `fk_atendete_cpf_registra` (`atendente_cpf`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cadastra_medico`
--
ALTER TABLE `cadastra_medico`
  ADD CONSTRAINT `fk_atendente_cpf_consulta` FOREIGN KEY (`atendente_cpf`) REFERENCES `atendentes` (`cpf`),
  ADD CONSTRAINT `fk_medico_crm` FOREIGN KEY (`medico_crm`) REFERENCES `medico` (`crm`);

--
-- Constraints for table `cadastra_paciente`
--
ALTER TABLE `cadastra_paciente`
  ADD CONSTRAINT `fk_atendente_cpf_cadastro` FOREIGN KEY (`atendente_cpf`) REFERENCES `atendentes` (`cpf`),
  ADD CONSTRAINT `fk_paciente_cpf_cadastro` FOREIGN KEY (`paciente_cpf`) REFERENCES `paciente` (`cpf`);

--
-- Constraints for table `email_paciente`
--
ALTER TABLE `email_paciente`
  ADD CONSTRAINT `fk_paciente_cpf` FOREIGN KEY (`paciente_cpf`) REFERENCES `paciente` (`cpf`);

--
-- Constraints for table `endereco_paciente`
--
ALTER TABLE `endereco_paciente`
  ADD CONSTRAINT `fk_pacientecpf` FOREIGN KEY (`paciente_cpf`) REFERENCES `paciente` (`cpf`);

--
-- Constraints for table `medico_consulta`
--
ALTER TABLE `medico_consulta`
  ADD CONSTRAINT `fk_consulta_codigo_consultaMedico` FOREIGN KEY (`consulta_codigo`) REFERENCES `consulta` (`codigo`),
  ADD CONSTRAINT `fk_medico_crm_consulta` FOREIGN KEY (`medico_crm`) REFERENCES `medico` (`crm`);

--
-- Constraints for table `paciente_consulta`
--
ALTER TABLE `paciente_consulta`
  ADD CONSTRAINT `fk_consulta_codigo_consulta` FOREIGN KEY (`consulta_codigo`) REFERENCES `consulta` (`codigo`),
  ADD CONSTRAINT `fk_paciente_cpf_consulta` FOREIGN KEY (`paciente_cpf`) REFERENCES `paciente` (`cpf`);

--
-- Constraints for table `registra_consulta`
--
ALTER TABLE `registra_consulta`
  ADD CONSTRAINT `fk_atendete_cpf_registra` FOREIGN KEY (`atendente_cpf`) REFERENCES `atendentes` (`cpf`),
  ADD CONSTRAINT `fk_consulta_codigo_registra` FOREIGN KEY (`consulta_codigo`) REFERENCES `consulta` (`codigo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
