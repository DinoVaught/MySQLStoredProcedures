DROP PROCEDURE IF EXISTS mes.starved_state_get;
CREATE PROCEDURE mes.`starved_state_get`()
BEGIN
	
  SELECT Gage_ID,       
         TIMESTAMPDIFF(SECOND, LightCurtainLastToggle, SYSDATE()) AS secs
  FROM mes.gage_states
  ORDER BY Gage_ID;

END;

