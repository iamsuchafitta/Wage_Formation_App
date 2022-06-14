create database company_bd;
use company_bd; 

create table Wage_system 
(
 wage_system_id int not null primary key auto_increment,
 `name` varchar (100) not null
); 

create table Working_time 
(
 working_time_id int not null primary key auto_increment,
 `rate_over_time` float not null default 1
); 

create table Rate_over_turnover 
(
 rate_over_turnover_id int not null primary key auto_increment,
 rate_over_turnover float not null default 1
); 

create table Forms_of_remuneration 
(
 forms_of_remuneration_id int not null primary key auto_increment,
 `name` varchar (100) not null
); 

create table Compensation_payments 
(
 Compensation_payments_id int not null primary key auto_increment,
`name` varchar (100) not null,
 `amound` int not null
);

create table Fines 
(
 fines_id int not null primary key auto_increment,
 `reason` varchar (100) not null,
 `type`  varchar (100) not null,
 `amound` int not null
); 

create table Incentive_payments 
(
 incentive_payments_id int not null primary key auto_increment,
`name` varchar (100) not null,
 `type`  varchar (100) not null,
 `amound` float not null
); 

create table Positions 
(
positions_id int not null primary key auto_increment,
`name` varchar (100) not null,
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
`name` varchar (100) not null,
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
compensation_payments_id int not null,
forms_of_remuneration_id int not null,
wage_system_id int not null,
income_tax float not null,
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

insert into Wage_system (`name`) values 
('Повременная'),
('Cдельная'),
('Смешанная');
 
insert into Working_time (`rate_over_time`) values 
(0.9),
(1.0),
(1.1);

insert into Rate_over_turnover (`Rate_over_turnover`) values 
(0.9),
(1.0),
(1.1);

insert into Forms_of_remuneration (`name`) values 
('Рубли'),
('Иностранная валюта'),
('Акции компании');

insert into Fines (`reason`, `type`, `amound`) values 
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

insert into Incentive_payments (`name`, `type`, `amound`) values 
('Премия', 'Процент', 10),
('Поощрение', 'Сумма', 3000); 

alter table Compensation_payments
modify column  `amound` int not null default 15000;

insert into compensation_payments (`name`) values 
('Отпускные'),
('Декретные'),
('Больничный');

insert into Positions (`name`, salary, working_days) values 
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

insert into Subdivision (`name`, sales_plan, turnover_id, rate_over_turnover_id) values 
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

# create table Employee_to_positions
#(
#positions_id int not null,
#employee_id int not null,
#primary key (positions_id, employee_id),
# foreign key (employee_id) references Employee (employee_id),
# foreign key (positions_id) references Positions (positions_id)
#);

insert into Employee_to_positions (employee_id, positions_id) values 
(1, 1, 6),
(2, 2),
(3, 3, 7),
(4, 4, 8),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10); #??????????

alter table pay
modify column income_tax float not null default 0.13;

alter table pay
add column compensation_payments_id int;

insert into Pay (employee_id, working_time_id, compensation_payments_id, forms_of_remuneration_id, wage_system_id, appointment_date, payment_date) values 
(1, 3, 0, 1, 1, '2021-01-01', '2021-01-02'),
(2, 2, 3, 1, 2, '2018-05-15', '2018-05-16'),
(3, 2, 0, 3, 3, '2019-05-23', '2019-05-24'),
(4, 2, 0, 1, 1, '2019-07-27', '2019-07-28'),
(5, 2, 0, 1, 2, '2017-03-29', '2017-03-30'),
(6, 3, 0, 1, 1, '2017-03-30', '2017-03-31'),
(7, 3, 0, 2, 2, '2021-01-01', '2021-01-02'),
(8, 3, 0, 3, 1, '2021-01-01', '2021-01-02'),
(9, 3, 0, 1, 3, '2021-01-01', '2021-01-02'),
(10, 3, 0, 2, 1, '2021-01-01', '2021-01-02');

insert into Fines_to_pay (pay_id, fines_id, numbers) values 
(2, 2, 2);

create table Incentive_payments_to_pay
(
pay_id int not null,
Incentive_payments_id int not null,
primary key (Incentive_payments_id, pay_id),
 foreign key (pay_id) references pay (pay_id),
 foreign key (Incentive_payments_id) references Incentive_payments (Incentive_payments_id)
);

insert into Incentive_payments_to_pay (pay_id, incentive_payments_id) values 
(1, 1),
(5, 2),
(6, 1),
(7, 2),
(8, 1),
(9, 1),
(10, 1);

create database company_bd;
use company_bd;

create table Wage_system
(
 wage_system_id int not null primary key auto_increment,
 `name` varchar (100) not null
);

