#drop database company_bd_lab5;
create database company_bd_lab5;
use company_bd_lab5; 

create table Wage_system 
(
 wage_system_id int not null primary key auto_increment,
 name varchar (100) not null
); 

create table Working_time 
(
 working_time_id int not null primary key auto_increment,
 rate_over_time float not null default 1
); 

create table Rate_over_turnover 
(
 rate_over_turnover_id int not null primary key auto_increment,
 rate_over_turnover float not null default 1
); 

create table Forms_of_remuneration 
(
 forms_of_remuneration_id int not null primary key auto_increment,
 name varchar (100) not null
); 

create table Compensation_payments 
(
compensation_payments_id int not null primary key auto_increment,
name varchar (100) not null,
amound int not null default 20000
);

create table Fines 
(
 fines_id int not null primary key auto_increment,
 reason varchar (100) not null,
 type  varchar (100) not null,
 amound int not null
); 

create table Incentive_payments 
(
 incentive_payments_id int not null primary key auto_increment,
name varchar (100) not null,
 type  varchar (100) not null,
 amound float not null
); 

create table Positions 
(
positions_id int not null primary key auto_increment,
name varchar (100) not null,
salary int not null,
working_days int not null
); 

create table Turnover 
(
turnover_id int not null primary key auto_increment,
start_date date not null,
over_date date not null,
summ int
); 

create table Subdivision 
(
subdivision_id int not null primary key auto_increment,
name varchar (100) not null,
sales_plan int,
turnover_id int not null,
rate_over_turnover_id int not null default 1,
constraint  fk_turnover_turnover_id_1  foreign key (turnover_id) references turnover (turnover_id),
constraint  fk_rate_over_turnover_rate_over_turnover_id_1  foreign key (rate_over_turnover_id) references rate_over_turnover (rate_over_turnover_id)
); 

create table Employee 
(
Employee_id int not null primary key auto_increment,
full_name varchar(150) not null,
birth_date date not null,
subdivision_id int not null,
constraint  fk_subdivision_subdivision_id_1  foreign key (subdivision_id) references Subdivision (subdivision_id)
); 

create table Employee_to_positions
(
positions_id int not null,
employee_id int not null,
primary key (positions_id, employee_id),
 foreign key (employee_id) references Employee (employee_id),
 foreign key (positions_id) references Positions (positions_id)
);

create table Pay
(
pay_id int not null primary key auto_increment,
employee_id int not null,
working_time_id int not null,
compensation_payments_id int default null,
forms_of_remuneration_id int not null,
wage_system_id int not null,
income_tax float not null default 0.13,
appointment_date date not null,
payment_date date not null,
foreign key (forms_of_remuneration_id) references forms_of_remuneration (forms_of_remuneration_id),
foreign key (employee_id) references Employee (employee_id),
foreign key (working_time_id) references working_time (working_time_id),
foreign key (compensation_payments_id) references compensation_payments (compensation_payments_id),
foreign key (wage_system_id) references wage_system (wage_system_id)
);

create table Fines_to_pay
(
pay_id int not null,
fines_id int not null,
numbers int,
primary key (pay_id, fines_id),
foreign key (pay_id) references Pay (pay_id),
foreign key (fines_id) references Fines (fines_id)
);

create table Incentive_payments_to_pay
(
pay_id int not null,
Incentive_payments_id int not null,
primary key (Incentive_payments_id, pay_id),
 foreign key (pay_id) references pay (pay_id),
 foreign key (Incentive_payments_id) references Incentive_payments (Incentive_payments_id)
);

insert into Wage_system (name) values 
('Повременная'),
('Cдельная'),
('Смешанная');
 
insert into Working_time (rate_over_time) values 
(0.9),
(1.0),
(1.1);

insert into Rate_over_turnover (Rate_over_turnover) values 
(0.9),
(1.0),
(1.1);

insert into Forms_of_remuneration (name) values 
('Рубли'),
('Иностранная валюта'),
('Акции компании');


