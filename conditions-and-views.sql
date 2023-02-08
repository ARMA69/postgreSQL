      8.02.2023

      ------ ENUM

SELECT * FROM orders WHERE status = true;

CREATE TYPE order_status AS ENUM ('new', 'processing', 'shiped', 'done');

ALTER TABLE orders ALTER COLUMN status TYPE order_status
USING(
  CASE status 
  WHEN false THEN 'processing'
  WHEN true THEN 'done'
  ELSE 'new'
  END
)::order_status;

INSERT INTO orders(customer_id, status) VALUES
(4, 'new');

SELECT * FROM orders ORDER BY create_at DESC;

    07.02.2023


-----------views

CREATE VIEW users_with_orders_amout AS (
SELECT u.*, count(o.id) AS "orders_amount" 
FROM users AS u
LEFT JOIN orders AS o
ON u.id = o.customer_id
GROUP BY u.id, u.email
ORDER BY "orders_amount"
);

SELECT * FROM users_with_orders_amout;

SELECT email FROM users_with_orders_amout
WHERE orders_amount = 1;


CREATE OR REPLACE VIEW users_with_orders_amout AS (
SELECT u.*, count(o.id) AS "orders_amount" 
FROM users AS u
LEFT JOIN orders AS o
ON u.id = o.customer_id
GROUP BY u.id, u.email
ORDER BY "orders_amount"
);

CREATE VIEW orders_with_price AS (
    SELECT o.id, o.customer_id, sum(p.price * otp.quantity) AS "order_sum", o.status
    FROM orders AS o
    JOIN orders_to_products AS otp
    ON o.id = otp.order_id
    JOIN products AS p
    ON p.id = otp.product_id
    GROUP BY o.id
);

SELECT * FROM orders_with_price;

SELECT u.id, u.email, sum(owp.order_sum) AS sum_amount
FROM users AS u
JOIN orders_with_price AS owp
ON u.id = owp.customer_id
GROUP BY u.id
ORDER BY sum_amount DESC
LIMIT 10;



    ---EXISTS

 ---IN, NOT IN, SOME, ANY, EXISTS, ALL

SELECT * FROM users AS u
WHERE u.id IN(
  SELECT customer_id FROM orders
);

SELECT * FROM products AS p
WHERE p.id NOT IN(
  SELECT product_id FROM orders_to_products
);

SELECT EXISTS(
SELECT * FROM users
WHERE id = 1166);

SELECT * FROM users AS u
WHERE EXISTS(
  SELECT * FROM orders AS o
  WHERE u.id = o.customer_id
);


SELECT * FROM users AS u
WHERE u.id = ANY(
  SELECT customer_id FROM orders
);

SELECT * FROM products AS p
WHERE p.id != ALL (
  SELECT product_id FROM orders_to_products
);

SELECT * FROM products AS p
WHERE p.id = ANY(
  SELECT product_id FROM orders_to_products AS otp
  WHERE order_id = SOME(
    SELECT id FROM orders AS o 
    WHERE o.customer_id = 1255
  )
);

SELECT * FROM products AS p
JOIN orders_to_products AS otp
ON otp.product_id = p.id
JOIN orders AS o
ON otp.order_id = o.id
WHERE o.customer_id = 1255;
 ----------CASE

 ---1 syntax

SELECT  id, create_at, customer_id, (
    CASE
        WHEN status = TRUE
        THEN 'сработано'
        WHEN status = FALSE
        THEN 'новый заказ'
        ELSE 'другой статус'
    END    
) AS status FROM orders ORDER BY id;


 --- 2 syntax
  
  SELECT *, (
    CASE extract('month' from birthday)
    WHEN 1 THEN 'winder'
    WHEN 2 THEN 'winder'
    WHEN 3 THEN 'spring'
    WHEN 4 THEN 'spring'
    WHEN 5 THEN 'spring'
    WHEN 6 THEN 'summer'
    WHEN 7 THEN 'summer'
    WHEN 8 THEN 'summer'
    WHEN 9 THEN 'fall'
    WHEN 10 THEN 'fall'
    WHEN 11 THEN 'fall'
    WHEN 12 THEN 'winder'
    ELSE 'unkown'
 END   
<<<<<<< HEAD
) FROM users;

 SELECT *, (CASE gender
 WHEN 'male' THEN 'чоловік'
 WHEN 'female' THEN 'жінка'
 Else 'unkown'
 END
 ) FROM users;


  SELECT  *, (
    CASE
    WHEN extract(year from age(birthday)) < 18
    THEN 'нету 18'
    WHEN extract(year from age(birthday)) >= 18
    THEN 'старше 18'
    ELSE ' непонятно'
    END
  ) FROM users;

  
SELECT u.id, u.fist_name, u.last_name, u.email, count(o.id), (
    CASE
        WHEN count(o.id) >= 3
        THEN 'Постійний клієнт'
        WHEN count(o.id) BETWEEN 1 AND 2
        THEN 'Активний клієнт'
        WHEN count(o.id) = 0
        THEN 'Новий клієнт'
        ELSE 'Клієнт'
    END
)
FROM users AS u
JOIN orders AS o
ON u.id = o.customer_id
GROUP BY u.id, u.fist_name, u.last_name, u.email;

-----------------
   ---1
SELECT count(*) FROM products WHERE price > 3000;
 
   ----2

SELECT sum(
  CASE WHEN price > 3000 THEN 1
  ELSE 0
  END
)
FROM products

    
  -------------------------------

   ---COALESCE

UPDATE products
SET description = 'Супер телефон з довгим описом'
WHERE id BETWEEN 1 AND 250;

SELECT id, model, price, COALESCE(description, 'Про цей товар нічого не відомо')
FROM products;