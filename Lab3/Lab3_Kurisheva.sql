create database training_bd;
use training_bd; 
create table tests
(
 tests_id int not null primary key auto_increment,
 derection varchar (100) not null,
 tasks varchar (100) not null
); 
create table course_result
(
course_result_id int not null primary key auto_increment,
marks varchar (100),
tests_id int,
constraint  fk_tests_tests_id_1  foreign key (tests_id) references tests (tests_id)
);
create table `errors`
(
errors_id int not null primary key auto_increment,
`description` varchar (100),
error_type int,
course_result_id int,
constraint  fk_course_result_course_result_id_1  foreign key (course_result_id) references course_result (course_result_id)
);
create table `user`
(
user_id int not null primary key auto_increment,
`name` varchar (100) not null,
registration_date date not null,
course_result_id int,
constraint  fk_course_result_course_result_id_2  foreign key (course_result_id) references course_result (course_result_id)
);
create table feedback
(
feedback_id int not null primary key auto_increment,
`description` varchar (100),
request_date date not null,
answer varchar (100),
user_id int,
constraint  fk_user_user_id_1  foreign key (user_id) references `user` (user_id)
);
create table movie
(
movie_id int not null primary key auto_increment,
`name` varchar (100),
country varchar (100)
);
create table direction
(
direction_id int not null primary key auto_increment,
`name` varchar (100),
period varchar (100),
country varchar (100),
movie_id int,
constraint  fk_movie_movie_id_1  foreign key (movie_id) references movie (movie_id)
);
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
alter table movie
add column lection_id int;
alter table movie
add foreign key (lection_id) references lection (lection_id);

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
create table user_to_lection
(
user_id int not null,
lection_id int not null,
primary key (user_id, lection_id),
 foreign key (user_id) references `user` (user_id),
 foreign key (lection_id) references lection (lection_id)
);
create table user_to_course
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
alter table `errors`
modify column error_type varchar (100);