insert into Fines (reason, type, amound) values 
('За опоздание', 'Процент', 0.3),
('За неявку', 'Процент', 0.3),
('За превышение должностных полномочий', 'Сумма', 500),
('За неуважительное отношение к коллегам/начальству', 'Сумма', 500),
('За отказ от выполнения прямых обязанностей', 'Сумма', 1000),
('За систематическое опоздание на работу', 'Сумма', 1500),
('За самовольное покидание рабочего места (без предупреждения начальства)', 'Сумма', 500),
('За распитие алкогольных напитков', 'Сумма', 1000),
('За употребление наркотиков', 'Процент', 1.0),
('За нахождение на рабочем месте в нетрезвом состоянии', 'Сумма', 5000);

insert into Incentive_payments (name, type, amound) values 
('Премия', 'Процент', 10),
('Поощрение', 'Сумма', 3000); 


insert into compensation_payments (name) values 
('Отпускные'),
('Декретные'),
('Больничный');

insert into Positions (name, salary, working_days) values 
('Продавец-консультант', 20000, 20),
('Инкассатор', 15000, 3),
('Директор', 100000, 20),
('Адвокат', 25000, 20),
('Программист', 25000, 20),
('Менеджер', 18000, 20),
('Владелец', 100000, 20),
('Юрист', 20000, 15),
('Преподаватель', 35000, 15),
('Логист', 20000, 15);

insert into Turnover (start_date, over_date, summ) values 
('2021-01-01', '2021-01-31', 200000),
('2018-05-01', '2018-05-31', 900000),
('2019-05-01', '2019-05-31', 900000),
('2019-07-01', '2019-07-31', 0),
('2000-01-01', '2000-01-31', 25000),
('2007-01-01', '2007-01-31', 1000000),
('2021-02-01', '2021-02-21', 210000),
('2006-04-01', '2006-04-30', 180000),
('2005-01-21', '2005-01-31', 750000),
('2021-01-21', '2021-01-31', 231000);

insert into Subdivision (name, sales_plan, turnover_id, rate_over_turnover_id) values 
('Офис', 200000, 1, 2),
('Бухгалтерия', 1000000, 2, 1),
('Главный офис', 1200000, 3, 1),
('Техподдержка', 0, 4, 2),
('Адвокатский кабинет', 0, 4, 2),
('Кафедра САПР', 0, 4, 3),
('Канцелярия', 500000, 2, 2),
('Секретариат', 400000, 3, 3),
('Служба делопроизводства', 100000, 1, 2),
('Отдел охраны труда', 0, 4, 2);


insert into Employee (full_name, birth_date, subdivision_id) values 
('Новиков Семен Мэлорович', '2000-04-07', 1),
('Осипов Григорий Николаевич', '2007-09-28', 2),
('Миронов Пантелей Валерьевич', '1999-04-03', 3),
('Комиссаров Яков Ефимович', '2001-05-26', 4),
('Данилов Авраам Матвеевич', '2002-04-09', 5),
('Соколов Александр Александрович', '1999-06-06', 6),
('Колобков Дмитрий Олегович', '2001-01-21', 2),
('Крылов Павел Александрович', '2005-01-21', 3),
('Левченко Данила Романович', '2002-01-21', 1),
('Макаров Ярослав Александрович', '2004-01-21', 4);

insert into Employee_to_positions (employee_id, positions_id) values 
(1, 1),
(1, 6),
(2, 2),
(3, 3),
(3, 7),
(4, 4),
(4, 8),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10); 


insert into Pay (employee_id, working_time_id, forms_of_remuneration_id, wage_system_id, appointment_date, payment_date) values 
(1, 3, 1, 1, '2021-01-01', '2021-01-02'),
(2, 2, 1, 2, '2018-05-15', '2018-05-16'),
(3, 2, 3, 3, '2019-05-23', '2019-05-24'),
(4, 2, 1, 1, '2019-07-27', '2019-07-28'),
(5, 2, 1, 2, '2017-03-29', '2017-03-30'),
(6, 3, 1, 1, '2017-03-30', '2017-03-31'),
(7, 3, 2, 2, '2021-01-01', '2021-01-02'),
(8, 3, 3, 1, '2021-01-01', '2021-01-02'),
(9, 3, 1, 3, '2021-01-01', '2021-01-02'),
(10, 3, 2, 1, '2021-01-01', '2021-01-02');


