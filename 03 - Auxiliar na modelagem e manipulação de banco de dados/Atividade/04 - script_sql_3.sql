-- Inserindo mais dados
INSERT INTO consultas (data, medico_id, paciente_id, especmedico_id, valor) VALUES
('2020-03-01', 11, 3, 4, 220),
('2020-04-22', 8, 1, 1, 120),
('2020-06-18', 12, 4, 1, 210),
('2020-07-13', 11, 3, 4, 300),
('2020-08-15', 8, 1, 1, 115),
('2020-11-09', 12, 6, 1, 90);
INSERT INTO internacoes (data_entrada, data_prev_alta, data_alta, procedimento, paciente_id, medico_id, quarto_id) VALUES 
('2019-01-17', '2019-01-19', '2019-01-18', 'Recebeu soro e medicamento, durante o periodo', 5, 8, 5),
('2019-01-13', '2019-01-15', '2019-01-16', 'Recebeu soro e medicamento, durante o periodo', 2, 11, 6),
('2019-04-05', '2019-04-10', '2019-04-10', 'Recebeu soro e medicamento, durante o periodo', 6, 5, 6),
('2019-04-30', '2019-05-02', '2019-05-04', 'Recebeu soro e medicamento, durante o periodo', 4, 12, 4),
('2019-05-13', '2019-05-16', '2019-05-16', 'Recebeu soro e medicamento, durante o periodo', 3, 5, 8),
('2019-05-02', '2019-05-06', '2019-05-03', 'Recebeu soro e medicamento, durante o periodo', 1, 8, 9),
('2019-09-24', '2019-09-28', '2019-09-25', 'Recebeu soro e medicamento, durante o periodo', 5, 5, 8),
('2020-10-23', '2020-10-24', '2020-10-24', 'Recebeu soro e medicamento, durante o periodo', 3, 1, 7),
('2018-09-10', '2018-09-16', '2018-09-16', 'Recebeu soro e medicamento, durante o periodo', 4, 1, 9),
('2019-03-23', '2019-03-24', '2019-03-24', 'Recebeu soro e medicamento, durante o periodo', 6, 1, 1),
('2019-01-20', '2019-01-24', '2019-01-24', 'Recebeu soro e medicamento, durante o periodo', 2, 1, 4);
-- Corrigi o ano da data de entrada data da entidade internacoes do script_sql_1 enviado na Atividade 3 e atualiza algumas data de nascimento
UPDATE internacoes SET data_entrada='2018-08-10' WHERE id=9;
UPDATE pacientes SET data_nascimento='2015-04-24' WHERE id=1;
UPDATE pacientes SET data_nascimento='2018-07-12' WHERE id=3;

-- Todos os dados das consultas do ano de 2020 realizadas sem convênio
SELECT c.id, c.data, m.nome AS medico, e.nome AS especialidade, p.nome AS paciente, p.data_nascimento, p.cpf, p.email, p.telefone, p.carteira_convenio, c.valor 
FROM consultas c
JOIN pacientes p ON c.paciente_id = p.id 
JOIN medicos m ON c.medico_id=m.id 
JOIN especialidades e ON c.especmedico_id=e.id
WHERE year(c.data)=2020 and p.carteira_convenio is null;

-- O valor médio de todas consultas do ano de 2020 realizadas sem convênio
SELECT avg(c.valor)
FROM consultas c
JOIN pacientes p ON c.paciente_id = p.id 
JOIN medicos m ON c.medico_id=m.id 
JOIN especialidades e ON c.especmedico_id=e.id
WHERE year(c.data)=2020 and p.carteira_convenio is null;

-- Todos os dados das consultas do ano de 2020 realizadas com convênio
SELECT c.id, c.data, m.nome AS medico, e.nome AS especialidade, p.nome AS paciente, p.data_nascimento, p.cpf, p.email, p.telefone, p.carteira_convenio, c.valor 
FROM consultas c
JOIN pacientes p ON c.paciente_id = p.id 
JOIN medicos m ON c.medico_id=m.id 
JOIN especialidades e ON c.especmedico_id=e.id
WHERE year(c.data)=2020 and p.carteira_convenio is not null;

-- O valor médio de todas consultas do ano de 2020 realizadas com convênio
SELECT avg(c.valor)
FROM consultas c
JOIN pacientes p ON c.paciente_id = p.id 
JOIN medicos m ON c.medico_id=m.id 
JOIN especialidades e ON c.especmedico_id=e.id
WHERE year(c.data)=2020 and p.carteira_convenio is not null;

-- Todos os dados das internações que tiveram data de alta maior que a data prevista para a alta
SELECT i.data_entrada, i.data_prev_alta, i.data_alta, i.procedimento, 
p.nome AS paciente, p.data_nascimento, p.cpf, p.email, p.telefone, p.carteira_convenio,
m.nome AS medico,
q.numero AS quarto FROM internacoes i 
JOIN pacientes p ON i.paciente_id=p.id
JOIN medicos m ON i.medico_id=m.id
JOIN quartos q ON i.quarto_id=q.id
WHERE DATEDIFF(i.data_alta, i.data_prev_alta) > 0;

-- Receituário completo da primeira consulta registrada com receituário associado
SELECT *FROM consultas c JOIN receitas r on c.id=r.consulta_id where c.id=1;

