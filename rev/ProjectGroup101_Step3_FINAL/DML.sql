-- CS340 Project Step 3 - Group 101
-- Cameron Brooks & Brayden Plumb
-- Data Manipulation Queries (DMQ)
--
-- Allows manipulation speedrun submissions, players, games, categories, and platforms
-- using the SELECT, INSERT, UPDATE, DELETE queries.
--
-- -------------------------------------------------------
-- VARIABLE NOTATION:
-- All variables that will be provided by the backend are 
-- denoted using the @variableNameInput format.
-- Example: @displayNameInput, @playerIDInput, etc.
-- -------------------------------------------------------


-- ------------------------
-- PLAYERS
-- ------------------------

-- SELECT all Players
SELECT playerID, displayName, country
FROM Players
ORDER BY displayName ASC;

-- SELECT single Player by ID
SELECT playerID, displayName, country
FROM Players
WHERE playerID = @playerIDInput;

-- INSERT new Player
INSERT INTO Players (displayName, country)
VALUES (@displayNameInput, @countryInput);

-- UPDATE Player
UPDATE Players
SET displayName = @displayNameInput,
    country = @countryInput
WHERE playerID = @playerIDInput;

-- DELETE Player
DELETE FROM Players
WHERE playerID = @playerIDInput;




-- ------------------------
-- GAMES
-- ------------------------

-- SELECT all Games
SELECT gameID, title, releaseYear, developer
FROM Games
ORDER BY title ASC;

-- SELECT Game by ID
SELECT gameID, title, releaseYear, developer
FROM Games
WHERE gameID = @gameIDInput;

-- INSERT new Game
INSERT INTO Games (title, releaseYear, developer)
VALUES (@titleInput, @releaseYearInput, @developerInput);

-- UPDATE Game
UPDATE Games
SET title = @titleInput,
    releaseYear = @releaseYearInput,
    developer = @developerInput
WHERE gameID = @gameIDInput;

-- DELETE Game
DELETE FROM Games
WHERE gameID = @gameIDInput;




-- ------------------------
-- RUN CATEGORIES
-- ------------------------

-- SELECT all RunCategories with associated Game title
SELECT rc.runCategoryID, rc.name, rc.ruleset, g.title
FROM RunCategories rc
INNER JOIN Games g ON rc.gameID = g.gameID
ORDER BY g.title, rc.name;


-- INSERT new RunCategory
INSERT INTO RunCategories (name, ruleset, gameID)
VALUES (@nameInput, @rulesetInput, @gameIDFromDropdownInput);


-- UPDATE RunCategory
UPDATE RunCategories
SET name = @nameInput,
    ruleset = @rulesetInput,
    gameID = @gameIDFromDropdownInput
WHERE runCategoryID = @runCategoryIDInput;


-- DELETE RunCategory
DELETE FROM RunCategories
WHERE runCategoryID = @runCategoryIDInput;




-- ------------------------
-- PLATFORMS
-- ------------------------

-- SELECT all Platforms
SELECT platformID, name
FROM Platforms
ORDER BY name ASC;


-- INSERT new Platform
INSERT INTO Platforms (name)
VALUES (@platformNameInput);


-- UPDATE Platform
UPDATE Platforms
SET name = @platformNameInput
WHERE platformID = @platformIDInput;


-- DELETE Platform
DELETE FROM Platforms
WHERE platformID = @platformIDInput;




-- ------------------------
-- RUN SUBMISSIONS
-- ------------------------

-- SELECT all RunSubmissions with joined data
SELECT rs.runSubmissionID,
       rs.runTime,
       rs.submissionDate,
       rs.verified,
       rs.verifiedDate,
       rs.videoLink,
       p.displayName,
       g.title,
       pl.name AS platformName,
       rc.name AS categoryName
FROM RunSubmissions rs
INNER JOIN Players p ON rs.playerID = p.playerID
INNER JOIN Games g ON rs.gameID = g.gameID
INNER JOIN Platforms pl ON rs.platformID = pl.platformID
INNER JOIN RunCategories rc ON rs.runCategoryID = rc.runCategoryID
ORDER BY rs.submissionDate DESC;


-- SELECT RunSubmissions by Player
SELECT *
FROM RunSubmissions
WHERE playerID = @playerIDInput;


-- INSERT new RunSubmission (unverified by default)
INSERT INTO RunSubmissions (runTime, submissionDate, verified, verifiedDate, playerID, gameID, platformID, runCategoryID, videoLink)
VALUES
(@runTimeInput,
 @submissionDateInput,
 FALSE,
 NULL,
 @playerIDFromDropdownInput,
 @gameIDFromDropdownInput,
 @platformIDFromDropdownInput,
 @runCategoryIDFromDropdownInput,
 @videoLinkInput);


-- UPDATE RunSubmission (admin edits)
UPDATE RunSubmissions
SET runTime = @runTimeInput,
    submissionDate = @submissionDateInput,
    playerID = @playerIDFromDropdownInput,
    gameID = @gameIDFromDropdownInput,
    platformID = @platformIDFromDropdownInput,
    runCategoryID = @runCategoryIDFromDropdownInput,
    videoLink = @videoLinkInput
WHERE runSubmissionID = @runSubmissionIDInput;


-- VERIFY a RunSubmission (admin action)
UPDATE RunSubmissions
SET verified = TRUE,
    verifiedDate = @verifiedDateInput
WHERE runSubmissionID = @runSubmissionIDInput;


-- DELETE RunSubmission
DELETE FROM RunSubmissions
WHERE runSubmissionID = @runSubmissionIDInput;




-- ------------------------
-- GAMES ON PLATFORMS
-- ------------------------

-- SELECT all GamesOnPlatforms with names
SELECT gop.gameOnPlatformID,
       g.title,
       p.name AS platformName
FROM GamesOnPlatforms gop
INNER JOIN Games g ON gop.gameID = g.gameID
INNER JOIN Platforms p ON gop.platformID = p.platformID
ORDER BY g.title;


-- INSERT new Game-Platform relationship
INSERT INTO GamesOnPlatforms (gameID, platformID)
VALUES (@gameIDFromDropdownInput, @platformIDFromDropdownInput);


-- DELETE Game-Platform relationship
DELETE FROM GamesOnPlatforms
WHERE gameOnPlatformID = @gameOnPlatformIDInput;