insert into Fines_to_pay (pay_id, fines_id, numbers) values 
(2, 2, 2);


insert into Incentive_payments_to_pay (pay_id, incentive_payments_id) values 
(1, 1),
(5, 2),
(6, 1),
(7, 2),
(8, 1),
(9, 1),
(10, 1);

UPDATE `company_bd_lab5`.`pay` SET `compensation_payments_id` = '3' WHERE (`pay_id` = '3');

################## 4lab #####################

UPDATE Employee
SET birth_date = '2002-07-07'
WHERE Employee_id = 10;

select * from Employee;

alter table Positions 
add check (salary >= 13890);

insert into Fines_to_pay (pay_id, fines_id, numbers) values
(1, 1, 1),
(3, 1, 3),
(4, 1, 5),
(5, 7, 1);

select * from fines_to_pay;

select fines_id, sum(numbers), count(*) from fines_to_pay group by fines_id;

select pay_id, Employee_id from pay;

UPDATE fines SET amound = '0.1' WHERE (fines_id = '1');
UPDATE fines SET amound = '0.1' WHERE (fines_id = '2');

UPDATE compensation_payments SET amound = 20000 WHERE (compensation_payments_id = '1');
UPDATE compensation_payments SET amound = 20000 WHERE (compensation_payments_id = '2');
UPDATE compensation_payments SET amound = 20000 WHERE (compensation_payments_id = '3');

ALTER TABLE fines 
CHANGE COLUMN amound 
amound FLOAT NOT NULL;

DELETE FROM turnover WHERE turnover_id = 8;
DELETE FROM turnover WHERE turnover_id = 9;
DELETE FROM turnover WHERE turnover_id = 10;

insert into Fines (reason, type, amound) values
('За просто так', 'Сумма', 500),
('За просто так', 'Сумма', 500),
('За просто так', 'Сумма', 500);

DELETE FROM Fines WHERE Fines_id = 11;
DELETE FROM Fines WHERE Fines_id = 12;
DELETE FROM Fines WHERE Fines_id = 13;

CREATE TABLE new_compensation_payments LIKE compensation_payments;


CREATE TABLE new_fines(
new_fines_id int not null primary key auto_increment,
amound float
);

INSERT INTO new_fines (amound)
    SELECT amound
    FROM fines WHERE amound >= 1000;
select * from new_fines;

SELECT 
subdivision.subdivision_id,
subdivision.name as 'Название',
subdivision.sales_plan,
rate_over_turnover.rate_over_turnover,
ROUND(subdivision.sales_plan * rate_over_turnover.rate_over_turnover) as 'Итог'
from
subdivision

join rate_over_turnover
on subdivision.rate_over_turnover_id = rate_over_turnover.rate_over_turnover_id

order by ROUND(subdivision.sales_plan * rate_over_turnover.rate_over_turnover);

SELECT
  employee.employee_id,
  employee.full_name,
  subdivision.name AS 'Отдел' 
FROM
  employee
  JOIN subdivision
    ON employee.subdivision_id = subdivision.subdivision_id;
    
SELECT *
FROM
  employee
  JOIN subdivision
    ON 1=1;
    
    
alter table employee
modify column subdivision_id int default NULL;

    insert into employee (full_name, birth_date) values
    ('Зубенко Михаил Петрович', '1000-01-01');
    
SELECT
  employee.employee_id,
  employee.full_name,
  subdivision.name AS 'Отдел'
FROM
  employee
  LEFT JOIN subdivision #добавляем только left
    ON employee.subdivision_id = subdivision.subdivision_id;
    
insert into Subdivision (name, sales_plan, turnover_id, rate_over_turnover_id) values 
('Совет директоров', 100000000, 4, 3);
    
SELECT
  employee.employee_id,
  employee.full_name,
  subdivision.name AS 'Отдел'
FROM
  employee
  RIGHT JOIN subdivision
    ON employee.subdivision_id = subdivision.subdivision_id;


SELECT * FROM employee NATURAL JOIN subdivision;

