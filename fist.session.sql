SELECT * FROM users WHERE gender IS NULL;

ALTER TABLE orders ADD COLUMN status boolean;

UPDATE orders SET status = true WHERE id % 2 = 0;
UPDATE orders SET status = false WHERE id % 2 = 1;

SELECT id, create_at, customer_id, status AS order_status FROM orders ORDER BY id; ---alias for attribute              
              
            04.02.2023

             ----1NF
CREATE TABLE employees(
    id serial PRIMARY KEY,
    name varchar(200),
    department varchar(300),
    position varchar(300),
    car_aviability boolean
);

 INSERT INTO employees(name,position,car_aviability) VALUES
  ('John', 'HR', false),
  ('Alex', 'Saler', true),
  ('Andrey', 'Full stack JS developer', false),
  ('Sony', 'HR', true),
  ('Mario', 'Game dev', false);

     -----2NF
   
 CREATE TABLE position (
    name varchar(300) PRIMARY KEY,
    department varchar,
    car_aviability boolean
 );

  DROP TABLE employees; 

CREATE TABLE employees (
    id serial PRIMARY KEY,
    name varchar(200),
    position varchar(300) REFERENCES position(name)
);

INSERT INTO position(name, car_aviability) VALUES
 ('HR', false), ('Sales', false), ('Top managment driver', true);

 INSERT INTO employees (name, position) VALUES
  ('Alex', 'HR'), ('Mario', 'Sales'), ('Solo', 'Top managment driver');

  SELECT * FROM employees
  JOIN position ON employees.position = position.name;


  --------------------3NF
DROP TABLE employees;
DROP TABLE positions;


CREATE TABLE employees(
    id serial PRIMARY KEY,
    name varchar(200),
    department varchar(300),
    department_phone varchar(15)
);


INSERT INTO employees (name, department, department_phone) VALUES
('John Doe', 'HR', '24-12-16'),
('Jane Doe', 'Sales', '23-23-23'),
('Carl Moe', 'Clojure Developer', '20-19-21');

CREATE TABLE departments (
    name varchar(200) PRIMARY KEY,
    phone_number varchar(15)
);

INSERT INTO departments VALUES
('HR', '24-12-16'),
('Sales', '23-23-23'),
('Clojure Developer', '20-19-21');


DROP COLUMN department_phone;

ALTER TABLE employees ADD FOREIGN KEY (department) REFERENCES departments(name);


------------------------------
            02.02.2023
 Sorting
 ASC -  less
 DESC -  more

SELECT * FROM users ORDER BY birthday ASC;

UPDATE users SET birthday = '1940-05-12' WHERE id BETWEEN 5 AND 10

SELECT fist_name, extract('years' from age(birthday)) FROM users ORDER BY extract('years' from age(birthday))
SELECT * FROM(
    SELECT *, extract('years' from age(birthday)) AS age
    FROM users
) AS "u_w_age"
ORDER BY "u_w_age".age

SELECT * FROM products ORDER BY quantity DESC ASC 3

SELECT count(*), extract('years' from age(birthday)) AS age FROM users GROUP BY age ORDER BY age

----------------------------
 ---HAVING

SELECT count(*), extract('years' from age(birthday)) AS age FROM users GROUP BY age HAVING count(*) >= 10 ORDER BY age 

SELECT sum(quantity), brand FROM products GROUP BY brand HAVING sum(quantity) > 13000

SELECT product_id, sum(quantity) FROM orders_to_products GROUP BY product_id HAVING sum(quantity) > 50
----------------------------

 --- Users order
  SELECT count(*), u.* FROM orders AS u JOIN orders AS o ON u.id = o.customer_id GROUP BY u.id;

  SELECT * FROM users AS u LEFT JOIN orders AS o ON u.id = o.customer_id WHERE o.customer_id IS NULL;


 CREATE TABLE A ( v char(3), t int);
 CREATE TABLE B (v char(3));
DROP TABLE b
 INSERT INTO a VALUES
 ('XXX', 1),
 ('XXY', 2),
 ('XXZ', 1),
 ('YZX', 3),
 ('XZX', 2),
 ('ZYX', 2),
 ('YZY', 3),
 ('ZZX', 3),
 ('YZZ', 2);

 INSERT INTO b VALUES
 ('ZXX'),('XZY'),('YXZ'),('YXY'),('YZZ');

 SELECT * FROM a, b;
 SELECT * FROM A JOIN B ON A.v = B.v


-----------------------------
 Alias

SELECT fist_name AS "Им'я", last_name AS "Фамилия", id AS "Номер" FROM users;

SELECT *, extract('years' from age(birthday)) AS "Возраст" from users WHERE extract('years' from age(birthday)) BETWEEN 20 AND 40;

SELECT * FROM orders_to_products AS "Чек";
SELECT * FROM users;
---------------------------

Pagination
SELECT * FROM users LIMIT 10 OFFSET 10;

---------------------

SELECT id, fist_name || ' ' || last_name AS "full name" FROM users;
SELECT id, concat(fist_name, ' ', last_name ) AS " full name" FROM users;
SELECT id, concat(fist_name, ' ', last_name) AS "full name"  FROM users WHERE char_length(concat(fist_name, ' ', last_name)) >15;
SELECT * FROM (
    SELECT id, concat(fist_name, ' ', last_name) AS "full name"
    FROM users
) AS "FN" WHERE char_length(concat("FN"."full name")) >15;

------
   Aggre
