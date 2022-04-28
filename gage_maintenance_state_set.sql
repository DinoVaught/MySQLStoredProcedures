DROP PROCEDURE IF EXISTS mes.gage_maintenance_state_set;
CREATE PROCEDURE mes.gage_maintenance_state_set(IN GageID varchar(10),
                                                IN state varchar(30))
BEGIN

--  call debug_msg_log('gage_maintenance_state_set', UCASE(state), '');

  UPDATE mes.gage_states
  SET maint_state = UCASE(state),
  maint_state_last_update_date = SYSDATE()
  WHERE UCASE(Gage_ID) = UCASE(GageID);

END;