create database guide_bd;
use guide_bd; 
create table fractions 
(
 fractions_id int not null primary key auto_increment,
 leader varchar (100) not null,
 fractions_bonuses int,
 method_of_entry int,
 location_of_the_headquarters int
); 
create table partners 
(
 partners_id int not null primary key auto_increment,
 the_cost_of_hiring int,
 history_of_origin varchar (100) not null,
 the_method_of_hiring int
); 
create table classes
(
classes_id int not null primary key auto_increment,
exp_multiplier int,
passive_bonuses int,
availilable_equipment int
);
create table game_regions
(
game_regions_id int not null primary key auto_increment,
climat int,
geographic_placements int
);
create table mobs
(
mobs_id int not null primary key auto_increment,
armor int,
health int,
damage int,
spawn_place int,
vulnerabilities int,
`name` varchar (100) not null,
game_regions_id int not null,
constraint  fk_game_regions_game_regions_id_1  foreign key (game_regions) references game_regions_id
);
create table game_objects
(
game_objects_id int not null primary key auto_increment,
weight int,
price int
);
create table game_objects_to_mob
(
mobs_id int not null,
game_objects_id int not null,
numbers int,
primary key (mobs_id, game_objects_id),
foreign key (mobs_id) references mobs (mobs_id),
foreign key (game_objects_id) references game_objects (game_objects_id)
);
create table consumables
(
game_objects_id int not null primary key,
hp_regen int,
mana_regen int,
duration int,
foreign key (game_objects_id) references game_objects (game_objects_id)
);
create table equipment
(
game_objects_id int not null primary key,
passive_battle_bonus int,
durability int,
`name` varchar (100) not null,
bonus_type int,
foreign key (game_objects_id) references game_objects (game_objects_id)
);
create table npc
(
npc_id int not null primary key auto_increment,
strength int not null,
agility int not null,
intelligence int not null,
race varchar (20) not null,
sex varchar (1) not null,
constraint  fk_locations_locations_id_1  foreign key (locations) references locations_id
);
create table game_objects_to_npc
(
npc_id int not null,
game_objects_id int not null,
numbers int,
primary key (npc_id, game_objects_id),
foreign key (npc_id) references npc (npc_id),
foreign key (game_objects_id) references game_objects (game_objects_id)
);
create table quests
(
quests_id int not null primary key auto_increment,
reward int,
`level` int
);
create table quests_to_npc
(
npc_id int not null,
quests_id int not null,
primary key (npc_id, quests_id),
foreign key (npc_id) references npc (npc_id),
foreign key (quests_id) references quests (quests_id)
);
create table locations
(
locations_id int not null primary key auto_increment,
spawn_rate int,
avaliable_resourses int,
game_regions_id int not null,
constraint  fk_game_regions_game_regions_id_2  foreign key (game_regions) references game_regions_id
);
create table quests_to_locations
(
quests_id int not null,
locations_id int not null,
primary key (quests_id, locations_id),
foreign key (quests_id) references quests (quests_id),
foreign key (locations_id) references locations (locations_id)
);
create table npc_to_locations
(
npc_id int not null,
locations_id int not null,
primary key (npc_id, locations_id),
foreign key (npc_id) references npc (npc_id),
foreign key (locations_id) references locations (locations_id)
);
create table towns
(
towns_id int not null primary key,
the_presence_of_a_guard int,
passage_fee int,
number_of_population int,
constraint  fk_locations_locations_id_1  foreign key (locations) references locations_id
);