SELECT * FROM subdivision LEFT JOIN (rate_over_turnover CROSS JOIN turnover)
                 ON (subdivision.turnover_id = turnover.turnover_id AND subdivision.rate_over_turnover_id = rate_over_turnover.rate_over_turnover_id);
		
SELECT 
incentive_payments_to_pay.pay_id, 
incentive_payments.name,
incentive_payments.type,
incentive_payments.amound,
pay.employee_id
FROM
  incentive_payments_to_pay
  JOIN incentive_payments
    ON incentive_payments_to_pay.incentive_payments_id = incentive_payments.incentive_payments_id
    
    JOIN pay
    ON incentive_payments_to_pay.pay_id = pay.employee_id;
    
    SELECT * FROM employee JOIN subdivision USING (subdivision_id);
    
SELECT
  pay.compensation_payments_id,
  compensation_payments.name as 'Причина',
  compensation_payments.amound
FROM
  pay
   JOIN compensation_payments
    ON pay.compensation_payments_id = compensation_payments.compensation_payments_id; 

SELECT
  pay.employee_id,
  employee.full_name,
  pay.forms_of_remuneration_id,
  forms_of_remuneration.name as 'Форма оплаты'
FROM
  pay
   JOIN forms_of_remuneration
    ON pay.forms_of_remuneration_id = forms_of_remuneration.forms_of_remuneration_id
    
    join employee
    ON pay.employee_id=employee.employee_id; 
    
    
    SELECT 
    subdivision.subdivision_id,
    subdivision.name,
    count(Employee.subdivision_id) as 'Сотрудников в подразделениях'
	FROM 
    Employee
    
	right JOIN subdivision 
	ON Employee.subdivision_id = subdivision.subdivision_id
    group by subdivision.subdivision_id;
    
    SELECT 
    sum(positions.salary) as 'Весь оборот'
    from
    positions;
    
	SELECT 
    max(positions.salary) as 'Максимальная заработная плата'
    from
    positions;
    
    SELECT full_name, subdivision_id FROM employee
     UNION all
     SELECT  name, sales_plan FROM subdivision;
     
	select subdivision_id, name from subdivision
    group by turnover_id;
    
    
    SELECT 
    subdivision.subdivision_id,
    subdivision.name AS 'Название подразделения',
    turnover.summ as 'Оборот в месяц'
    FROM 
    subdivision
    
    JOIN turnover
    ON subdivision.turnover_id = turnover.turnover_id
    
   where (turnover.over_date > '2010-01-01')
   order by turnover.summ;
   
   SELECT
   subdivision.subdivision_id,
   subdivision.name as 'Название подразделения',
   subdivision.sales_plan as 'План продаж'
   from
   subdivision
   where subdivision.sales_plan = 0 order by name desc limit 3;
   
   SELECT
   subdivision.name as 'Название подразделения',
   subdivision.sales_plan as 'План продаж',
   rate_over_turnover.rate_over_turnover as 'Рейтинг за оборот'
   from
   subdivision
   
   join rate_over_turnover
   on subdivision.rate_over_turnover_id = rate_over_turnover.rate_over_turnover_id
   
   where subdivision.rate_over_turnover_id >= 2 order by subdivision.sales_plan desc limit 5;
   
   SELECT
   subdivision.name as 'Название подразделения',
   subdivision.sales_plan as 'План продаж',
   turnover.summ as 'Оборот',
   rate_over_turnover.rate_over_turnover as 'Рейтинг за оборот'
   
   from
   subdivision
   
   join rate_over_turnover
   on subdivision.rate_over_turnover_id = rate_over_turnover.rate_over_turnover_id
   
   join turnover
   on subdivision.turnover_id = turnover.turnover_id
   
   where subdivision.rate_over_turnover_id >= 2 order by subdivision.rate_over_turnover_id desc limit 5;
   
   CREATE FUNCTION `get_age` 
   (
   `date_of_birth` DATE,
   `current_time` DATETIME
	)
 RETURNS INT(11) UNSIGNED COMMENT 'Calculates the age from the date of birth' DETERMINISTIC NO SQL SQL SECURITY DEFINER
 RETURN ((YEAR(current_time) - YEAR(date_of_birth)) - ((DATE_FORMAT(current_time, '00-%m-%d') < DATE_FORMAT(date_of_birth, '00-%m-%d'))));
 
