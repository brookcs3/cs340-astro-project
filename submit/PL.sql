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



-- ========================================================
-- PLAYERS
-- ========================================================

DROP PROCEDURE IF EXISTS sp_select_all_players;
DELIMITER //
CREATE PROCEDURE sp_select_all_players()
BEGIN
    SELECT playerID, displayName, country
    FROM Players
    ORDER BY playerID;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_select_player_by_id;
DELIMITER //
CREATE PROCEDURE sp_select_player_by_id(IN p_playerID INT)
BEGIN
    SELECT playerID, displayName, country
    FROM Players
    WHERE playerID = p_playerID;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_insert_player;
DELIMITER //
CREATE PROCEDURE sp_insert_player(IN p_displayName varchar(100), IN p_country varchar(100))
BEGIN
    INSERT INTO Players (displayName, country)
    VALUES (p_displayName, p_country);
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_update_player;
DELIMITER //
CREATE PROCEDURE sp_update_player(IN p_playerID INT, IN p_displayName varchar(100), IN p_country varchar(100))
BEGIN
    UPDATE Players
    SET displayName = p_displayName,
        country = p_country
    WHERE playerID = p_playerID;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_delete_player;
DELIMITER //
CREATE PROCEDURE sp_delete_player(IN p_playerID INT)
BEGIN
    DELETE FROM Players WHERE playerID = p_playerID;
END //
DELIMITER ;


-- ========================================================
-- GAMES
-- ========================================================

DROP PROCEDURE IF EXISTS sp_select_all_games;
DELIMITER //
CREATE PROCEDURE sp_select_all_games()
BEGIN
    SELECT gameID, title, releaseYear, developer
    FROM Games
    ORDER BY gameID;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_select_game_by_id;
DELIMITER //
CREATE PROCEDURE sp_select_game_by_id(IN p_gameID INT)
BEGIN
    SELECT gameID, title, releaseYear, developer
    FROM Games
    WHERE gameID = p_gameID
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_insert_game;
DELIMITER //
CREATE PROCEDURE sp_insert_game(IN p_title varchar(255), IN p_releaseYear INT, IN p_developer varchar(255))
BEGIN
    INSERT INTO Games (title, releaseYear, developer)
    VALUES (p_title, p_releaseYear, p_developer);
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_update_game;
DELIMITER //
CREATE PROCEDURE sp_update_game(IN p_gameID INT, IN p_title varchar(255), IN p_releaseYear INT, IN p_developer varchar(255))
BEGIN
    UPDATE Games
    SET title = p_title,
        releaseYear = p_releaseYear,
        developer = p_developer
    WHERE gameID = p_gameID;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_delete_game;
DELIMITER //
CREATE PROCEDURE sp_delete_game(IN p_gameID INT)
BEGIN
    DELETE FROM Games WHERE gameID = p_gameID;
END //
DELIMITER ;

-- ========================================================
-- PLATFORMS
-- ========================================================

DROP PROCEDURE IF EXISTS sp_select_all_platforms;
DELIMITER //
CREATE PROCEDURE sp_select_all_platforms()
BEGIN
    SELECT platformID, name
    FROM Platforms
    ORDER BY platformID;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_select_platform_by_id;
DELIMITER //
CREATE PROCEDURE sp_select_platform_by_id(IN p_platformID INT)
BEGIN
    SELECT platformID, name
    FROM Platforms
    WHERE platformID = p_platformID;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_insert_platform;
DELIMITER //
CREATE PROCEDURE sp_insert_platform(IN p_name varchar(255))
BEGIN
    INSERT INTO Platforms (name)
    VALUES (p_name);
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_update_platform;
DELIMITER //
CREATE PROCEDURE sp_update_platform(IN p_platformID INT, IN p_name varchar(255))
BEGIN
    UPDATE Platforms
    SET name = p_name
    WHERE platformID = p_platformID;
END //


DROP PROCEDURE IF EXISTS sp_delete_platform;
DELIMITER //
CREATE PROCEDURE sp_delete_platform(IN p_platformID INT)
BEGIN
    DELETE FROM Platforms WHERE platformID = p_platformID;
END //
DELIMITER ;


-- ========================================================
-- RUN CATEGORIES
-- ========================================================

