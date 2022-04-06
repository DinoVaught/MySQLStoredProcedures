DROP PROCEDURE IF EXISTS mes.maintenance_count_get;
CREATE PROCEDURE mes.`maintenance_count_get`(IN GageID varchar(10))
BEGIN


  UPDATE mes.mastering_part_counting
  SET Last_Read_Date = SYSDATE()
  WHERE Gage_ID = GageID;
    
  
  SELECT Last_Maintenance_Count, Tuneup_Span
  FROM mes.mastering_part_counting
  WHERE Gage_ID = GageID;


END;

