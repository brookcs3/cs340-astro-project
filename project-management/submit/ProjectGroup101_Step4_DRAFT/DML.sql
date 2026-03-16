-- CS340 Project Step 4 - Group 101
-- Cameron Brooks & Brayden Plumb
-- Data Manipulation Queries (DML)
--
-- Northern Oregon Speedrunners Association Database
--
-- These are the queries that the website uses to let users interact with data.
-- Colon : character is used to denote variables that will have data from the
-- backend programming language.
-- Example: :playerIDInput represents a value passed from the web application.

-- ========================================================
-- PLAYERS
-- ========================================================

-- SELECT: Get all players to display in the Browse Players table
SELECT playerID, displayName, country
FROM Players
ORDER BY playerID;

-- SELECT: Get a single player by ID (for pre-populating the Update form)
SELECT playerID, displayName, country
FROM Players
WHERE playerID = :playerIDInput;

-- INSERT: Add a new player from the Add Player form
-- :displayNameInput and :countryInput come from form fields
INSERT INTO Players (displayName, country)
VALUES (:displayNameInput, :countryInput);

-- UPDATE: Update an existing player from the Update Player form
UPDATE Players
SET displayName = :displayNameInput,
    country = :countryInput
WHERE playerID = :playerIDInput;

-- DELETE: Remove a player from the database
DELETE FROM Players WHERE playerID = :playerIDInput;


-- ========================================================
-- GAMES
-- ========================================================

-- SELECT: Get all games to display in the Browse Games table
SELECT gameID, title, releaseYear, developer
FROM Games
ORDER BY gameID;

-- SELECT: Get a single game by ID (for pre-populating the Update form)
SELECT gameID, title, releaseYear, developer
FROM Games
WHERE gameID = :gameIDInput;

-- INSERT: Add a new game from the Add Game form
INSERT INTO Games (title, releaseYear, developer)
VALUES (:titleInput, :releaseYearInput, :developerInput);

-- UPDATE: Update an existing game from the Update Game form
UPDATE Games
SET title = :titleInput,
    releaseYear = :releaseYearInput,
    developer = :developerInput
WHERE gameID = :gameIDInput;

-- DELETE: Remove a game from the database
DELETE FROM Games WHERE gameID = :gameIDInput;


-- ========================================================
-- PLATFORMS
-- ========================================================

-- SELECT: Get all platforms to display in the Browse Platforms table
SELECT platformID, name
FROM Platforms
ORDER BY platformID;

-- SELECT: Get a single platform by ID (for pre-populating the Update form)
SELECT platformID, name
FROM Platforms
WHERE platformID = :platformIDInput;

-- INSERT: Add a new platform from the Add Platform form
INSERT INTO Platforms (name)
VALUES (:nameInput);

-- UPDATE: Update an existing platform from the Update Platform form
UPDATE Platforms
SET name = :nameInput
WHERE platformID = :platformIDInput;

-- DELETE: Remove a platform from the database
DELETE FROM Platforms WHERE platformID = :platformIDInput;


-- ========================================================
-- RUN CATEGORIES
-- ========================================================

-- SELECT: Get all run categories with their associated game titles
-- for display in the Browse Run Categories table
SELECT rc.runCategoryID, rc.name, rc.ruleset, rc.gameID, g.title AS gameTitle
FROM RunCategories rc
INNER JOIN Games g ON rc.gameID = g.gameID
ORDER BY rc.runCategoryID;

-- SELECT: Get a single run category by ID (for pre-populating the Update form)
SELECT rc.runCategoryID, rc.name, rc.ruleset, rc.gameID, g.title AS gameTitle
FROM RunCategories rc
INNER JOIN Games g ON rc.gameID = g.gameID
WHERE rc.runCategoryID = :runCategoryIDInput;

-- SELECT: Get all games for the Game dropdown in the Add/Update Run Category forms
SELECT gameID, title FROM Games ORDER BY title;

-- INSERT: Add a new run category from the Add Run Category form
INSERT INTO RunCategories (name, ruleset, gameID)
VALUES (:nameInput, :rulesetInput, :gameIDInput);

