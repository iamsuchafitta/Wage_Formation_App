create database training_bd;
use training_bd; 

create table tests
(
 tests_id int not null primary key auto_increment,
 derection varchar (100) not null,
 tasks varchar (100) not null
); 
insert into tests (derection, tasks) values 
('Экспрессионизм', 'Выберите страну: а) Германия б) Франция г) Англия д) Италия'),
('Авангард', 'Выберите страну: а) Германия б) Франция г) Англия д) Италия'),
('Кино абсурда', 'Выберите страну: а) Германия б) Франция г) Англия д) Италия');

create table course_result
(
course_result_id int not null primary key auto_increment,
marks varchar (100),
tests_id int,
constraint  fk_tests_tests_id_1  foreign key (tests_id) references tests (tests_id)
);
alter table course_result
add column user_id int,
add foreign key (user_id) references `user` (user_id);

insert into course_result (marks, tests_id) values 
('Хорошо', 1),
('НЕ хорошо', 2),
('Не хорошо, но и не ужасно', 3);


create table `errors`
(
errors_id int not null primary key auto_increment,
`description` varchar (100),
error_type int,
course_result_id int,
constraint  fk_course_result_course_result_id_1  foreign key (course_result_id) references course_result (course_result_id)
);
alter table `errors`
modify column error_type varchar (100);

insert into `errors` (error_type) values 
('Неправильно заполнены данные');


create table `user`
(
user_id int not null primary key auto_increment,
`name` varchar (100) not null,
registration_date date not null,
course_result_id int,
constraint  fk_course_result_course_result_id_2  foreign key (course_result_id) references course_result (course_result_id)
);
alter table `user`
drop column course_result_id,
drop foreign key fk_course_result_course_result_id_2;
alter table `user`
modify column registration_date date not null default '2000-01-01';

insert into `user` (`name`) values 
('Новиков Семен Мэлорович'),
('Осипов Григорий Николаевич'),
('Миронов Пантелей Валерьевич');

create table feedback
(
feedback_id int not null primary key auto_increment,
`description` varchar (100),
request_date date not null,
answer varchar (100),
user_id int,
constraint  fk_user_user_id_1  foreign key (user_id) references `user` (user_id)
);

insert into feedback (request_date) values 
('2022-01-05');


create table movie
(
movie_id int not null primary key auto_increment,
`name` varchar (100),
country varchar (100)
);
alter table movie
add column direction_id int,
add column director_id int,
add foreign key (direction_id) references direction (direction_id),
add foreign key (director_id) references director (director_id);
alter table movie
drop column lection_id;

create table direction
(
direction_id int not null primary key auto_increment,
`name` varchar (100),
period varchar (100),
country varchar (100),
movie_id int,
constraint  fk_movie_movie_id_1  foreign key (movie_id) references movie (movie_id)
);
alter table direction
drop column movie_id,
drop foreign key fk_movie_movie_id_1;


create table lection
(
lection_id int not null primary key auto_increment,
`name` varchar (100),
lecturer varchar (100),
direction_id int,
tests_id int,
constraint  fk_direction_direction_id_1  foreign key (direction_id) references direction (direction_id),
constraint  fk_tests_tests_id_2  foreign key (tests_id) references tests (tests_id)
);
alter table lection
add column movie_id int,
add foreign key (movie_id) references movie (movie_id),
add column director_id int,
add foreign key (director_id) references director (director_id);

create table genre
(
genre_id int not null primary key auto_increment,
`name` varchar (100),
feature varchar (100)
);

create table course
(
course_id int not null primary key auto_increment,
`name` varchar (100),
education_level varchar (100),
movie_id int,
constraint  fk_movie_movie_id_2  foreign key (movie_id) references movie (movie_id)
);

create table user_to_lection #watch
(
user_id int not null,
lection_id int not null,
primary key (user_id, lection_id),
 foreign key (user_id) references `user` (user_id),
 foreign key (lection_id) references lection (lection_id)
);

create table user_to_course #subscribe
(
user_id int not null,
course_id int not null,
primary key (user_id, course_id),
 foreign key (user_id) references `user` (user_id),
 foreign key (course_id) references course (course_id)
);

create table genre_to_course
(
genre_id int not null,
course_id int not null,
primary key (genre_id, course_id),
 foreign key (genre_id) references genre (genre_id),
 foreign key (course_id) references course (course_id)
);

create table director
(
director_id int not null primary key auto_increment,
`name` varchar (100),
country varchar (100),
movie_id int,
lection_id int,
constraint  fk_movie_movie_id_3  foreign key (movie_id) references movie (movie_id),
constraint  fk_lection_lection_id_2  foreign key (lection_id) references lection (lection_id)
);
alter table director
drop column movie_id,
drop foreign key fk_movie_movie_id_3,
drop column lection_id,
drop foreign key fk_lection_lection_id_2;



#MOD сделать курс по нескольким фильмам
create table course_to_movies
(
course_id int not null,
movie_id int not null,
primary key (course_id, movie_id),
 foreign key (course_id) references course (course_id),
 foreign key (movie_id) references movie (movie_id)
);

#MOD user_to_lection добавить дата и время, проверить, что записываемое значене меньше или равно текущего
alter table user_to_lection
add column watch_date_and_time datetime not null, 
add check (watch_date_and_time <= SYSDATE());


#сделать курс по определенному жанру и курс по дефолтному значению
drop table genre_to_course;
alter table course
add column genre_id int,
add foreign key (genre_id) references genre (genre_id),
modify column `name` varchar (100) default 'Курс по истории отечественного кино';


