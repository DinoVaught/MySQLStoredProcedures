DROP PROCEDURE IF EXISTS mes.GetAGR_Data;
CREATE PROCEDURE mes.`GetAGR_Data`()
BEGIN
    SELECT Start_Time,
           End_Time, 
           CASE WHEN DATE_FORMAT(End_Time, '%H:%i:') BETWEEN '06:55:00' AND '07:05:00' THEN '3'
                WHEN DATE_FORMAT(End_Time, '%H:%i:') BETWEEN '14:55:00' AND '15:05:00' THEN '1'
                WHEN DATE_FORMAT(End_Time, '%H:%i:') BETWEEN '22:55:00' AND '23:05:00' THEN '2'      
           END AS 'shift',        
           Gage_ID,
           IFNULL(Hydromat, 'NA') Hydro,
           IFNULL(wip_id, 'NA') WIP,
           IFNULL(Heat, 'NA') Heat,
           IFNULL(PartNum, 'NA') Part,
           IFNULL(Skid_ID, 'NA') Skid,
           IFNULL(Operator, 'NA') Emp_ID,  
           (End_STN_1 - Start_STN_1) ST_1,
           (End_STN_2 - Start_STN_2) ST_2,
           (End_STN_3 - Start_STN_3) ST_3,
           (End_STN_4 - Start_STN_4) ST_4,
           (End_STN_5 - Start_STN_5) ST_5,
           (End_STN_6 - Start_STN_6) ST_6,
           (Mach_Total_End - Mach_Total_Start) + (Reject_Total_End - Reject_Total_Start) Total,
           (Reject_Total_End - Reject_Total_Start) AGR,
           (Mach_Total_End - Mach_Total_Start) Net
    FROM mes.agr_counts
    WHERE End_Time IS NOT NULL
    AND RecordType = 'shift'
    AND Start_Time > (SUBDATE(CURDATE(), INTERVAL 30 DAY))
    AND date(Start_Time) <= CURDATE()
    AND End_STN_1 >= Start_STN_1
    AND End_STN_2 >= Start_STN_2
    AND End_STN_3 >= Start_STN_3
    AND End_STN_4 >= Start_STN_4
    AND End_STN_5 >= Start_STN_5
    AND End_STN_6 >= Start_STN_6
    ORDER by Gage_ID ASC, Start_Time ASC;
END;

