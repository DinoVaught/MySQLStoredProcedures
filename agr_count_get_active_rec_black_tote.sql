DROP PROCEDURE IF EXISTS mes.agr_count_get_active_rec_black_tote;
CREATE PROCEDURE mes.`agr_count_get_active_rec_black_tote`(IN GageID varchar(10))
BEGIN

  SELECT Gage_ID, Reject_Total_Start, Start_STN_1, Start_STN_2, Start_STN_3, Start_STN_4, Start_STN_5, Start_STN_6
    FROM agr_counts
   WHERE End_Time IS NULL
     AND Gage_ID = GageID
     AND RecordType = 'black_tote';
   
END;