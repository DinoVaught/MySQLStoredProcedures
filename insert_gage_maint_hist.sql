DROP PROCEDURE IF EXISTS mes.insert_gage_maint_hist;
CREATE PROCEDURE mes.`insert_gage_maint_hist`(IN gage_id varchar(10),
                                              IN current_state varchar(30),
                                              IN pc_name varchar(50))
BEGIN
  
  UPDATE
	  mes.gage_states_maint_hist
	SET
	  ended = SYSDATE(),
    ended_pc_name = pc_name
	WHERE gage = gage_id 
	AND ended IS NULL;
	  
	INSERT INTO mes.gage_states_maint_hist(gage, maint_state, started, started_pc_name)
	VALUES(gage_id, current_state, SYSDATE(), pc_name);
                              
END;
