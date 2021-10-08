/* One to one table */
/* Create a one to one relationship between the two entities Person and User. */
/* each person can be one user and each user belongs to one person */

CREATE TABLE persons (
    person_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    middle_name TEXT,
    last_name TEXT NOT NULL,
    birth_date TIMESTAMP,
);

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    password TEXT NOT NULL,
    username TEXT NOT NULL UNIQUE,
    email character varying(320), /* 64 char for username, 1 char for @, and 255 char for domain name */
    cell_phone character varying(24),
    person_id INT UNIQUE NOT NULL,
    FOREIGN KEY(person_id) REFERENCES persons(person_id) 
); 

/* One to many table */
/* Create a one to many relationship between the two entities Team and Players */
/* players can be on at most one team, but team has many players */
CREATE TABLE teams (
    team_id SERIAL PRIMARY KEY,
    team_name TEXT NOT NULL,
    mascot TEXT,
    sport TEXT
);

CREATE TABLE players (
    player_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    middle_name TEXT,
    last_name TEXT NOT NULL,
    birth_date TIMESTAMP,
    role TEXT NOT NULL,
    team_id INT NOT NULL,
    CONSTRAINT fk_player_team FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

/* many to many table */
/* Create a many to many relationship between the two entities Students and Subject. */

CREATE TABLE subjects (
    subject_id SERIAL PRIMARY KEY,
    course_name TEXT NOT NULL,
    course_number INT NOT NULL,
    max_size INT,
    prereqs TEXT
);

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    middle_name TEXT,
    last_name TEXT NOT NULL,
    birth_date TIMESTAMP,
    stu_year TEXT NOT NULL,
    major TEXT
);

CREATE TABLE students_subjects (
    subject_id INT NOT NULL,
    student_id INT NOT NULL,
    PRIMARY KEY (subject_id, student_id),
    CONSTRAINT fk_class FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
    CONSTRAINT fk_student_enrollment FOREIGN KEY (student_id) REFERENCES students(student_id)
);