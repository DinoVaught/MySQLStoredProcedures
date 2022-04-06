DROP PROCEDURE IF EXISTS mes.agr_count_start_red_tote;
CREATE PROCEDURE mes.`agr_count_start_red_tote`(IN MachTotalStart int(10),
                                                IN GageID varchar(10),
                                                IN StartSTN_1 int(10),
                                                IN StartSTN_2 int(10),
                                                IN StartSTN_3 int(10),
                                                IN StartSTN_4 int(10),
                                                IN StartSTN_5 int(10),
                                                IN StartSTN_6 int(10))
BEGIN

	CALL agr_count_start_tote(MachTotalStart,
                            GageID,
                            'red tote',
                            StartSTN_1,
                            StartSTN_2,
                            StartSTN_3,
                            StartSTN_4,
                            StartSTN_5,
                            StartSTN_6);
END;

