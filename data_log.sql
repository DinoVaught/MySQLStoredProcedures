DROP PROCEDURE IF EXISTS mes.data_log;
CREATE PROCEDURE mes.data_log(IN data_id varchar(200),
							                IN value_1 varchar(200),
							                IN value_2 varchar(200),
							                IN value_3 varchar(200),
							                IN value_4 varchar(200))

BEGIN

	INSERT INTO mes.logs_data
        (created,
         rec_type,
         val_1,
         val_2,
         val_3,
         val_4)
		 VALUES(SYSDATE(), -- :created
         data_id,      -- :rec_type
         value_1,      -- :val_1, 
         value_2,      -- :val_2,
         value_3,      -- :val_3,
         value_4);     -- :val_4
         
    DELETE FROM mes.logs_data
    WHERE created < SUBDATE(SYSDATE(), INTERVAL 30 DAY);
         
END;
