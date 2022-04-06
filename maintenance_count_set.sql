DROP PROCEDURE IF EXISTS mes.maintenance_count_set;
CREATE PROCEDURE mes.`maintenance_count_set`(IN GageID varchar(10),
                                             IN currentTick INT)
BEGIN


  UPDATE mes.mastering_part_counting
  SET Last_Write_Date = SYSDATE(),
      Last_Maintenance_Count = currentTick
  WHERE Gage_ID = GageID;

END;

