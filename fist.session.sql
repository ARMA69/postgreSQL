----------------------------

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