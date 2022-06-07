DROP PROCEDURE IF EXISTS mes.GetAGR_Data_Day_Shifts;
CREATE PROCEDURE mes.`GetAGR_Data_Day_Shifts`()
BEGIN
  
  -- June 3, 2022 This procedure is not used by anything. Coding on this was started but not finished. This was (put on hold).  
  -- It has a good example of a cursor usage

  
  
  DECLARE rrST1, rrST2, rrST3, rrST4, rrST5, rrST6, rrTot, rrAGR, rrNet, rrPartNum INT DEFAULT 0;
  DECLARE rrShift VARCHAR(1);
  
  DECLARE hydro VARCHAR(3);
  DECLARE gage VARCHAR(3);
  DECLARE finished INTEGER DEFAULT 0;
  
  DECLARE curReruns CURSOR FOR 
    SELECT Gage_ID,
           CASE WHEN HOUR(End_Time) = 23 THEN '3'              -- 11:00 PM - 11:59 PM
                WHEN HOUR(End_Time) BETWEEN 0 AND 6 THEN '3'   -- 12:00 AM to 6:59 AM
                WHEN HOUR(End_Time) BETWEEN 7 AND 14 THEN '1'  -- 7:00 AM - 2:59 PM
                WHEN HOUR(End_Time) BETWEEN 15 AND 22 THEN '2' -- 3:00 PM - 10:59 PM
           END AS 'rrShift',
           (End_STN_1 - Start_STN_1),
           (End_STN_2 - Start_STN_2),
           (End_STN_3 - Start_STN_3),
           (End_STN_4 - Start_STN_4),
           (End_STN_5 - Start_STN_5),
           (End_STN_6 - Start_STN_6),
           (Mach_Total_End - Mach_Total_Start) + (Reject_Total_End - Reject_Total_Start),
           (Reject_Total_End - Reject_Total_Start),
           (Mach_Total_End - Mach_Total_Start),
           PartNum
    FROM agr_counts
    WHERE agr_Counts_ndx BETWEEN 117590 AND 117750;

  DECLARE CONTINUE HANDLER 
  FOR NOT FOUND SET finished = 1; 
  
--  SET gage = 'G21';


--  DROP TABLE IF EXISTS agr_tmp; 
--  CREATE TABLE agr_tmp (
--      Start_Time datetime,
--      End_Time datetime,
--      Gage_ID varchar(10),
--      shift varchar(1),
--      ST_1 int(11),
--      ST_2 int(11),
--      ST_3 int(11),
--      ST_4 int(11),
--      ST_5 int(11),
--      ST_6 int(11),
--      Total int(11),
--      AGR int(11),
--      Net int(11),
--      PartNum int(11),
--      Start_STN_1 int(11),
--      Start_STN_2 int(11),
--      Start_STN_3 int(11),
--      Start_STN_4 int(11),
--      Start_STN_5 int(11),
--      Start_STN_6 int(11));  
  
  
  
  DELETE FROM agr_tmp;
  
  INSERt INTO agr_tmp (Start_Time, End_Time, Gage_ID, shift, ST_1, ST_2, ST_3, ST_4, ST_5, ST_6, Total, AGR, Net, PartNum, Start_STN_1, Start_STN_2, Start_STN_3, Start_STN_4, Start_STN_5, Start_STN_6)
  SELECT  
	   Start_Time,
	   End_Time,
	   Gage_ID,
	   CASE WHEN HOUR(End_Time) = (6) AND MINUTE(End_Time) >= 57  THEN '3'  -- 6:47 AM - 6:59 AM
          WHEN HOUR(End_Time) = (7) AND MINUTE(End_Time) <= 3  THEN '3'   -- 7:00 AM - 6:03 AM

          WHEN HOUR(End_Time) = (14) AND MINUTE(End_Time) >= 57  THEN '1'  -- 2:57 PM - 2:59 PM  
          WHEN HOUR(End_Time) = (15) AND MINUTE(End_Time) <= 3  THEN '1'   -- 3:00 PM - 3:03 PM

          WHEN HOUR(End_Time) = (22) AND MINUTE(End_Time) >= 57  THEN '2'  -- 10:57 PM - 2:59 PM  
          WHEN HOUR(End_Time) = (23) AND MINUTE(End_Time) <= 3  THEN '2'   -- 11:00 PM - 11:03 PM            
	   END AS 'shift', 
	   (End_STN_1 - Start_STN_1) ST_1,
	   (End_STN_2 - Start_STN_2) ST_2,
	   (End_STN_3 - Start_STN_3) ST_3,
	   (End_STN_4 - Start_STN_4) ST_4,
	   (End_STN_5 - Start_STN_5) ST_5,
	   (End_STN_6 - Start_STN_6) ST_6, 
	   (Mach_Total_End - Mach_Total_Start) + (Reject_Total_End - Reject_Total_Start) Total,
	   (Reject_Total_End - Reject_Total_Start) AGR,
	   (Mach_Total_End - Mach_Total_Start) Net,
	   PartNum,
	   Start_STN_1,
	   Start_STN_2,
	   Start_STN_3,
	   Start_STN_4,
	   Start_STN_5,
	   Start_STN_6
	FROM agr_counts
	WHERE End_time IS NOT NULL
	AND RecordType = 'shift'
	-- AND Start_Time BETWEEN start_date AND end_date
	-- AND End_Time < end_date
  -- AND Gage_ID = 'G01'
  AND Start_Time BETWEEN '2022-3-30 22:59:00' AND '2022-3-31 23:01:00'
  AND End_Time < '2022-3-31 23:01:00'
	ORDER BY Gage_ID, Start_Time;

-- ==========================================================
-- ==========================================================
  
  OPEN curReruns;
  
  cursloop: LOOP
  
    FETCH curReruns INTO gage, rrShift, rrST1, rrST2, rrST3, rrST4, rrST5, rrST6, rrTot, rrAGR, rrNet, rrPartNum;
    
    IF finished = 1 THEN
       leave cursloop;
    END IF;
    
    CALL debug_msg_log('bluebonnet', rrTot , rrShift);
    
  END LOOP cursloop;
  
  CLOSE curReruns;

END;
