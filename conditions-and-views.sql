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
) FROM users;