SELECT 
full_name as 'Имя',
get_age(birth_date, NOW()) AS 'Возраст'

FROM employee
where (get_age(birth_date, NOW())) > 20
order by get_age(birth_date, NOW()) desc;

SELECT 
avg(get_age(birth_date, NOW())) AS 'Средний возраст'
FROM employee;

select
subdivision_id,
sales_plan as 'План продаж',
name as 'Название подразделения'
from
subdivision
group by sales_plan
having subdivision.sales_plan > 0;

select sales_plan from subdivision
union all
select summ from turnover
order by sales_plan;

SELECT summ
FROM turnover
WHERE summ = ANY
(SELECT sales_plan FROM subdivision WHERE sales_plan>0);

SELECT sales_plan
FROM subdivision
WHERE sales_plan > ALL
(SELECT summ FROM turnover where summ > 0);

SELECT subdivision_id, name
FROM subdivision
WHERE subdivision_id = ANY (SELECT subdivision_id FROM employee);

SELECT subdivision_id, name
FROM subdivision
WHERE subdivision_id = ANY (SELECT subdivision_id FROM employee where (get_age(birth_date, NOW())) > 20 );

SELECT subdivision_id, name
FROM subdivision
WHERE subdivision_id = ANY (SELECT subdivision_id FROM employee where (get_age(birth_date, NOW())) < 20 );

SELECT positions_id as 'Должности', GROUP_CONCAT(employee_id) as 'Сотрудники'
FROM employee_to_positions
group by positions_id;

SELECT pay_id, (SELECT avg(numbers) from fines_to_pay) as 'Среднее кол-во штрафов на одну выплату'
from fines_to_pay;

select pay_id, avg(avg_number) as 'Среднее кол-во штрафов на одну выплату' from
(
SELECT pay_id, (SELECT avg(numbers) from fines_to_pay) as avg_number
from fines_to_pay
) sub
group by pay_id;

with cte_numbers as (
SELECT pay_id, (SELECT avg(numbers) from fines_to_pay) as avg_number
from fines_to_pay
)

select pay_id, avg(avg_number) as 'Среднее кол-во штрафов на одну выплату' 
from
cte_numbers
group by pay_id;

with
cte1 as (select summ from turnover),
cte2 as (select sales_plan from subdivision)
select summ, sales_plan from cte1 join cte2
where cte1.summ = cte2.sales_plan;


	
SELECT LENGTH(employee.full_name) as 'Длина строки'
from employee
group by employee_id;

SELECT LOCATE('ов', employee.full_name) as 'Позиция первого вхождения подстроки -ов в строку'
from employee
group by employee_id; 

SELECT 
REPLACE(
(select employee.full_name from employee where (employee.employee_id = 11)), 
(select employee.full_name from employee where (employee.employee_id = 11)),
'Мафиозник') as 'Вор в законе';

select extract(MONTH FROM NOW()) as 'Текущий месяц';

select 
DATE_FORMAT(NOW(), '%d %M %Y') as 'Сегодня',
replace(
(DATE_FORMAT(NOW(), '%d %M %Y')),
'May',
'С Днем Победы!'
) as 'Текущая дата';

#Вернуть работников, у которых зарплату не задержали
SELECT 
pay.pay_id,  
employee.full_name 
FROM pay

join employee
on pay.employee_id = employee.employee_id

WHERE DATEDIFF(payment_date, appointment_date) < 30;


select
pay.pay_id,
wage_system.name
from pay

join wage_system
on pay.wage_system_id = wage_system.wage_system_id

order by pay.pay_id;



select 
pay.pay_id,
employee.full_name,
pay.compensation_payments_id,
compensation_payments.name,
compensation_payments.amound
from pay

join employee
on pay.employee_id = employee.employee_id

join compensation_payments
on pay.compensation_payments_id = compensation_payments.compensation_payments_id;