-- UPDATE: Update an existing run category from the Update Run Category form
UPDATE RunCategories
SET name = :nameInput,
    ruleset = :rulesetInput,
    gameID = :gameIDInput
WHERE runCategoryID = :runCategoryIDInput;

-- DELETE: Remove a run category from the database
DELETE FROM RunCategories WHERE runCategoryID = :runCategoryIDInput;


-- ========================================================
-- RUN SUBMISSIONS
-- ========================================================

-- SELECT: Get all run submissions with associated entity names
-- for display in the Browse Run Submissions table
-- Note: LEFT JOIN on Players because playerID is NULLable (ON DELETE SET NULL).
-- If a player is deleted, the submission is preserved with playerName = NULL.
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

-- SELECT: Get a single run submission by ID (for pre-populating the Update form)
SELECT rs.runSubmissionID, rs.runTime, rs.submissionDate, rs.verified,
       rs.verifiedDate, rs.videoLink,
       rs.playerID, rs.gameID, rs.platformID, rs.runCategoryID
FROM RunSubmissions rs
WHERE rs.runSubmissionID = :runSubmissionIDInput;

-- SELECT: Get all players for the Player dropdown in the Add/Update Run Submission forms
SELECT playerID, displayName FROM Players ORDER BY displayName;

-- SELECT: Get all games for the Game dropdown in the Add/Update Run Submission forms
SELECT gameID, title FROM Games ORDER BY title;

-- SELECT: Get all platforms for the Platform dropdown in the Add/Update Run Submission forms
SELECT platformID, name FROM Platforms ORDER BY name;

-- SELECT: Get all run categories (with game title) for the Category dropdown
-- in the Add/Update Run Submission forms
SELECT rc.runCategoryID, rc.name, g.title AS gameTitle
FROM RunCategories rc
INNER JOIN Games g ON rc.gameID = g.gameID
ORDER BY g.title, rc.name;

-- INSERT: Add a new run submission from the Add Run Submission form
INSERT INTO RunSubmissions (runTime, submissionDate, verified, verifiedDate,
                            playerID, gameID, platformID, runCategoryID, videoLink)
VALUES (:runTimeInput, :submissionDateInput, :verifiedInput, :verifiedDateInput,
        :playerIDInput, :gameIDInput, :platformIDInput, :runCategoryIDInput, :videoLinkInput);

-- UPDATE: Update an existing run submission from the Update Run Submission form
UPDATE RunSubmissions
SET runTime = :runTimeInput,
    submissionDate = :submissionDateInput,
    verified = :verifiedInput,
    verifiedDate = :verifiedDateInput,
    playerID = :playerIDInput,
    gameID = :gameIDInput,
    platformID = :platformIDInput,
    runCategoryID = :runCategoryIDInput,
    videoLink = :videoLinkInput
WHERE runSubmissionID = :runSubmissionIDInput;

-- UPDATE: Set playerID to NULL (disassociate a player from a run submission)
-- This demonstrates the NULLable FK relationship: playerID can be set to NULL
-- either manually via this UPDATE or automatically via ON DELETE SET NULL.
UPDATE RunSubmissions
SET playerID = NULL
WHERE runSubmissionID = :runSubmissionIDInput;

-- DELETE: Remove a run submission from the database
DELETE FROM RunSubmissions WHERE runSubmissionID = :runSubmissionIDInput;


-- ========================================================
-- GAMES ON PLATFORMS (M:N Intersection Table)
-- ========================================================

-- SELECT: Get all game-platform associations with entity names
-- for display in the Browse Games on Platforms table
SELECT gop.gameOnPlatformID, gop.gameID, gop.platformID,
       g.title AS gameTitle, p.name AS platformName
FROM GamesOnPlatforms gop
INNER JOIN Games g ON gop.gameID = g.gameID
INNER JOIN Platforms p ON gop.platformID = p.platformID
ORDER BY g.title, p.name;

