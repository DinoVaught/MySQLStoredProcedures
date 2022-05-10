DROP PROCEDURE IF EXISTS mes.gage_maint_color_set;
CREATE PROCEDURE mes.gage_maint_color_set(IN GageID varchar(10),
                                          IN state varchar(30))
BEGIN

-- This procedure gets the state or phase that a (maintenance event) is currently in.  

-- A (maintenance event) is different than (calibration maintenance). 
-- A (maintenance event) can occur at any time and is not scheduled. 
-- A (calibration maintenance) occurs at fixed intervals (# parts) and is scheduled in a sense


--  call debug_msg_log('gage_maint_color_set', UCASE(state), '');

  UPDATE mes.gage_states
  SET maint_state = UCASE(state),
  maint_state_last_update_date = SYSDATE()
  WHERE UCASE(Gage_ID) = UCASE(GageID);

END;