DROP PROCEDURE IF EXISTS mes.maintenance_current_count_set;
CREATE PROCEDURE mes.`maintenance_current_count_set`(IN GageID varchar(10),
                                                   IN currentTick INT)
BEGIN


  UPDATE mes.mastering_part_counting
  SET Current_Total_Parts = currentTick
  WHERE Gage_ID = GageID;

END;

