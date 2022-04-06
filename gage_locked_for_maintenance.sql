DROP PROCEDURE IF EXISTS mes.gage_locked_for_maintenance;
CREATE PROCEDURE mes.`gage_locked_for_maintenance`(IN GageID varchar(10))
BEGIN
-- ================================================================================================================
-- If the Gage (GageID) is currently locked for maintenance gage_locked_for_maintenance() returns 'Y'
-- If the Gage (GageID) is currently NOT locked for maintenance gage_locked_for_maintenance() returns 'N'

-- Red_Rabbit_Activated = 'Y' or 'N' if (Red Rabbit Mode) has been activated (on the Gage) since the lock was put in place
-- Master_Activated = 'Y' or 'N' if (Master Mode) has been activated (on the Gage) since the lock was put in place

-- If either (Red_Rabbit_Activated) or (Master_Activated) is equal to 'N' then (maintenance) is deemed (NOT complete)
-- Both (Red_Rabbit_Activated) and (Master_Activated) must both be NOT equal to 'N' before maintenance is (complete)
-- ================================================================================================================

   SELECT Gage_ID, Locked, Red_Rabbit_Activated, Master_Activated
     FROM mastering_gage_locking
    WHERE Gage_ID = GageID
      AND Lock_Type = 'operator';
              

END;

