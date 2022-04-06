DROP PROCEDURE IF EXISTS mes.agr_count_start_tote;
CREATE PROCEDURE mes.`agr_count_start_tote`(IN MachTotalStart int(10),
                                            IN GageID varchar(10),
                                            IN HydroMachine varchar(10),
                                            IN WIP varchar(35),
                                            IN HeatNum varchar(45),
                                            IN PartNumbr varchar(6),
                                            IN SkidNum int(11),
                                            IN EmpID int(11),
                                            IN RecType varchar(20),
                                            IN StartSTN_1 int(10),
                                            IN StartSTN_2 int(10),
                                            IN StartSTN_3 int(10),
                                            IN StartSTN_4 int(10),
                                            IN StartSTN_5 int(10),
                                            IN StartSTN_6 int(10))
BEGIN
	
  
  DECLARE debugGage VARCHAR(6);
  
  DECLARE recCount INT DEFAULT -1;
  DECLARE rjctTotal INT DEFAULT 0;
  DECLARE st_1 INT DEFAULT 0;
  DECLARE st_2 INT DEFAULT 0;
  DECLARE st_3 INT DEFAULT 0;
  DECLARE st_4 INT DEFAULT 0;
  DECLARE st_5 INT DEFAULT 0;
  DECLARE st_6 INT DEFAULT 0;
  

  SET debugGage = 'GXX'; -- 'G11'
  
--  IF GageID = debugGage THEN  -- if debug
--    call debug_msg_log('greenbonnet', CONCAT('rjctTotal = ',  rjctTotal), CONCAT('StartSTN_1 = ', StartSTN_1));
--    call debug_msg_log('greenbonnet', CONCAT('StartSTN_2 = ',  StartSTN_2), CONCAT('StartSTN_3 = ', StartSTN_3));
--    call debug_msg_log('greenbonnet', CONCAT('StartSTN_4 = ',  StartSTN_4), CONCAT('StartSTN_5 = ', StartSTN_5));
--    call debug_msg_log('greenbonnet', CONCAT('StartSTN_6 = ',  StartSTN_6), CONCAT('MachTotalStart = ', MachTotalStart));
--  END IF;

  IF (StartSTN_1 IS NULL) THEN
    SET st_1 = 0;
  ELSE
    SET st_1 = StartSTN_1;
  END IF;

  IF (StartSTN_2 IS NULL) THEN
    SET st_2 = 0;
  ELSE
    SET st_2 = StartSTN_2;
  END IF;

  IF (StartSTN_3 IS NULL) THEN
    SET st_3 = 0;
  ELSE
    SET st_3 = StartSTN_3;
  END IF;

  IF (StartSTN_4 IS NULL) THEN
    SET st_4 = 0;
  ELSE
    SET st_4 = StartSTN_4;
  END IF;  

  IF (StartSTN_5 IS NULL) THEN
    SET st_5 = 0;
  ELSE
    SET st_5 = StartSTN_5;
  END IF;  

  IF (StartSTN_6 IS NULL) THEN
    SET st_6 = 0;
  ELSE
    SET st_6 = StartSTN_6;
  END IF;
  
  
  SET rjctTotal = StartSTN_1 + StartSTN_2 + StartSTN_3 + StartSTN_4 + StartSTN_5 + StartSTN_6;


  SELECT COUNT(Gage_ID) 
    INTO recCount        -- see if there is already a record (started)
    FROM agr_counts
   WHERE RecordType = RecType
     AND Gage_ID = GageID
     AND End_Time IS NULL;


--  IF GageID = debugGage THEN 
--    call debug_msg_log('greenbonnet', CONCAT('Zst_1 = ',  'zst_1'), CONCAT('st_2 ',  'st_1'));
--  END IF;
  
  IF recCount > 0 THEN  -- if a record is already (started) and not (ended)
    call debug_msg_log('stored proc: mes.agr_count_start_tote', CONCAT('recCount = ',  recCount), CONCAT(EmpID, ', ', GageID, ' tried to start multiple ', RecType,  ' records'));
  ELSE

 
 
    INSERT INTO mes.agr_counts(Start_Time,
                                Mach_Total_Start,
                                Gage_ID,
                                Hydromat,
                                wip_id,
                                Heat,
                                PartNum,
                                Skid_ID,
                                Operator,
                                RecordType,
                                Reject_Total_Start,
                                Start_STN_1,
                                Start_STN_2,
                                Start_STN_3,
                                Start_STN_4,
                                Start_STN_5,
                                Start_STN_6)
                      VALUES (SYSDATE(),        -- :Start_Time,
                              MachTotalStart,   -- :Mach_Total_Start,
                              GageID,           -- :Gage_ID, 'G26',
                              HydroMachine,     -- Hydromat, 'D26'
                              WIP,              -- wip_id,
                              HeatNum,          -- Heat,
                              PartNumbr,        -- PartNum,
                              SkidNum, 
                              EmpID,
                              RecType,          -- :RecordType(VARCHAR(20)), 'red tote' or 'black tote'
                              rjctTotal,        -- :Reject_Total_Start (this value is not provided by from the Gage)
                              st_1,       -- :Start_STN_1,
                              st_2,       -- :Start_STN_2,
                              st_3,       -- :Start_STN_3,
                              st_4,       -- :Start_STN_4,
                              st_5,       -- :Start_STN_5,
                              st_6);      -- :Start_STN_6);

                              
  END IF;
  
END;

