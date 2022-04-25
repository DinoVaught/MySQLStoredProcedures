DROP PROCEDURE IF EXISTS mes.GetAGR_Data_By_Day;
CREATE PROCEDURE mes.`GetAGR_Data_By_Day`(IN qryDate varchar(20))
BEGIN
	
-- C:\Users\rvaught\source\repos\Gages\Database\AGR
-- CALL debug_msg_log('GetAGR_Data_By_Day', start_date, end_date);

	  DECLARE start_date VARCHAR(50);
	  DECLARE end_date VARCHAR(50);	
	
    SET start_date = CONCAT(SUBDATE(qryDate, INTERVAL 1 DAY), ' 22:59:00');
    SET end_date = CONCAT(qryDate, ' 23:01:00');
  
		SELECT  
		   Start_Time,
		   End_Time,
		   Gage_ID,
		   CASE WHEN DATE_FORMAT(End_Time, '%H:%i:') BETWEEN '06:55:00' AND '07:05:00' THEN '3'
				WHEN DATE_FORMAT(End_Time, '%H:%i:') BETWEEN '14:55:00' AND '15:05:00' THEN '1'
				WHEN DATE_FORMAT(End_Time, '%H:%i:') BETWEEN '22:55:00' AND '23:05:00' THEN '2'      
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
		AND Start_Time BETWEEN start_date AND end_date
		AND End_Time < end_date
    -- AND Start_Time BETWEEN '2022-4-20 22:59:00' AND '2022-4-21 23:01:00'
    -- AND End_Time < '2022-4-21 23:01:00'    
		ORDER BY Gage_ID, Start_Time;
	END;

