/*Para cada projeto localizado em ‘Picos - PI’, liste o código do projeto, o código do departamento que controla o projeto e o nome, endereço e salário do gerente deste departamento.*/

SELECT p.id, d.nome, d.id, e.nome, e.endereco, e.salario
FROM  (projeto p JOIN departamento d ON p.departamento_id = d.id JOIN
      empregado e ON e.id = d.gerente_id)
      WHERE p.localizacao = "Picos - PI"