DROP PROCEDURE IF EXISTS mes.SetAGR_Rec_As_Rerun;
CREATE PROCEDURE mes.`SetAGR_Rec_As_Rerun`(IN rrIndex int)
BEGIN

  UPDATE mes.agr_counts
  SET  RecordType = 're-run'
  WHERE agr_Counts_ndx = rrIndex;

END;
