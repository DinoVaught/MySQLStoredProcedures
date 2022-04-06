DROP PROCEDURE IF EXISTS mes.gage_lock_remove_lock;
CREATE PROCEDURE mes.`gage_lock_remove_lock`(IN GageID   varchar(10),
                                           IN EmpID    varchar(30))
BEGIN

    UPDATE mes.mastering_gage_locking
       SET Locked = 'N',
           Lock_Type = '',
           Red_Rabbit_Activated = '',
           Master_Activated = '',
           User_Unlocked = EmpID,
           Date_Unlocked = SYSDATE()
     WHERE Gage_ID = GageID;

END;

