DROP PROCEDURE IF EXISTS mes.Get_Gage_Part_Missed_Chute_Details;
CREATE PROCEDURE mes.Get_Gage_Part_Missed_Chute_Details(IN numHours int(10))

BEGIN

	-- DECLARE qry_date VARCHAR(50);

	-- SET qry_date = SUBDATE(qryDate, INTERVAL hours HOUR);


	SELECT created AS 'Date',
		   val_1   AS 'Gage',
		   val_2   AS 'Lock',
		   val_3   AS 'Emp'
	FROM   mes.logs_data
	WHERE  rec_type = 'Gages: Bad Part No Exit Chute Sensor'
		   AND created > SUBDATE(SYSDATE(), INTERVAL numHours HOUR)
	ORDER  BY created DESC;


END;