-- SELECT: Get all games for the Game dropdown in the Add Association form
SELECT gameID, title FROM Games ORDER BY title;

-- SELECT: Get all platforms for the Platform dropdown in the Add Association form
SELECT platformID, name FROM Platforms ORDER BY name;

-- INSERT: Add a new game-platform association (dis-associate / re-associate)
INSERT INTO GamesOnPlatforms (gameID, platformID)
VALUES (:gameIDInput, :platformIDInput);

-- DELETE: Remove a game-platform association
DELETE FROM GamesOnPlatforms WHERE gameOnPlatformID = :gameOnPlatformIDInput;


-- ========================================================
-- STORED PROCEDURE CALLS (Step 4 & Step 5)
-- ========================================================
-- All CUD operations and SELECTs are now routed through stored procedures.
-- The raw SQL above documents the underlying logic; the CALL statements below
-- are what the Astro pages actually execute.

-- RESET: Restore all tables and sample data (home page)
CALL sp_reset_database();

-- CUD DEMO: Delete a player by name (home page demo button)
CALL sp_delete_player_by_name(:displayNameInput);

-- PLAYERS
CALL sp_select_all_players();
CALL sp_select_player_by_id(:playerIDInput);
CALL sp_insert_player(:displayNameInput, :countryInput);
CALL sp_update_player(:playerIDInput, :displayNameInput, :countryInput);
CALL sp_delete_player(:playerIDInput);

-- GAMES
CALL sp_select_all_games();
CALL sp_select_game_by_id(:gameIDInput);
CALL sp_insert_game(:titleInput, :releaseYearInput, :developerInput);
CALL sp_update_game(:gameIDInput, :titleInput, :releaseYearInput, :developerInput);
CALL sp_delete_game(:gameIDInput);

-- PLATFORMS
CALL sp_select_all_platforms();
CALL sp_select_platform_by_id(:platformIDInput);
CALL sp_insert_platform(:nameInput);
CALL sp_update_platform(:platformIDInput, :nameInput);
CALL sp_delete_platform(:platformIDInput);

-- RUN CATEGORIES
CALL sp_select_all_run_categories();
CALL sp_select_run_category_by_id(:runCategoryIDInput);
CALL sp_select_all_games_for_run_category();
CALL sp_insert_run_category(:nameInput, :rulesetInput, :gameIDInput);
CALL sp_update_run_category(:runCategoryIDInput, :nameInput, :rulesetInput, :gameIDInput);
CALL sp_delete_run_category(:runCategoryIDInput);

-- RUN SUBMISSIONS
CALL sp_select_all_run_submissions();
CALL sp_select_run_submission_by_id(:runSubmissionIDInput);
CALL sp_select_all_players_for_run_submission();
CALL sp_select_all_games_for_run_submission();
CALL sp_select_all_platforms_for_run_submission();
CALL sp_select_all_categories_for_run_submission();
CALL sp_insert_run_submission(:runTimeInput, :submissionDateInput, :verifiedInput,
    :verifiedDateInput, :playerIDInput, :gameIDInput, :platformIDInput,
    :runCategoryIDInput, :videoLinkInput);
CALL sp_update_run_submission(:runSubmissionIDInput, :runTimeInput, :submissionDateInput,
    :verifiedInput, :verifiedDateInput, :playerIDInput, :gameIDInput, :platformIDInput,
    :runCategoryIDInput, :videoLinkInput);
CALL sp_set_run_submission_player_to_null(:runSubmissionIDInput);
CALL sp_delete_run_submission(:runSubmissionIDInput);

-- GAMES ON PLATFORMS (M:N)
CALL sp_select_all_games_on_platforms();
CALL sp_select_all_games_for_platform_association();
CALL sp_select_all_platforms_for_platform_association();
CALL sp_insert_game_on_platform(:gameIDInput, :platformIDInput);
CALL sp_update_game_on_platform(:gameOnPlatformIDInput, :gameIDInput, :platformIDInput);
CALL sp_delete_game_on_platform(:gameOnPlatformIDInput);