-- Todos os dados da consulta de maior valor (as consultas não foram realizadas sob convênio)
SELECT c.id, c.data, m.nome AS medico, e.nome AS especialidade, p.nome AS paciente, p.data_nascimento, p.cpf, p.email, p.telefone, p.carteira_convenio, c.valor 
FROM consultas c
JOIN pacientes p ON c.paciente_id = p.id 
JOIN medicos m ON c.medico_id=m.id 
JOIN especialidades e ON c.especmedico_id=e.id
WHERE p.carteira_convenio is null AND c.valor IN
(SELECT MAX(c.valor) FROM consultas c JOIN pacientes p ON c.paciente_id=p.id WHERE p.carteira_convenio is null);

-- Todos os dados da consulta de menor valor (as consultas não foram realizadas sob convênio)
SELECT c.id, c.data, m.nome AS medico, e.nome AS especialidade, p.nome AS paciente, p.data_nascimento, p.cpf, p.email, p.telefone, p.carteira_convenio, c.valor 
FROM consultas c
JOIN pacientes p ON c.paciente_id = p.id 
JOIN medicos m ON c.medico_id=m.id 
JOIN especialidades e ON c.especmedico_id=e.id
WHERE p.carteira_convenio is null AND c.valor IN
(SELECT MIN(c.valor) FROM consultas c JOIN pacientes p ON c.paciente_id=p.id WHERE p.carteira_convenio is null);

-- Todos os dados das internações em seus respectivos quartos, 
-- calculando o total da internação a partir do valor de diária do quarto e o número de dias entre a entrada e a alta
SELECT i.data_entrada, i.data_prev_alta, i.data_alta, p.nome AS paciente, 
p.data_nascimento, p.telefone, m.nome as medico, m.crm, m.crm_uf, q.numero, tq.descricao, tq.valor_diaria, 
datediff(i.data_alta, i.data_entrada) as dias, (tq.valor_diaria * datediff(i.data_alta, i.data_entrada)) as total
FROM internacoes i 
JOIN pacientes p ON i.paciente_id=p.id 
JOIN medicos m ON i.medico_id=m.id 
JOIN quartos q ON i.quarto_id=q.id 
JOIN tipo_quartos tq ON q.tipoquarto_id=tq.id;

-- Data, procedimento e número de quarto de internações em quartos do tipo “apartamento”
SELECT i.data_entrada, i.data_prev_alta, i.data_alta, p.nome AS paciente, 
p.data_nascimento, p.telefone, m.nome as medico, m.crm, m.crm_uf, i.procedimento, q.numero, tq.descricao, tq.valor_diaria, 
datediff(i.data_alta, i.data_entrada) as dias, (tq.valor_diaria * datediff(i.data_alta, i.data_entrada)) as total
FROM internacoes i 
JOIN pacientes p ON i.paciente_id=p.id 
JOIN medicos m ON i.medico_id=m.id 
JOIN quartos q ON i.quarto_id=q.id 
JOIN tipo_quartos tq ON q.tipoquarto_id=tq.id
WHERE tq.descricao='Apartamento';

-- Nome do paciente, data da consulta e especialidade de todas as consultas em que os pacientes eram menores de 18 anos na data da consulta
-- e cuja especialidade não seja “pediatria”, ordenando por data de realização da consulta
SELECT c.id, c.data, m.nome AS medico, e.nome AS especialidade, p.nome AS paciente, p.data_nascimento, p.cpf, p.email, p.telefone, p.carteira_convenio, c.valor 
FROM consultas c
JOIN pacientes p ON c.paciente_id = p.id 
JOIN medicos m ON c.medico_id=m.id 
JOIN especialidades e ON c.especmedico_id=e.id
WHERE TIMESTAMPDIFF(YEAR, p.data_nascimento, current_date()) < 18 
AND e.nome<>'Pediatria' ORDER BY c.data ASC;

-- Nome do paciente, nome do médico, data da internação e procedimentos das internações realizadas por médicos da especialidade “gastroenterologia”, 
-- que tenham acontecido em “enfermaria”.
SELECT i.data_entrada, i.data_prev_alta, i.data_alta, p.nome AS paciente, 
p.data_nascimento, p.telefone, m.nome as medico, m.crm, m.crm_uf, e.nome as Especialidade, i.procedimento, q.numero, tq.descricao 
FROM internacoes i 
JOIN pacientes p ON i.paciente_id=p.id 
JOIN medicos m ON i.medico_id=m.id 
JOIN quartos q ON i.quarto_id=q.id 
JOIN tipo_quartos tq ON q.tipoquarto_id=tq.id
JOIN medicos_especialidades me ON me.medico_id=m.id
JOIN especialidades e ON me.especialidade_id=e.id
WHERE e.nome='Gastroenterologia' 
AND tq.descricao='Enfermaria';

-- Os nomes dos médicos, seus números de registro no CRM e a quantidade de consultas que cada um realizou
SELECT m.nome, m.crm, m.crm_uf, count(c.valor) AS quantidade_consultas from consultas c
JOIN medicos m ON c.medico_id=m.id GROUP BY c.medico_id ORDER BY m.nome;

-- Os nomes, os números de registro no CRE dos enfermeiros que participaram de mais de uma internação e os números de internações referentes a esses profissionais.
 SELECT e.nome AS enfermeiro, e.cre, count(enfermeiro_id) AS internacoes FROM internacoes_enfermeiros ie
 JOIN enfermeiros e ON ie.enfermeiro_id=e.id 
 GROUP BY enfermeiro_id;
 
-- Inclua ainda uma consulta extra idealizada por você:
-- Os nomes dos médicos, seus números de registro no CRM e a soma de consultas que cada um realizou
SELECT m.nome, m.crm, m.crm_uf, sum(c.valor) AS quantidade_consultas from consultas c
JOIN medicos m ON c.medico_id=m.id GROUP BY c.medico_id ORDER BY m.nome;