select
pay.pay_id,
employee.full_name as 'Полное имя',
subdivision.name as 'Подразделение', 
working_time.rate_over_time as 'Коэффициент за рабочие часы',
compensation_payments.amound as 'Доп. выплаты'
from pay
join employee
on pay.employee_id = employee.employee_id
join working_time
on pay.working_time_id = working_time.working_time_id
join compensation_payments
on pay.compensation_payments_id = compensation_payments.compensation_payments_id
join subdivision
on employee.employee_id = subdivision.subdivision_id
where pay.pay_id = 3;


SELECT 
GROUP_CONCAT(positions.name) as 'Должности', 
employee.full_name as 'Сотрудники'
FROM employee_to_positions
join positions
on employee_to_positions.positions_id = positions.positions_id
join employee
on employee_to_positions.employee_id = employee.employee_id
where employee.employee_id = 3;

select
pay.pay_id,
e.full_name as 'Имя сотрудника',
p.name as 'Должность',
p.salary as 'Оклад',
int_p.type as 'Тип поощрения',
int_p.amound as 'Размер поощрения',
f.type as 'Тип штрафа',
f.amound as 'Размер штрафа',
f_to_p.numbers as 'Количество штрафов'
from pay

join employee as e
on pay.employee_id = e.employee_id

join employee_to_positions as e_to_p
on e.employee_id = e_to_p.employee_id

join positions as p
on p.positions_id = e_to_p.positions_id

join Incentive_payments_to_pay as int_to_p
on pay.pay_id = int_to_p.pay_id

join incentive_payments as int_p
on int_to_p.incentive_payments_id = int_p.incentive_payments_id

left join fines_to_pay as f_to_p
on pay.pay_id = f_to_p.pay_id

left join fines as f
on f_to_p.fines_id = f.fines_id

where e.employee_id = 1;












############Все выплаты и итог
select
pay.pay_id,
e.full_name as 'Имя сотрудника',
p.name as 'Должность',
p.salary as 'Оклад',
int_p.type as 'Тип поощрения',
int_p.amound as 'Размер поощрения',
f.type as 'Тип штрафа',
f.amound as 'Размер штрафа',
f_to_p.numbers as 'Количество штрафов',
c_p.name as 'Название компенсационной выплаты',
c_p.amound as 'Размер компенсационной выплаты',
w_t.rate_over_time as 'Коэффициент за время',
rate_over_turnover.rate_over_turnover as 'Коэффициент за оборот',
p.salary + #Оклад
IFNULL(c_p.amound, 0) + #Компенсационные
if(int_p.type like 'Сумма', 3000, 0) - #Поощрения
if(f.type like 'Сумма', 3000, 0) + #Штраф
(
p.salary * if(int_p.type is null, 1, if(int_p.type like 'Процент', 0.1, 1)) * #Оклад * поощрение в процентах * 
if(f.type is null, 1, if(f.type like 'Процент', f_to_p.numbers * 0.1, 1)) * #штраф в процентах на кол-во штрафов
IF(w_t.rate_over_time IS NULL, 1, w_t.rate_over_time) * #Рейтинг за время
IF(rate_over_turnover.rate_over_turnover IS NULL, 1, rate_over_turnover.rate_over_turnover) #Рейтинг за оклад
)
as 'Итог'
from pay
left join employee as e
on pay.employee_id = e.employee_id
left join employee_to_positions as e_to_p
on e.employee_id = e_to_p.employee_id
left join positions as p
on p.positions_id = e_to_p.positions_id
left join Incentive_payments_to_pay as int_to_p
on pay.pay_id = int_to_p.pay_id
left join incentive_payments as int_p
on int_to_p.incentive_payments_id = int_p.incentive_payments_id
left join subdivision as sub
on e.subdivision_id = sub.subdivision_id
left join rate_over_turnover
on sub.rate_over_turnover_id = rate_over_turnover.rate_over_turnover_id
left join fines_to_pay as f_to_p
on pay.pay_id = f_to_p.pay_id
left join fines as f
on f_to_p.fines_id = f.fines_id
left join Compensation_payments as c_p
on pay.compensation_payments_id = c_p.compensation_payments_id
left join working_time as w_t
on pay.working_time_id = w_t.working_time_id;


