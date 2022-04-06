DROP PROCEDURE IF EXISTS mes.maintenance_count_reset_zero;
CREATE PROCEDURE mes.`maintenance_count_reset_zero`(IN GageID varchar(10))
BEGIN

	UPDATE mastering_part_counting
	   SET Last_Maintenance_Count = Current_Total_Parts
	 WHERE Gage_ID = GageID;
 
  UPDATE mastering_gage_locking
     SET Locked = 'N',
         Lock_Type = '',
         Red_Rabbit_Activated = '',
         User_Unlocked = 'admin: maintenance_count_reset_zero',
         Date_Unlocked = SYSDATE()
   WHERE Gage_ID = GageID;

END;

