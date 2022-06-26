SELECT * FROM debug
ORDER BY created DESC;


SELECT created, msg FROM debug
WHERE msgID LIKE('%zsw%')
AND msg NOT LIKE('%False%')
AND created > '2022-06-23 12:45:00'
ORDER BY created DESC;

SELECT DISTINCT(msg) FROM debug
WHERE msgID LIKE('%zsw%')
AND msg NOT LIKE('%False%')
AND created > '2022-06-23 10:16:16'
ORDER BY created DESC;


SELECT * FROM mes.supervisor_user_id_pins;

SELECT user_name, user_id, pin_id 
FROM mes.supervisor_user_id_pins
ORDER BY idx;


INSERT INTO
  mes.supervisor_user_id_pins(
   user_name,
   user_id,
   pin_id)
VALUES
  ('Buzz Gordon', -- :user_name,
   '2045',   -- :user_id,
   '1010')  -- :pin_id);