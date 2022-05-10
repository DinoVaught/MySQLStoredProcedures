DROP PROCEDURE IF EXISTS mes.insert_gage_maint_hist;
CREATE PROCEDURE mes.`insert_gage_maint_hist`(IN gage_id varchar(10),
                                              IN current_state varchar(30))
BEGIN
	UPDATE
	  mes.gage_states_maint_hist
	SET
	  ended = SYSDATE()
	WHERE gage = gage_id 
	AND ended IS NULL;
	  
	INSERT INTO mes.gage_states_maint_hist(gage, maint_state, started)
	VALUES(gage_id, current_state, SYSDATE());
                              
END;