SELECT max(weight) FROM users;
SELECT min(weight) FROM users; 
SELECT sum(weight) FROM users; 
SELECT avg(weight) FROM users;
SELECT count(fist_name) FROM users;
SELECT gender, avg(weight) FROM users GROUP BY gender;
SELECT avg(weight) FROM users WHERE extract('years' from birthday) > 1960;
SELECT avg(weight) FROM users WHERE extract('years' from age(birthday)) =27 AND gender ='male';
SELECT avg(extract('years' from age(birthday))) FROM users;
SELECT min(extract('years' from age(birthday))), max(extract('years' from age(birthday))) FROM users;
SELECT gender, min(extract('years' from age(birthday))), max(extract('years' from age(birthday))) FROM users GROUP BY gender;;
SELECT gender, count(id) FROM users GROUP BY gender;

--------------------
   Practice 
 CREATE TABLE workers(
    id serial PRIMARY KEY,
    name varchar(64),
    salary int,
    birthday date
 );
 
 INSERT INTO workers (name, salary, birthday) VALUES 
 ('Oleg', 300, '1995-02-25');
 
 INSERT INTO workers (name, salary, birthday) VALUES 
 ('Jaroslava', 350, '1992-09-13');
 
 INSERT INTO workers (name, salary, birthday) VALUES
 ('Sasha',1000,'1996-05-25'),
 ('Masha',200,'1997-04-11');

 SELECT * FROM workers;
UPDATE workers SET salary = 500 WHERE id = 1;
UPDATE workers SET salary = 400 WHERE salary > 500;
SELECT id, name FROM workers WHERE id = 4;

SELECT count(*), brand FROM products GROUP BY brand;

------------------------------------------------- 

INSERT INTO users (fist_name, last_name, email, is_subscribe) VALUES
    ('Sron', 'Man', 'Sonystark@mail.com', true);


DELETE FROM users WHERE id >= 25;    
DELETE FROM products;   
DELETE FROM orders_to_products; 
SELECT id, fist_name FROM users WHERE id < 50;
SELECT id, fist_name from users;
SELECT fist_name, is_subscribe from users WHERE is_subscribe = false;
SELECT * from users WHERE is_subscribe = true
SELECT * from users WHERE id % 2 = 0 ;
SELECT * FROM users WHERE height >= 1.5
SELECT * FROM users WHERE gender ='male' AND is_subscribe = true
SELECT * FROM users WHERE id > 850 AND id < 900;
SELECT * FROM users WHERE fist_name LIKE 'A%' AND '%b'; 
DROP TABLE orders_to_products;
ALTER TABLE users ADD COLUMN weight int CHECK(weight !=0  AND weight>0);

SELECT id, fist_name, last_name, birthday, extract("years" from age(birthday)) FROM users WHERE id = 6;

UPDATE users SET weight =60 ;
UPDATE users SET weight = 70 WHERE id BETWEEN 1 AND 1000 RETURNING *;

UPDATE emplouees SET salary * 1.2 WHERE  work_hours > 150 RETURNING *;

---------------

SELECT fist_name, last_name, gender, extract('years' FROM age(birthday)) FROM users WHERE gender = 'male' AND extract('years' FROM age(birthday)) >=18;

SELECT * FROM users WHERE gender = 'female' AND fist_name LIKE 'A%';

SELECT fist_name, last_name, birthday, extract('years' from age(birthday)) FROM users WHERE extract('years' FROM age(birthday)) BETWEEN 20 AND 40;

SELECT * FROM users WHERE extract('month' from birthday) = 9;

SELECT * FROM users WHERE extract('month' from birthday) = 11 AND extract('day' FROM birthday) = 1;
UPDATE users SET is_subscribe = true WHERE extract('month' from birthday) = 11 AND extract('day' FROM birthday) = 1; 

DELETE FROM users WHERE extract('years' from age(birthday)) > 65;
SELECT fist_name, last_name, gender, extract('years' FROM age(birthday)) WHERE extract('years' FROM age(birthday)) > 65;

UPDATE users SET weight =  80 WHERE gender = 'male' AND  extract('years' FROM age(birthday)) BETWEEN 40 AND 50 RETURNING *;
-----------------------------

DROP TABLE orders;

DROP TABLE messages;

DROP TABLE chats_to_users;

DROP TABLE chats;

DROP TABLE reactions;

DROP TABLE contents;

DROP TABLE products;


DROP TABLE users;

CREATE TABLE users(
    id serial PRIMARY KEY,
    first_name varchar(64) NOT NULL CONSTRAINT first_name_not_empty CHECK (first_name != ''),
    last_name varchar(64) NOT NULL CHECK (last_name != ''),
    email text NOT NULL CHECK (email != '') UNIQUE,
    gender varchar(30),
    is_subscribe boolean NOT NULL,
    birthday date CHECK (birthday < current_date),
    foot_size smallint,
    height numeric(3, 2) CONSTRAINT too_high_user CHECK (height < 3.0)
);

CREATE TABLE products (
    id serial PRIMARY KEY,
    brand varchar(200) NOT NULL,
    model varchar(300) NOT NULL,
    description text,
    category varchar(200) NOT NULL,
    price numeric(10,2) NOT NULL CHECK (price > 0),
    discounted_price numeric(10,2) CHECK (discounted_price <= price),
    quantity int CHECK (quantity > 0)
);

CREATE TABLE orders(
    id serial PRIMARY KEY,
    created_at timestamp NOT NULL DEFAULT current_timestamp,
    customer_id int REFERENCES users(id)
);


CREATE TABLE orders_to_products(
    order_id int REFERENCES orders(id),
    product_id int REFERENCES products(id),
    quantity int,
    PRIMARY KEY(order_id, product_id)
);