DROP PROCEDURE IF EXISTS sp_select_all_run_categories;
DELIMITER //
CREATE PROCEDURE sp_select_all_run_categories()
BEGIN
    SELECT rc.runCategoryID, rc.name, rc.ruleset, rc.gameID, g.title AS gameTitle
    FROM RunCategories rc
    INNER JOIN Games g ON rc.gameID = g.gameID
    ORDER BY rc.runCategoryID;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_select_run_category_by_id;
DELIMITER //
CREATE PROCEDURE sp_select_run_category_by_id(IN p_runCategoryID INT)
BEGIN
    SELECT rc.runCategoryID, rc.name, rc.ruleset, rc.gameID, g.title AS gameTitle
    FROM RunCategories rc
    INNER JOIN Games g ON rc.gameID = g.gameID
    WHERE rc.runCategoryID = p_runCategoryID;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_select_all_games_for_run_category;
DELIMITER //
CREATE PROCEDURE sp_select_all_games_for_run_category()
BEGIN
    SELECT gameID, title FROM Games ORDER BY title;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_insert_run_category;
DELIMITER //
CREATE PROCEDURE sp_insert_run_category(IN p_name varchar(255), IN p_ruleset text, IN p_gameID INT)
BEGIN
    INSERT INTO RunCategories (name, ruleset, gameID)
    VALUES (p_name, p_ruleset, p_gameID);
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_update_run_category;
DELIMITER //
CREATE PROCEDURE sp_update_run_category(IN p_runCategoryID INT, IN p_name varchar(255), IN p_ruleset text, IN p_gameID INT)
BEGIN
    UPDATE RunCategories
    SET name = p_name,
        ruleset = p_ruleset,
        gameID = p_gameID
    WHERE runCategoryID = p_runCategoryID;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_delete_run_category;
DELIMITER //
CREATE PROCEDURE sp_delete_run_category(IN p_runCategoryID INT)
BEGIN
    DELETE FROM RunCategories WHERE runCategoryID = p_runCategoryID;
END //
DELIMITER ;


-- ========================================================
-- RUN SUBMISSIONS
-- ========================================================

DROP PROCEDURE IF EXISTS sp_select_all_run_submissions;
DELIMITER //
CREATE PROCEDURE sp_select_all_run_submissions()
BEGIN
    SELECT rs.runSubmissionID, rs.runTime, rs.submissionDate, rs.verified,
           rs.verifiedDate, rs.videoLink,
           rs.playerID, p.displayName AS playerName,
           rs.gameID, g.title AS gameTitle,
           rs.platformID, pl.name AS platformName,
           rs.runCategoryID, rc.name AS categoryName
    FROM RunSubmissions rs
    LEFT JOIN Players p ON rs.playerID = p.playerID
    INNER JOIN Games g ON rs.gameID = g.gameID
    INNER JOIN Platforms pl ON rs.platformID = pl.platformID
    INNER JOIN RunCategories rc ON rs.runCategoryID = rc.runCategoryID
    ORDER BY rs.runSubmissionID;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_select_run_submission_by_id;
DELIMITER //
CREATE PROCEDURE sp_select_run_submission_by_id(IN p_runSubmissionID INT)
BEGIN
    SELECT rs.runSubmissionID, rs.runTime, rs.submissionDate, rs.verified,
           rs.verifiedDate, rs.videoLink,
           rs.playerID, rs.gameID, rs.platformID, rs.runCategoryID
    FROM RunSubmissions rs
    WHERE rs.runSubmissionID = p_runSubmissionID;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_select_all_players_for_run_submission;
DELIMITER //
CREATE PROCEDURE sp_select_all_players_for_run_submission()
BEGIN
    SELECT playerID, displayName FROM Players ORDER BY displayName;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_select_all_games_for_run_submission;
DELIMITER //
CREATE PROCEDURE sp_select_all_games_for_run_submission()
BEGIN
    SELECT gameID, title FROM Games ORDER BY title;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_select_all_platforms_for_run_submission;
DELIMITER //
CREATE PROCEDURE sp_select_all_platforms_for_run_submission()
BEGIN
    SELECT platformID, name FROM Platforms ORDER BY name;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_select_all_categories_for_run_submission;
