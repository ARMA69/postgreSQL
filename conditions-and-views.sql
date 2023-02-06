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