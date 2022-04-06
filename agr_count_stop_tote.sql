DROP PROCEDURE IF EXISTS mes.agr_count_stop_tote;
CREATE PROCEDURE mes.`agr_count_stop_tote`(IN MachTotalStop int(10),
                                           IN GageID varchar(10),
                                           IN RecType varchar(20),
                                           IN StopSTN_1 int(10),
                                           IN StopSTN_2 int(10),
                                           IN StopSTN_3 int(10),
                                           IN StopSTN_4 int(10),
                                           IN StopSTN_5 int(10),
                                           IN StopSTN_6 int(10))
BEGIN
	 
  DECLARE startTime DATETIME;
  DECLARE rjctTotal INT DEFAULT 0;
  DECLARE st_1 INT DEFAULT 0;
  DECLARE st_2 INT DEFAULT 0;
  DECLARE st_3 INT DEFAULT 0;
  DECLARE st_4 INT DEFAULT 0;
  DECLARE st_5 INT DEFAULT 0;
  DECLARE st_6 INT DEFAULT 0;
  
--  call debug_msg_log('Blue', GageID, 'GageID1');

  IF (StopSTN_1 IS NULL) THEN
    SET st_1 = 0;
  ELSE
    SET st_1 = StopSTN_1;
  END IF;

  IF (StopSTN_2 IS NULL) THEN
    SET st_2 = 0;
  ELSE
    SET st_2 = StopSTN_2;
  END IF;

  IF (StopSTN_3 IS NULL) THEN
    SET st_3 = 0;
  ELSE
    SET st_3 = StopSTN_3;
  END IF;

  IF (StopSTN_4 IS NULL) THEN
    SET st_4 = 0;
  ELSE
    SET st_4 = StopSTN_4;
  END IF;  

  IF (StopSTN_5 IS NULL) THEN
    SET st_5 = 0;
  ELSE
    SET st_5 = StopSTN_5;
  END IF;  

  IF (StopSTN_6 IS NULL) THEN
    SET st_6 = 0;
  ELSE
    SET st_6 = StopSTN_6;
  END IF;  
  
  SET rjctTotal = StopSTN_1 + StopSTN_2 + StopSTN_3 + StopSTN_4 + StopSTN_5 + StopSTN_6;
 
 
   SELECT MAX(Start_Time) 
     INTO startTime
     FROM mes.agr_counts
    WHERE RecordType = RecType
      AND Gage_ID = GageID
      AND End_Time IS NULL;

-- call debug_msg_log('Blue', startTime, 'startTime');
-- call debug_msg_log('Blue', RecType, 'RecType');
-- call debug_msg_log('Blue', GageID, 'GageID2');
 
  UPDATE mes.agr_counts
     SET End_Time = SYSDATE(),           -- :EndTime,
         Mach_Total_End = MachTotalStop, -- :MachTotalEnd,
         Reject_Total_End = rjctTotal,   -- :RejectTotalEnd,
         End_STN_1 = st_1,    -- :EndSTN1,
         End_STN_2 = st_2,    -- :EndSTN2,
         End_STN_3 = st_3,    -- :EndSTN3,
         End_STN_4 = st_4,    -- :EndSTN4,
         End_STN_5 = st_5,    -- :EndSTN5,
         End_STN_6 = st_6     -- :EndSTN6
   WHERE RecordType = RecType
     AND Gage_ID = GageID
     AND Start_Time = startTime
     AND End_Time IS NULL;
  
  -- call debug_msg_log('Blue', CONCAT('ROW_COUNT() = ',  ROW_COUNT()));
  -- call debug_msg_log('Blue', CONCAT('GageID = ', GageID));
  
  
END;

