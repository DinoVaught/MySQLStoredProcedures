DROP PROCEDURE IF EXISTS mes.agr_count_stop_red_tote;
CREATE PROCEDURE mes.`agr_count_stop_red_tote`(IN MachTotalStop int(10),
                                                IN GageID varchar(10),
                                                IN StopSTN_1 int(10),
                                                IN StopSTN_2 int(10),
                                                IN StopSTN_3 int(10),
                                                IN StopSTN_4 int(10),
                                                IN StopSTN_5 int(10),
                                                IN StopSTN_6 int(10))
BEGIN

	CALL agr_count_stop_tote(MachTotalStop,
                                GageID,
                                'red tote',
                                StopSTN_1,
                                StopSTN_2,
                                StopSTN_3,
                                StopSTN_4,
                                StopSTN_5,
                                StopSTN_6);
END;

