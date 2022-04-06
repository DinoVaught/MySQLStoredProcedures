DROP PROCEDURE IF EXISTS mes.gage_lock_set;
CREATE PROCEDURE mes.`gage_lock_set`(IN GageID   varchar(10),
                                     IN LockType varchar(40))
BEGIN

-- This procedure places a lock, the type of lock specified by param LockType, on the specified gage, GageID
-- At the time of this writing, 1/11/2022, there was only 1 lock type 'maintenance'
-- It was assumed that other types of locks would be forthcoming 

    UPDATE mes.mastering_gage_locking
       SET Locked = 'Y',
           Lock_Type = LockType,
           Red_Rabbit_Activated = 'N',
           Master_Activated = 'N',
           Date_Locked = SYSDATE()
     WHERE Gage_ID = GageID;

END;

