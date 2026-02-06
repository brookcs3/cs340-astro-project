-- CS340 Project Step 2 - Group 101
-- Cameron Brooks & Brayden Plumb
-- Data Definition Queries (DDL) and Sample Data
--
-- Northern Oregon Speedrunners Association Database
-- Tracks speedrun submissions, players, games, categories, and platforms.

SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

-- --------------------------------------------------------
-- Table: Players
-- Description: A speedrunner participant that can speedrun various games.
-- --------------------------------------------------------
DROP TABLE IF EXISTS Players;
CREATE TABLE Players (
    playerID int NOT NULL AUTO_INCREMENT,
    displayName varchar(100) NOT NULL UNIQUE,
    country varchar(100),
    PRIMARY KEY (playerID)
);

-- --------------------------------------------------------
-- Table: Games
-- Description: A video game that is able to be speedrun.
-- --------------------------------------------------------
DROP TABLE IF EXISTS Games;
CREATE TABLE Games (
    gameID int NOT NULL AUTO_INCREMENT,
    title varchar(255) NOT NULL,
    releaseYear year,
    developer varchar(255),
    PRIMARY KEY (gameID)
);

-- --------------------------------------------------------
-- Table: Platforms
-- Description: The hardware or environment a game can be played on.
-- --------------------------------------------------------
DROP TABLE IF EXISTS Platforms;
CREATE TABLE Platforms (
    platformID int NOT NULL AUTO_INCREMENT,
    name varchar(100) NOT NULL UNIQUE,
    PRIMARY KEY (platformID)
);

