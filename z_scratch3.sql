		SELECT  
		   Start_Time,
		   End_Time,
		   Gage_ID,
       SUM(End_STN_1 - Start_STN_1) ST_1,
		   SUM(End_STN_2 - Start_STN_2) ST_2,
		   SUM(End_STN_3 - Start_STN_3) ST_3,
		   SUM(End_STN_4 - Start_STN_4) ST_4,
		   SUM(End_STN_5 - Start_STN_5) ST_5,
		   SUM(End_STN_6 - Start_STN_6) ST_6, 
		   SUM(Mach_Total_End - Mach_Total_Start) + (Reject_Total_End - Reject_Total_Start) Total,
		   SUM(Reject_Total_End - Reject_Total_Start) AGR,
		   SUM(Mach_Total_End - Mach_Total_Start) Net,
		   PartNum
		FROM agr_counts
		WHERE End_time IS NOT NULL
		AND RecordType = 'shift'
-- 		AND Start_Time BETWEEN start_date AND end_date
-- 		AND End_Time < end_date
     AND Start_Time BETWEEN '2022-6-21 22:59:00' AND '2022-6-22 23:01:00'
     AND End_Time < '2022-6-22 23:01:00'    
     Group by Gage_ID
		ORDER BY Gage_ID, Start_Time;