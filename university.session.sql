CREATE TABLE departments(
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL CHECK (name !='')
);

CREATE TABLE groups(
    id serial PRIMARY KEY,
    department_id int REFERENCES departments(id)
);

CREATE TABLE students(
    id serial PRIMARY KEY,
    first_name varchar(256) NOT NULL CHECK(first_name !=''),
    last_name varchar(256) NOT NULL CHECK(last_name !=''),
    group_id int REFERENCES groups(id)    
)

CREATE TABLE subjects(
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL CHECK (name !=''),
    teacher varchar(256) NOT NULL CHECK (teacher !='')
)

CREATE TABLE exmas(
    student_id int REFERENCES students(id),
    subject_id int REFERENCES subjects(id),
    grade int,
    is_passed boolean GENERATED ALWAYS AS (grade >= 64 ) STORED
);
DROP TABLE exmas;
INSERT INTO departments (name) VALUES
('KNT'),
('FREEKS'),
('FIOT'),
('Griffindor');

INSERT INTO groups (department_id) VALUES
(1), (2), (3), (4);

INSERT INTO students (first_name, last_name, group_id) VALUES
('Harry', 'Potter', 4),
('Ron', 'Weasley', 4),
('Rex', 'Potter', 3),
('Xman', 'Potter', 1);


INSERT INTO subjects(name, teacher) VALUES
('flying', 'Md.Truck'),
('potions', 'Severus Snape'),
('math', 'Kluchnick');

INSERT INTO exmas(student_id, subject_id, grade) VALUES
(1,1, 90),
(2,1, 50),
(3,3, 20),
(3,3, 100)