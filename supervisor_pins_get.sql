DROP PROCEDURE IF EXISTS mes.supervisor_pins_get;
CREATE PROCEDURE mes.supervisor_pins_get()
BEGIN

	SELECT user_name, user_id, pin_id 
	FROM supervisor_user_id_pins
	ORDER BY idx;

END;

