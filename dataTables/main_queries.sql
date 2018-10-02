INSERT INTO queries (id, name, sql, created_at, updated_at, description) VALUES (1, 'BuscarAluno', 'SELECT * FROM students
WHERE students.name LIKE :nome', '2018-02-20 23:54:47.042650', '2018-02-21 00:37:52.574731', null);
INSERT INTO queries (id, name, sql, created_at, updated_at, description) VALUES (2, 'BuscarAlunoMatricula', 'SELECT name, cpf, enrollment_number
FROM (	SELECT * 
		FROM students s inner join enrollments e 
		on s.id = e.student_id
	 	WHERE s.name LIKE :nome_aluno)
', '2018-04-24 02:46:17.718239', '2018-07-24 03:35:41.155565', 'Busca os Alunos e suas respectivas matriculas');
INSERT INTO queries (id, name, sql, created_at, updated_at, description) VALUES (4, 'Etapas vencidas', 'SELECT 
	students.email AS email,
	students.name AS name, 
	professors.name AS prof_name,
	professors.email AS prof_email,
	phases.name AS phase_name,
	due_date AS due_date
FROM 
	phase_completions 
		INNER JOIN 
	enrollments ON enrollments.id = phase_completions.enrollment_id 
		INNER JOIN 
	students ON students.id = enrollments.student_id
		INNER JOIN 
	advisements ON advisements.enrollment_id = enrollments.id
		INNER JOIN 
	professors ON professors.id = advisements.professor_id
		INNER JOIN phases ON phases.id = phase_completions.phase_id 
WHERE 
	due_date<=:data_consulta AND 
	enrollments.id NOT IN (SELECT dismissals.enrollment_id from dismissals) AND 
	enrollments.enrollment_status_id = 2 AND 
	completion_date IS NULL /* Se for EQ, enviar lembrete, e depois esperar o prazo de defesa para enviar novamente */AND 
	(phases.id <> 2 OR ((julianday(:data_consulta) - julianday(due_date) < 0) OR julianday(:data_consulta) - julianday(due_date) > 50))/* Se fase for artigo A1 só vale para alunos que entraram de 2011.1 a 2014.1 */AND 
	(phases.id <> 5 OR (enrollments.admission_date >= ''2011-03-01'' and admission_date <= ''2014-03-01''))/* Se for artigo para mestrado, só vale para alunos que entraram em 2014.1 */AND 
	(phases.id <> 6 OR enrollments.admission_date >= ''2014-03-01'' AND enrollments.admission_date < ''2014-08-01'')/* Se for aceitação de artigo B2 ou superior, só vale para alunos que entraram a partir de 2014.2 */AND 
	(phases.id <> 10 OR enrollments.admission_date >= ''2014-08-01'')/* Se for submissão de artigo B1 para doutorado, só vale para alunos que entraram a partir de 2014.2 */AND 
	(phases.id <> 9 OR enrollments.admission_date >= ''2014-08-01'')/* Se for submissão de artigo B4 para EQ, só vale para alunos que entraram a partir de 2014.2 */AND 
	(phases.id <> 8 OR enrollments.admission_date >= ''2014-08-01'')/* Se for submissão de artigo B4 para mestrado, só vale para alunos que entraram a partir de 2014.2 */AND 
	(phases.id <> 7 OR enrollments.admission_date >= ''2014-08-01'')', '2018-09-15 20:45:00.843913', '2018-09-15 20:53:40.616787', null);
INSERT INTO queries (id, name, sql, created_at, updated_at, description) VALUES (5, 'Alunos REGULARES ativos', 'SELECT s.name as nome, s.email as email, e.enrollment_number as matricula
FROM enrollments e, students s
WHERE	e.id NOT IN (
  			SELECT enrollment_id
  			FROM dismissals)AND 
		(enrollment_status_id = 3)AND 
		s.id = e.student_id AND 
		:data_consulta > 1
ORDER BY s.name', '2018-09-15 20:57:45.421825', '2018-09-27 17:50:19.018403', 'Lista de alunos ativos (excluindo alunos avulsos)');