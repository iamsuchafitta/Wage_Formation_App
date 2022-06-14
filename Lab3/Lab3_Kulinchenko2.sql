create database my_company_bd;
use my_company_bd; 
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
 `amound` int not null
); 
create table Positions 
(
positions_id int not null primary key auto_increment,
`name` varchar (100) not null,
salary int not null,
working_days int not null
); 

create table Subdivision 
(
subdivision_id int not null primary key auto_increment,
`name` varchar (100) not null,
sales_plan int,
subdivision_turnover int,
rate_over_turnover float not null default 1
); 
create table Turnover 
(
turnover_id int not null primary key auto_increment,
start_date date not null,
over_date date not null,
summ int
); 

create table Employee 
(
Employee_id int not null primary key auto_increment,
full_name varchar(150) not null,
birth_date date not null,
subdivision_id int not null,
constraint  fk_subdivision_subdivision_id_2  foreign key (subdivision_id) references Subdivision (subdivision_id)
); 

create table Employee_to_positions
(
positions_id int not null,
employee_id int not null,
primary key (positions_id, employee_id),
 foreign key (employee_id) references Employee (employee_id),
 foreign key (positions_id) references Positions (positions_id)
);
create table Compensation_payments 
(
 Compensation_payments_id int not null primary key auto_increment,
`name` varchar (100) not null,
 `amound` int not null
);
create table Pay
(
pay int not null primary key auto_increment,
employee_id int not null,
working_time_id int not null,
compensation_payments_id int not null,
forms_of_remuneration_id int not null,
wage_system_id int not null,
income_tax float not null,
appointment_date date not null,
payment_date date not null,
foreign key (employee_id) references Employee (employee_id),
foreign key (working_time_id) references working_time (working_time_id),
foreign key (compensation_payments_id) references Compensation_payments (compensation_payments_id),
foreign key (wage_system_id) references wage_system (wage_system_id)
);

alter table pay 
rename column pay to pay_id;

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

alter table pay 
add foreign key (forms_of_remuneration_id) references forms_of_remuneration (forms_of_remuneration_id);

insert into Wage_system (`name`) values 
('Повременная'),
('Cдельная'),
('Смешанная');

select * from wage_system;
 
insert into Working_time (`rate_over_time`) values 
(0.9),
(1.0),
(1.1);

insert into Forms_of_remuneration (`name`) values 
('Рубли'),
('Иностранная валюта'),
('Акции компании');

alter table fines
modify column `amound` float not null;

insert into Fines (`reason`, `type`, `amound`) values 
('За опоздание', 'Процент', 0.3),
('За неявку', 'Процент', 0.3),
('За превышение должностных полномочий', 'Сумма', 500),
('За неуважительное отношение к коллегам/начальству', 'Сумма', 500),
('За отказ от выполнения прямых обязанностей', 'Сумма', 1000);

insert into Incentive_payments (`name`, `type`, `amound`) values 
('Премия', 'Процент', 10),
('Поощрение', 'Сумма', 3000); 

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

alter table Subdivision 
add foreign key (forms_of_remuneration_id) references forms_of_remuneration (forms_of_remuneration_id);

create table Subdivision 
(
subdivision_id int not null primary key auto_increment,
`name` varchar (100) not null,
sales_plan int,
subdivision_turnover int,
rate_over_turnover float not null default 1
); 

alter table Subdivision 
drop subdivision_turnover, 
drop rate_over_turnover;

alter table Subdivision 
add column turnover_id  int not null,
add foreign key (turnover_id) references turnover (turnover_id);

alter table Subdivision 
add column rate_over_turnover_id  int not null,
add foreign key (rate_over_turnover_id) references rate_over_turnover (rate_over_turnover_id);

insert into Rate_over_turnover (`Rate_over_turnover`) values 
(0.9),
(1.0),
(1.1);

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
