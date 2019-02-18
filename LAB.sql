-- a.	Вывести список названий департаментов и количество главных врачей в каждом из этих департаментов
SELECT
	Department.name,
	count( DISTINCT chief_doc_id) as chief_doc_count
FROM
	Department
  	INNER JOIN Employee
  	ON Department.id = Employee.department_id
  	GROUP BY Department.id;

-- b.	Вывести список департаментов, в которых работают 3 и более сотрудников (id и название департамента, количество сотрудников)
SELECT
	Department.id,
	Department.name,
    COUNT(Employee.id) as employees_amount
FROM
	Department
    INNER JOIN Employee
    ON Department.id = Employee.department_id
    GROUP BY Department.name, Department.id
    HAVING COUNT (Employee.id) >= 3;

-- c.	Вывести список департаментов с максимальным количеством публикаций  (id и название департамента, количество публикаций)
WITH dep_public as (
	SELECT
  		Department_id,
  		Department.name,
  		SUM(num_public) over (partition by department_id) as sum_public_per_dep
  	FROM
  		Employee
  		INNER JOIN Department
  		ON Employee.department_id = Department.id
  		ORDER BY num_public DESC)
SELECT * from dep_public WHERE sum_public_per_dep in (SELECT sum_public_per_dep from dep_public limit 1);

-- d.	Вывести список сотрудников с минимальным количеством публикаций в своем департаменте (id и название департамента, имя сотрудника, количество публикаций)

-- С этом заданием затык. Понимаю, как найти минимальное количество публикации сотрудником на каждый департамент.
-- Например это можно сделать так:
SELECT DISTINCT
		Employee.department_id,
    	MIN(Employee.num_public) over (partition by Employee.department_id) as min_public_per_dep
FROM
		Employee
    	ORDER BY min_public_per_dep;

-- Или вот так. Что более правильно, так как мы сразу получаем все нужные поля.
-- Но как все это привести к виду уникальности по департаменту и при этом вывести только минимум у меня не получилось:
WITH min_dep_public as (
	SELECT
		Employee.department_id,
    	Department.name as department_name,
    	Employee.name as employee_name,
    	MIN(Employee.num_public) as min_public_per_dep
	FROM
		Employee
    	INNER JOIN Department
    	ON Employee.department_id = Department.id
    	GROUP BY Employee.department_id, Department.name, Employee.name
    	ORDER BY min_public_per_dep, Employee.department_id)
SELECT * from min_dep_public;


-- e.	Вывести список департаментов и среднее количество публикаций для тех департаментов, в которых работает более одного главного врача (id и название департамента, среднее количество публикаций)
SELECT
	Employee.department_id,
    Department.name,
    AVG(num_public) as avg_public
FROM
	Employee
    INNER JOIN Department
    ON Department.id = Employee.department_id
    GROUP BY Employee.department_id, Department.name
    HAVING count( DISTINCT chief_doc_id) > 1;



