DROP PROCEDURE IF EXISTS mes.set_tote_as_rerun;

CREATE PROCEDURE mes.set_tote_as_rerun(IN tote_id INT(11))
BEGIN
  UPDATE mes.skid_parts
     SET tote_reran = 'Y'
   WHERE ( skid_parts.ndx = tote_id);
END;
