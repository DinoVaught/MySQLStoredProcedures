DROP PROCEDURE IF EXISTS mes.starved_state_set;
CREATE PROCEDURE mes.`starved_state_set`(IN gageID varchar(10))
BEGIN
	
  UPDATE mes.gage_states
  SET LightCurtainLastToggle = SYSDATE()
  WHERE Gage_ID = gageID;

END;

