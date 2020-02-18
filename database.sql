CREATE DATABASE MyFitnessPal;

USE MyFitnessPal;

CREATE TABLE user(
	full_name VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL,
	username VARCHAR(255) NOT NULL UNIQUE,
	password VARCHAR(255) NOT NULL,
	PRIMARY KEY(username)
);

CREATE TABLE equipment(
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255),
	description VARCHAR(5000),
	workout_type ENUM('Weight Training', 'Cardio') NOT NULL DEFAULT 'Weight Training',
	image_content LONGBLOB,
	user VARCHAR(255),
	PRIMARY KEY(id),
	CONSTRAINT AK_UnqueName UNIQUE(name)
);

CREATE TABLE muscle(
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255),
	description VARCHAR(5000),
	muscle_group_id INT NOT NULL,
	image_content LONGBLOB,
	user VARCHAR(255),
	PRIMARY KEY(id),
	CONSTRAINT AK_UnqueName UNIQUE(name)
);

CREATE TABLE muscle_group(
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255),
	description VARCHAR(5000),
	image_content LONGBLOB,
	user VARCHAR(255),
	PRIMARY KEY(id),
	CONSTRAINT AK_UnqueName UNIQUE(name)
);


CREATE TABLE workout (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255),
	skill_level ENUM ('Beginner', 'Intermediate', 'Advanced') NOT NULL DEFAULT 'Beginner',
	type ENUM ('Weight Training', 'Cardio') NOT NULL DEFAULT 'Weight Training',
	equipment_ids VARCHAR(255),
	muscle_ids VARCHAR(255), 
	image_content LONGBLOB,
	video VARCHAR(255),
	instructions VARCHAR(5000),
	user VARCHAR(255),
	PRIMARY KEY(id),
	CONSTRAINT AK_UnqueName UNIQUE(name)
);

create trigger embedvideo
before insert on workout
for each row
SET NEW.video= REPLACE(NEW.video, "https://www.youtube.com/watch?v=", "https://www.youtube.com/embed/");

ALTER TABLE equipment
ADD FOREIGN KEY (user) REFERENCES user(username);

ALTER TABLE muscle_group
ADD FOREIGN KEY (user) REFERENCES user(username);

ALTER TABLE muscle
ADD FOREIGN KEY (user) REFERENCES user(username);

ALTER TABLE muscle
ADD FOREIGN KEY (muscle_group_id) REFERENCES muscle_group(id);

ALTER TABLE workout
ADD FOREIGN KEY (user) REFERENCES user(username);

