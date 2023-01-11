
CREATE TABLE classroom (
 classroom_id SERIAL NOT NULL,
 classroom_name VARCHAR(100)
);

ALTER TABLE classroom ADD CONSTRAINT PK_classroom PRIMARY KEY (classroom_id);


CREATE TABLE instructor (
 employment_id SERIAL NOT NULL,
 first_name VARCHAR(100) NOT NULL,
 last_name VARCHAR(100) NOT NULL,
 street VARCHAR(100) NOT NULL,
 zipcode VARCHAR(5) NOT NULL,
 city VARCHAR(100) NOT NULL,
 email VARCHAR(100) UNIQUE,
 can_teach_ensemble BOOLEAN NOT NULL,
 phone_private VARCHAR(10) UNIQUE,
 phone_other VARCHAR(10) UNIQUE,
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (employment_id);


CREATE TABLE instrument_stock (
 instrument_id SERIAL NOT NULL,
 type VARCHAR(100) NOT NULL,
 in_stock BOOLEAN NOT NULL,
 price INT NOT NULL
);

ALTER TABLE instrument_stock ADD CONSTRAINT PK_instrument_stock PRIMARY KEY (instrument_id);


CREATE TABLE price_list (
 type VARCHAR(100) NOT NULL,
 skill_level INT NOT NULL,
 price INT NOT NULL
);


CREATE TABLE student (
 student_id SERIAL NOT NULL,
 first_name VARCHAR(100) NOT NULL,
 last_name VARCHAR(100) NOT NULL,
 street VARCHAR(100) NOT NULL,
 zipcode VARCHAR(5) NOT NULL,
 city VARCHAR(100) NOT NULL,
 email VARCHAR(100) UNIQUE,
 contact_email VARCHAR(100) UNIQUE,
 contactperson_firstname VARCHAR(100) NOT NULL,
 contactperson_lastname VARCHAR(100) NOT NULL,
 contact_phone VARCHAR(10) UNIQUE,
 contact_phone2 VARCHAR(10) UNIQUE,
 sibling1 INT,
 sibling2 INT
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE individual_lesson (
 lesson_id SERIAL NOT NULL,
 instrument VARCHAR(100) NOT NULL,
 skill_level INT NOT NULL,
 student_id INT NOT NULL,
 start_time TIMESTAMP NOT NULL,
 end_time TIMESTAMP NOT NULL,
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (lesson_id);


CREATE TABLE application (
 student_id INT NOT NULL,
 skill_level INT NOT NULL
);

ALTER TABLE application ADD CONSTRAINT PK_application PRIMARY KEY (student_id);


CREATE TABLE ensemble (
 ensemble_id SERIAL NOT NULL,
 genre VARCHAR(100) NOT NULL,
 min_students INT NOT NULL,
 max_students INT NOT NULL,
 registered_students INT,
 employment_id INT NOT NULL
);

ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (ensemble_id);


CREATE TABLE group_lesson (
 grouplesson_id SERIAL NOT NULL,
 instrument VARCHAR(100) NOT NULL,
 skill_level INT NOT NULL,
 min_students INT NOT NULL,
 max_students INT NOT NULL,
 registered_students INT,
 employment_id INT NOT NULL
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (grouplesson_id);


CREATE TABLE instrument (
 instument_id SERIAL NOT NULL,
 type VARCHAR(100) NOT NULL,
 skill_level INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (instument_id);


CREATE TABLE instrument_rental (
 rental_id SERIAL NOT NULL,
 student_id INT NOT NULL,
 instrument_id INT NOT NULL,
 start_time DATE NOT NULL,
);

ALTER TABLE instrument_rental ADD CONSTRAINT PK_instrument_rental PRIMARY KEY (rental_id);


CREATE TABLE instructor_lesson (
 employment_id INT NOT NULL,
 lesson_id INT NOT NULL
);

ALTER TABLE instructor_lesson ADD CONSTRAINT PK_instructor_lesson PRIMARY KEY (employment_id,lesson_id);


CREATE TABLE student_ensemble (
 ensemble_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE student_ensemble ADD CONSTRAINT PK_student_ensemble PRIMARY KEY (ensemble_id);


CREATE TABLE student_group_lesson (
 grouplesson_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE student_group_lesson ADD CONSTRAINT PK_student_group_lesson PRIMARY KEY (grouplesson_id);


CREATE TABLE ensemble_schedule (
 classroom_id INT NOT NULL,
 start_time TIMESTAMP NOT NULL,
 end_time TIMESTAMP NOT NULL,
 ensemble_id INT
);

ALTER TABLE ensemble_schedule ADD CONSTRAINT PK_ensemble_schedule PRIMARY KEY (classroom_id);


CREATE TABLE group_schedule (
 classroom_id INT NOT NULL,
 start_time TIMESTAMP NOT NULL,
 end_time TIMESTAMP NOT NULL,
 grouplesson_id INT NOT NULL
);

ALTER TABLE group_schedule ADD CONSTRAINT PK_group_schedule PRIMARY KEY (classroom_id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE application ADD CONSTRAINT FK_application_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_0 FOREIGN KEY (employment_id) REFERENCES instructor (employment_id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (employment_id) REFERENCES instructor (employment_id);


ALTER TABLE instrument ADD CONSTRAINT FK_instrument_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE instrument_rental ADD CONSTRAINT FK_instrument_rental_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE instrument_rental ADD CONSTRAINT FK_instrument_rental_1 FOREIGN KEY (instrument_id) REFERENCES instrument_stock (instrument_id);


ALTER TABLE instructor_lesson ADD CONSTRAINT FK_instructor_lesson_0 FOREIGN KEY (employment_id) REFERENCES instructor (employment_id);
ALTER TABLE instructor_lesson ADD CONSTRAINT FK_instructor_lesson_1 FOREIGN KEY (lesson_id) REFERENCES individual_lesson (lesson_id);


ALTER TABLE student_ensemble ADD CONSTRAINT FK_student_ensemble_0 FOREIGN KEY (ensemble_id) REFERENCES ensemble (ensemble_id);
ALTER TABLE student_ensemble ADD CONSTRAINT FK_student_ensemble_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE student_group_lesson ADD CONSTRAINT FK_student_group_lesson_0 FOREIGN KEY (grouplesson_id) REFERENCES group_lesson (grouplesson_id);
ALTER TABLE student_group_lesson ADD CONSTRAINT FK_student_group_lesson_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE ensemble_schedule ADD CONSTRAINT FK_ensemble_schedule_0 FOREIGN KEY (classroom_id) REFERENCES classroom (classroom_id);
ALTER TABLE ensemble_schedule ADD CONSTRAINT FK_ensemble_schedule_1 FOREIGN KEY (ensemble_id) REFERENCES student_ensemble (ensemble_id);


ALTER TABLE group_schedule ADD CONSTRAINT FK_group_schedule_0 FOREIGN KEY (classroom_id) REFERENCES classroom (classroom_id);
ALTER TABLE group_schedule ADD CONSTRAINT FK_group_schedule_1 FOREIGN KEY (grouplesson_id) REFERENCES student_group_lesson (grouplesson_id);


