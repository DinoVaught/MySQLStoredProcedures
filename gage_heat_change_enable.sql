DROP PROCEDURE IF EXISTS mes.gage_heat_change_enable;
CREATE PROCEDURE mes.`gage_heat_change_enable`(IN GageID varchar(10),
                                               IN state varchar(1))
BEGIN

--  call debug_msg_log('gage_heat_change_enable', UCASE(state), '');
  
  IF UCASE(state) != 'Y' AND UCASE(state) != 'N' THEN
    SET state = 'N';
  END IF;
  
  UPDATE mes.gage_states
  SET heat_change = UCASE(state),
  last_update_date = SYSDATE()
  WHERE UCASE(Gage_ID) = UCASE(GageID);

END;