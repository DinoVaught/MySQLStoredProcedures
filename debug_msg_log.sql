DROP PROCEDURE IF EXISTS mes.debug_msg_log;
CREATE PROCEDURE mes.`debug_msg_log`(IN msgKey varchar(100),
                                     IN message varchar(500),
                                     IN msgSource varchar(100))
BEGIN

	INSERT INTO mes.debug(created, msgID, msg, source)
  VALUES(SYSDATE(), msgKey, message, msgSource);
                
  DELETE FROM mes.debug
  WHERE created < SUBDATE(SYSDATE(), INTERVAL 60 DAY);
                              
END;