DELIMITER //
CREATE PROCEDURE sp_select_all_categories_for_run_submission()
BEGIN
    SELECT rc.runCategoryID, rc.name, g.title AS gameTitle
    FROM RunCategories rc
    INNER JOIN Games g ON rc.gameID = g.gameID
    ORDER BY g.title, rc.name;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_insert_run_submission;
DELIMITER //
CREATE PROCEDURE sp_insert_run_submission(
    IN p_runTime TIME,
    IN p_submissionDate DATE,
    IN p_verified BOOLEAN,
    IN p_verifiedDate DATE,
    IN p_playerID INT,
    IN p_gameID INT,
    IN p_platformID INT,
    IN p_runCategoryID INT,
    IN p_videoLink VARCHAR(255)
)
BEGIN
    INSERT INTO RunSubmissions (runTime, submissionDate, verified, verifiedDate,
                                playerID, gameID, platformID, runCategoryID, videoLink)
    VALUES (p_runTime, p_submissionDate, p_verified, p_verifiedDate,
            p_playerID, p_gameID, p_platformID, p_runCategoryID, p_videoLink);
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_update_run_submission;
DELIMITER //
CREATE PROCEDURE sp_update_run_submission(
    IN p_runSubmissionID INT,
    IN p_runTime TIME,
    IN p_submissionDate DATE,
    IN p_verified BOOLEAN,
    IN p_verifiedDate DATE,
    IN p_playerID INT,
    IN p_gameID INT,
    IN p_platformID INT,
    IN p_runCategoryID INT,
    IN p_videoLink VARCHAR(255)
)
BEGIN
    UPDATE RunSubmissions
    SET runTime = p_runTime,
        submissionDate = p_submissionDate,
        verified = p_verified,
        verifiedDate = p_verifiedDate,
        playerID = p_playerID,
        gameID = p_gameID,
        platformID = p_platformID,
        runCategoryID = p_runCategoryID,
        videoLink = p_videoLink
    WHERE runSubmissionID = p_runSubmissionID;
END //
DELIMITER ;


drop PROCEDURE IF EXISTS sp_set_run_submission_player_to_null;
DELIMITER //
CREATE PROCEDURE sp_set_run_submission_player_to_null(IN p_runSubmissionID INT)
BEGIN
    UPDATE RunSubmissions
    SET playerID = NULL
    WHERE runSubmissionID = p_runSubmissionID;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_delete_run_submission;
DELIMITER //
CREATE PROCEDURE sp_delete_run_submission(IN p_runSubmissionID INT)
BEGIN
    DELETE FROM RunSubmissions WHERE runSubmissionID = p_runSubmissionID;
END //


-- ========================================================
-- GAMES ON PLATFORMS (M:N Intersection Table)
-- ========================================================

DROP PROCEDURE IF EXISTS sp_select_all_games_on_platforms;
DELIMITER //
CREATE PROCEDURE sp_select_all_games_on_platforms()
BEGIN
    SELECT gop.gameOnPlatformID, gop.gameID, gop.platformID,
           g.title AS gameTitle, p.name AS platformName
    FROM GamesOnPlatforms gop
    INNER JOIN Games g ON gop.gameID = g.gameID
    INNER JOIN Platforms p ON gop.platformID = p.platformID
    ORDER BY g.title, p.name;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_select_all_games_for_platform_association;
DELIMITER //
CREATE PROCEDURE sp_select_all_games_for_platform_association()
BEGIN
    SELECT gameID, title FROM Games ORDER BY title;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_select_all_platforms_for_platform_association;
DELIMITER //
CREATE PROCEDURE sp_select_all_platforms_for_platform_association()
BEGIN
    SELECT platformID, name FROM Platforms ORDER BY name;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_insert_game_on_platform;
DELIMITER //
CREATE PROCEDURE sp_insert_game_on_platform(IN p_gameID INT, IN p_platformID INT)
BEGIN
    INSERT INTO GamesOnPlatforms (gameID, platformID)
    VALUES (p_gameID, p_platformID);
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_delete_game_on_platform;
DELIMITER //
CREATE PROCEDURE sp_delete_game_on_platform(IN p_gameOnPlatformID INT)
BEGIN
    DELETE FROM GamesOnPlatforms WHERE gameOnPlatformID = p_gameOnPlatformID;
END //
DELIMITER ;