-- --------------------------------------------------------
-- Table: RunCategories
-- Description: A speedrun submission type which different games provide.
--              Each category belongs to exactly one game (1:M from Games).
-- --------------------------------------------------------
DROP TABLE IF EXISTS RunCategories;
CREATE TABLE RunCategories (
    runCategoryID int NOT NULL AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    ruleset text,
    gameID int NOT NULL,
    PRIMARY KEY (runCategoryID),
    FOREIGN KEY (gameID) REFERENCES Games(gameID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- --------------------------------------------------------
-- Table: RunSubmissions
-- Description: A specific speedrun record with all information about
--              that speedrun attempt. Central entity linking Players,
--              Games, Platforms, and RunCategories.
-- --------------------------------------------------------
DROP TABLE IF EXISTS RunSubmissions;
CREATE TABLE RunSubmissions (
    runSubmissionID int NOT NULL AUTO_INCREMENT,
    runTime time(3) NOT NULL,
    submissionDate date NOT NULL,
    verified boolean DEFAULT FALSE,
    verifiedDate date,
    playerID int NOT NULL,
    gameID int NOT NULL,
    platformID int NOT NULL,
    runCategoryID int NOT NULL,
    videoLink varchar(2048),
    PRIMARY KEY (runSubmissionID),
    FOREIGN KEY (playerID) REFERENCES Players(playerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (gameID) REFERENCES Games(gameID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (platformID) REFERENCES Platforms(platformID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (runCategoryID) REFERENCES RunCategories(runCategoryID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- --------------------------------------------------------
-- Table: GamesOnPlatforms (Intersection Table)
-- Description: Tracks which games are available on which platforms (M:N).
-- --------------------------------------------------------
DROP TABLE IF EXISTS GamesOnPlatforms;
CREATE TABLE GamesOnPlatforms (
    gameOnPlatformID int NOT NULL AUTO_INCREMENT,
    gameID int NOT NULL,
    platformID int NOT NULL,
    PRIMARY KEY (gameOnPlatformID),
    UNIQUE (gameID, platformID),
    FOREIGN KEY (gameID) REFERENCES Games(gameID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (platformID) REFERENCES Platforms(platformID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ========================================================
-- SAMPLE DATA
-- ========================================================

-- --------------------------------------------------------
-- Insert Players (5 rows)
-- --------------------------------------------------------
INSERT INTO Players (displayName, country)
VALUES
    ('SpeedDemon42', 'United States'),
    ('PixelRunner', 'Canada'),
    ('GlitchHunter', 'United States'),
    ('NightOwlPlays', 'Japan'),
    ('TurboTina', 'United Kingdom');

-- --------------------------------------------------------
-- Insert Games (4 rows)
-- --------------------------------------------------------
INSERT INTO Games (title, releaseYear, developer)
VALUES
    ('Super Mario 64', 1996, 'Nintendo'),
    ('The Legend of Zelda: Ocarina of Time', 1998, 'Nintendo'),
    ('Celeste', 2018, 'Maddy Makes Games'),
    ('Portal', 2007, 'Valve');

-- --------------------------------------------------------
-- Insert Platforms (4 rows)
-- --------------------------------------------------------
INSERT INTO Platforms (name)
VALUES
    ('PC'),
    ('Nintendo 64'),
    ('Nintendo Switch'),
    ('PlayStation 5');

-- --------------------------------------------------------
-- Insert RunCategories (5 rows)
-- Each category belongs to exactly one game.
-- --------------------------------------------------------
INSERT INTO RunCategories (name, ruleset, gameID)
VALUES
    ('Any%', 'Complete the game as fast as possible by any means.', (SELECT gameID FROM Games WHERE title = 'Super Mario 64')),
    ('16 Star', 'Complete the game collecting exactly 16 stars.', (SELECT gameID FROM Games WHERE title = 'Super Mario 64')),
    ('Any%', 'Complete the game as fast as possible by any means.', (SELECT gameID FROM Games WHERE title = 'The Legend of Zelda: Ocarina of Time')),
    ('Any%', 'Complete the game as fast as possible by any means.', (SELECT gameID FROM Games WHERE title = 'Celeste')),
    ('Inbounds', 'Complete all chambers without leaving intended boundaries.', (SELECT gameID FROM Games WHERE title = 'Portal'));

-- --------------------------------------------------------
-- Insert GamesOnPlatforms (7 rows)
-- Demonstrates M:N: one game on many platforms, one platform hosting many games.
-- --------------------------------------------------------
INSERT INTO GamesOnPlatforms (gameID, platformID)
VALUES
    ((SELECT gameID FROM Games WHERE title = 'Super Mario 64'), (SELECT platformID FROM Platforms WHERE name = 'Nintendo 64')),
    ((SELECT gameID FROM Games WHERE title = 'Super Mario 64'), (SELECT platformID FROM Platforms WHERE name = 'Nintendo Switch')),
    ((SELECT gameID FROM Games WHERE title = 'Super Mario 64'), (SELECT platformID FROM Platforms WHERE name = 'PC')),
    ((SELECT gameID FROM Games WHERE title = 'The Legend of Zelda: Ocarina of Time'), (SELECT platformID FROM Platforms WHERE name = 'Nintendo 64')),
    ((SELECT gameID FROM Games WHERE title = 'The Legend of Zelda: Ocarina of Time'), (SELECT platformID FROM Platforms WHERE name = 'Nintendo Switch')),
    ((SELECT gameID FROM Games WHERE title = 'Celeste'), (SELECT platformID FROM Platforms WHERE name = 'PC')),
    ((SELECT gameID FROM Games WHERE title = 'Portal'), (SELECT platformID FROM Platforms WHERE name = 'PC'));

-- --------------------------------------------------------
-- Insert RunSubmissions (5 rows)
-- Demonstrates 1:M relationships: multiple runs per player, per game, etc.
-- Includes one verified run and one unverified run to show NULL verifiedDate.
-- --------------------------------------------------------
INSERT INTO RunSubmissions (runTime, submissionDate, verified, verifiedDate, playerID, gameID, platformID, runCategoryID, videoLink)
VALUES
    ('00:15:35.230', '2026-01-10', TRUE, '2026-01-11',
        (SELECT playerID FROM Players WHERE displayName = 'SpeedDemon42'),
        (SELECT gameID FROM Games WHERE title = 'Super Mario 64'),
        (SELECT platformID FROM Platforms WHERE name = 'Nintendo 64'),
        (SELECT runCategoryID FROM RunCategories WHERE name = 'Any%' AND gameID = (SELECT gameID FROM Games WHERE title = 'Super Mario 64')),
        'https://youtube.com/example1'),

    ('00:49:12.800', '2026-01-15', TRUE, '2026-01-16',
        (SELECT playerID FROM Players WHERE displayName = 'SpeedDemon42'),
        (SELECT gameID FROM Games WHERE title = 'Super Mario 64'),
        (SELECT platformID FROM Platforms WHERE name = 'Nintendo 64'),
        (SELECT runCategoryID FROM RunCategories WHERE name = '16 Star' AND gameID = (SELECT gameID FROM Games WHERE title = 'Super Mario 64')),
        'https://youtube.com/example2'),

    ('00:18:22.450', '2026-01-20', FALSE, NULL,
        (SELECT playerID FROM Players WHERE displayName = 'PixelRunner'),
        (SELECT gameID FROM Games WHERE title = 'The Legend of Zelda: Ocarina of Time'),
        (SELECT platformID FROM Platforms WHERE name = 'Nintendo Switch'),
        (SELECT runCategoryID FROM RunCategories WHERE name = 'Any%' AND gameID = (SELECT gameID FROM Games WHERE title = 'The Legend of Zelda: Ocarina of Time')),
        'https://twitch.tv/example3'),

    ('00:32:45.110', '2026-02-01', TRUE, '2026-02-02',
        (SELECT playerID FROM Players WHERE displayName = 'GlitchHunter'),
        (SELECT gameID FROM Games WHERE title = 'Celeste'),
        (SELECT platformID FROM Platforms WHERE name = 'PC'),
        (SELECT runCategoryID FROM RunCategories WHERE name = 'Any%' AND gameID = (SELECT gameID FROM Games WHERE title = 'Celeste')),
        NULL),

    ('00:14:08.670', '2026-02-03', FALSE, NULL,
        (SELECT playerID FROM Players WHERE displayName = 'NightOwlPlays'),
        (SELECT gameID FROM Games WHERE title = 'Portal'),
        (SELECT platformID FROM Platforms WHERE name = 'PC'),
        (SELECT runCategoryID FROM RunCategories WHERE name = 'Inbounds' AND gameID = (SELECT gameID FROM Games WHERE title = 'Portal')),
        'https://youtube.com/example5');

SET FOREIGN_KEY_CHECKS=1;
COMMIT;
