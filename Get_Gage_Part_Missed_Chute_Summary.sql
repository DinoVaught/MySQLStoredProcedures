DROP PROCEDURE IF EXISTS mes.Get_Gage_Part_Missed_Chute_Summary;
CREATE PROCEDURE mes.Get_Gage_Part_Missed_Chute_Summary(IN numHours int(10))

BEGIN


	SELECT val_1        AS 'Gage',
		   Count(val_2) AS 'Lock'
	FROM   mes.logs_data
	WHERE  rec_type = 'Gages: Bad Part No Exit Chute Sensor'
		   AND val_2 = 'Locked'
		   AND created > SUBDATE(SYSDATE(), INTERVAL numHours HOUR)
	GROUP  BY val_1
	ORDER  BY Count(val_2) DESC; 

END;