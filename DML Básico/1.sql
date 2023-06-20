/*Obtenha o nome e o endereço de todos os empregados do departamento de
'Rock'.*/

SELECT e.nome, e.endereco
FROM (empregado e JOIN departamento d ON e.departamento_id = d.id )
WHERE d.nome = "Rock";