#############Вывести имя, к. за часы, тип оплаты и систему оплаты для каждого сотрудника
select
pay.pay_id,
employee.full_name as 'Полное имя',
working_time.rate_over_time as 'Коэффициент за рабочие часы',
forms_of_remuneration.name as 'Тип оплаты',
wage_system.name as 'Система оплаты'
from pay
join employee
on pay.employee_id = employee.employee_id
join working_time
on pay.working_time_id = working_time.working_time_id
join forms_of_remuneration
on pay.forms_of_remuneration_id = forms_of_remuneration.forms_of_remuneration_id
join wage_system
on pay.wage_system_id = wage_system.wage_system_id
order by pay.pay_id;

############Вывести все должности и всех работников с этими должностями
SELECT 
positions.name as 'Должности', 
GROUP_CONCAT(employee.full_name) as 'Сотрудники'
FROM employee_to_positions
join positions
on employee_to_positions.positions_id = positions.positions_id
join employee
on employee_to_positions.employee_id = employee.employee_id
group by positions.positions_id;

############Вывести оклад для каждого сотрудника
SELECT
 positions.positions_id,
 employee.full_name 'Сотрудник',
  positions.name as 'Должность',
 positions.salary 'Оклад'
FROM
  employee_to_positions
   JOIN positions
    ON  employee_to_positions.positions_id = positions.positions_id
   JOIN employee
    ON  employee_to_positions.employee_id = employee.employee_id
    order by positions.positions_id;

#Должности по кол-ву сотрудников
select
COUNT(employee_to_positions.employee_id) AS c,  
positions.name as 'Должности'
from
employee_to_positions
join positions
on employee_to_positions.positions_id = positions.positions_id
GROUP BY employee_to_positions.positions_id 
order by c desc;
    
    
############Вывести работника и систему оплаты труда
SELECT
  pay.employee_id,
  wage_system.name as 'Система оплаты труда',
  employee.full_name as 'Сотрудник'
FROM
  pay
   JOIN wage_system
    ON pay.wage_system_id = wage_system.wage_system_id
    join employee
    ON pay.employee_id=employee.employee_id
    order by employee.employee_id; 

############Вывести план, реальную выручку и коэффициент
SELECT 
subdivision.subdivision_id, 
subdivision.name as 'Подразделение компании', 
subdivision.sales_plan as 'План',
turnover.summ as 'Выручка',
rate_over_turnover.rate_over_turnover as 'Коэффициент за выручку'
FROM
  subdivision
  JOIN turnover
    ON subdivision.turnover_id = turnover.turnover_id
JOIN rate_over_turnover
	ON subdivision.rate_over_turnover_id = rate_over_turnover.rate_over_turnover_id;
    


################ lab 5 ####################
show variables like 'secure_file_priv';

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\turnover.csv'
into table turnover
fields terminated by ','
-- lines terminated by '/n'
ignore 1 lines
(start_date, over_date, summ);

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\subdivision.csv'
into table subdivision
fields terminated by ','
-- lines terminated by '/n'
ignore 1 lines
(name, sales_plan, turnover_id, rate_over_turnover_id);

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\employee.csv'
into table employee
fields terminated by ','
-- lines terminated by '/n'
ignore 1 lines
(full_name, birth_date, subdivision_id);

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\pay.csv'
into table pay
fields terminated by ','
-- lines terminated by '\n'
ignore 1 lines
(employee_id, working_time_id, forms_of_remuneration_id, wage_system_id, appointment_date, payment_date, compensation_payments_id);

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\positions.csv'
into table positions
fields terminated by ','
ignore 1 lines
(name, salary, working_days);

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\employee_to_positions.csv'
into table employee_to_positions
fields terminated by ','
ignore 1 lines
(positions_id, employee_id);


 CREATE FUNCTION `get_age` 
   (
   `date_of_birth` DATE,
   `current_time` DATETIME
	)
 RETURNS INT(11) UNSIGNED COMMENT 'Calculates the age from the date of birth' DETERMINISTIC NO SQL SQL SECURITY DEFINER
 RETURN ((YEAR(current_time) - YEAR(date_of_birth)) - ((DATE_FORMAT(current_time, '00-%m-%d') < DATE_FORMAT(date_of_birth, '00-%m-%d'))));
 
 
