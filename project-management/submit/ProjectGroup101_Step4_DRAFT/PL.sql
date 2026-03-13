-- CS340 Project Step 4 - Group 101
-- Cameron Brooks & Brayden Plumb
-- Programmable Logic (PL) - CUD Stored Procedures
--
-- Northern Oregon Speedrunners Association Database
--
-- This file contains stored procedures for Create, Update, and Delete (CUD)
-- operations. The sp_reset_database procedure is in DDL.sql.

-- ========================================================
-- sp_delete_player_by_name
-- Deletes a player from the Players table by their displayName.
-- Because RunSubmissions.playerID uses ON DELETE SET NULL, deleting
-- a player preserves their submissions but sets playerID to NULL.
-- This is the CUD demo procedure used by the "Delete TurboTina" button.
-- ========================================================
DROP PROCEDURE IF EXISTS sp_delete_player_by_name;

DELIMITER //

CREATE PROCEDURE sp_delete_player_by_name(IN p_displayName varchar(100))
BEGIN
    DELETE FROM Players WHERE displayName = p_displayName;
END //

DELIMITER ;