create table Working_time
(
 working_time_id int not null primary key auto_increment,
 `rate_over_time` float not null default 1
);

create table Rate_over_turnover
(
 rate_over_turnover_id int not null primary key auto_increment,
 rate_over_turnover float not null default 1
);

create table Forms_of_remuneration
(
 forms_of_remuneration_id int not null primary key auto_increment,
 `name` varchar (100) not null
);

create table Compensation_payments
(
 Compensation_payments_id int not null primary key auto_increment,
`name` varchar (100) not null,
 `amound` int not null
);

create table Fines
(
 fines_id int not null primary key auto_increment,
 `reason` varchar (100) not null,
 `type`  varchar (100) not null,
 `amound` int not null
);

create table Incentive_payments
(
 incentive_payments_id int not null primary key auto_increment,
`name` varchar (100) not null,
 `type`  varchar (100) not null,
 `amound` float not null
);

create table Positions
(
positions_id int not null primary key auto_increment,
`name` varchar (100) not null,
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
`name` varchar (100) not null,
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
compensation_payments_id int not null,
forms_of_remuneration_id int not null,
wage_system_id int not null,
income_tax float not null,
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

insert into Wage_system (`name`) values
('Повременная'),
('Cдельная'),
('Смешанная');

insert into Working_time (`rate_over_time`) values
(0.9),
(1.0),
(1.1);

insert into Rate_over_turnover (`Rate_over_turnover`) values
(0.9),
(1.0),
(1.1);

insert into Forms_of_remuneration (`name`) values
('Рубли'),
('Иностранная валюта'),
('Акции компании');

insert into Fines (`reason`, `type`, `amound`) values
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

insert into Incentive_payments (`name`, `type`, `amound`) values
('Премия', 'Процент', 10),
('Поощрение', 'Сумма', 3000);

alter table Compensation_payments
modify column  `amound` int not null default 15000;

insert into compensation_payments (`name`) values
('Отпускные'),
('Декретные'),
('Больничный');

insert into Positions (`name`, salary, working_days) values
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

insert into Subdivision (`name`, sales_plan, turnover_id, rate_over_turnover_id) values
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




# create table Employee_to_positions
#(
#positions_id int not null,
#employee_id int not null,
#primary key (positions_id, employee_id),
# foreign key (employee_id) references Employee (employee_id),
# foreign key (positions_id) references Positions (positions_id)
#);

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

alter table pay
modify column income_tax float not null default 0.13;

alter table pay
add column compensation_payments_id int;

insert into Pay (employee_id, working_time_id, compensation_payments_id, forms_of_remuneration_id, wage_system_id, appointment_date, payment_date) values
(1, 3, 0, 1, 1, '2021-01-01', '2021-01-02'),
(2, 2, 3, 1, 2, '2018-05-15', '2018-05-16'),
(3, 2, 0, 3, 3, '2019-05-23', '2019-05-24'),
(4, 2, 0, 1, 1, '2019-07-27', '2019-07-28'),
(5, 2, 0, 1, 2, '2017-03-29', '2017-03-30'),
(6, 3, 0, 1, 1, '2017-03-30', '2017-03-31'),
(7, 3, 0, 2, 2, '2021-01-01', '2021-01-02'),
(8, 3, 0, 3, 1, '2021-01-01', '2021-01-02'),
(9, 3, 0, 1, 3, '2021-01-01', '2021-01-02'),
(10, 3, 0, 2, 1, '2021-01-01', '2021-01-02');

insert into Fines_to_pay (pay_id, fines_id, numbers) values
(2, 2, 2);

create table Incentive_payments_to_pay
(
pay_id int not null,
Incentive_payments_id int not null,
primary key (Incentive_payments_id, pay_id),
 foreign key (pay_id) references pay (pay_id),
 foreign key (Incentive_payments_id) references Incentive_payments (Incentive_payments_id)
);

insert into Incentive_payments_to_pay (pay_id, incentive_payments_id) values
(1, 1),
(5, 2),
(6, 1),
(7, 2),
(8, 1),
(9, 1),
(10, 1);

UPDATE Employee
SET birth_date = '2002-07-07'
WHERE Employee_id = 10;

select * from Employee;

alter table Positions 
add check (salary >= 13890);

UPDATE fines SET `amound` = '0.1' WHERE (`fines_id` = '1');
UPDATE fines SET `amound` = '0.1' WHERE (`fines_id` = '2');

insert into Fines_to_pay (pay_id, fines_id, numbers) values
(1, 1, 1),
(3, 1, 3),
(4, 1, 5),
(5, 7, 1);

select * from fines_to_pay;

select fines_id, sum(numbers), count(*) from fines_to_pay group by fines_id;

select pay_id, Employee_id from pay;