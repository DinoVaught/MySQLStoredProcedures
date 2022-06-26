DROP PROCEDURE IF EXISTS mes.GetAGR_Re_Runs;
CREATE PROCEDURE mes.`GetAGR_Re_Runs`(IN qryDate varchar(20))
BEGIN

    DECLARE start_date VARCHAR(50);
    DECLARE end_date VARCHAR(50);	
	
  
    SET start_date = CONCAT(SUBDATE(qryDate, INTERVAL 1 DAY), ' 23:00:00');
    SET end_date = CONCAT(SUBDATE(qryDate, INTERVAL -6 DAY), ' 22:59:59');
    -- SET end_date = CONCAT(qryDate, ' 22:59:00');
    
    
    # call debug_msg_log('greenbonnet', CONCAT('start_date = ',  start_date), CONCAT('end_date = ', end_date));
    

    DELETE FROM agr_reruns_tmp;

    INSERT INTO agr_reruns_tmp (Start_Time, End_Time, Gage_ID, RecordType, shift, ST_1, ST_2, ST_3, ST_4, ST_5, ST_6, Total, AGR, PartNum)    
    SELECT Start_Time,
           End_Time,
           Gage_ID,
           RecordType,
           CASE 
              WHEN HOUR(End_Time) = 23 THEN '3'              -- 11:00 PM - 11:59 PM
              WHEN HOUR(End_Time) BETWEEN 0 AND 6 THEN '3'   -- 12:00 AM to 6:59 AM
              WHEN HOUR(End_Time) BETWEEN 7 AND 14 THEN '1'  -- 7:00 AM - 2:59 PM
              WHEN HOUR(End_Time) BETWEEN 15 AND 22 THEN '2' -- 3:00 PM - 10:59 PM
           END                        AS 'rrShift',
          (End_STN_1 - Start_STN_1)   ST_1,
          (End_STN_2 - Start_STN_2)   ST_2,
          (End_STN_3 - Start_STN_3)   ST_3,
          (End_STN_4 - Start_STN_4)   ST_4,
          (End_STN_5 - Start_STN_5)   ST_5,
          (End_STN_6 - Start_STN_6)   ST_6, 
          (Mach_Total_End - Mach_Total_Start) + (Reject_Total_End - Reject_Total_Start) Total,
          (Reject_Total_End - Reject_Total_Start) AGR,
          PartNum
    FROM  agr_counts
    WHERE End_time IS NOT NULL
    AND RecordType = 're-run'
    AND Start_Time BETWEEN start_date AND end_date                         -- spans 1 full Deutsche day
     -- AND End_Time BETWEEN '2022-5-09 23:00:00' AND '2022-5-10 22:59:00' -- spans 1 full Deutsche day (debug)
 ORDER BY Gage_ID, Start_Time;
    
    SELECT Gage_ID,
           SUM(ST_1) ST_1,
           SUM(ST_2) ST_2,
           SUM(ST_3) ST_3,
           SUM(ST_4) ST_4,
           SUM(ST_5) ST_5,
           SUM(ST_6) ST_6, 
           SUM(Total) Total,
           SUM(AGR) AGR,
           PartNum
    FROM  agr_reruns_tmp
    GROUP BY Gage_ID, 
             PartNum
    ORDER BY Gage_ID;    

END;
