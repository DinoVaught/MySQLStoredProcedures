DROP PROCEDURE IF EXISTS mes.ins_skid_parts_get_tote_tag_ndx;
CREATE PROCEDURE mes.`ins_skid_parts_get_tote_tag_ndx`(IN p_wip_id varchar(45),
                      											           IN p_skid_id int(11),
                      											           IN p_user_id int(11),
                      											           IN p_part_count int(11),
                      											           IN p_is_short tinytext,
                      											           IN p_tote_seq int(11))
BEGIN

	INSERT INTO mes.skid_parts
             (wip_id,
              skid_id,
              `use`,
              t_stamp,
              tote_part_count,
              is_short,
              tote_sequence)
		 VALUES (p_wip_id,  --  p_wip_id,      -- :wip_id,
             p_skid_id,     -- :skid_id,
             p_user_id,     -- :use,             
             SYSDATE(),
             p_part_count,  -- :tote_part_count,
             p_is_short,    -- :is_short,
             p_tote_seq);    -- :tote_sequence)
             -- 'test123');    -- tmp_debug

  SELECT max(ndx) AS ndx_tote_barcode
    FROM mes.skid_parts
   WHERE wip_id = p_wip_id
     AND skid_id = p_skid_id;

END;
