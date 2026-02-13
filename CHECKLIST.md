# Step 3 Testing Checklist

Test each operation below while connected to the OSU VPN with the dev server running (`npm run dev`).

## Players (`/players`)
- [x] 1. **Browse** — Loaded /players, all 5 sample players display with IDs, display names, and countries
- [x] 2. **Add** — Inserted "TestPlayer" with country left blank; row appeared as ID 7 with NULL country; green success message shown
- [x] 3. **Update** — Clicked Edit on player 7, changed country from NULL to "Germany"; green "Player 7 updated" message confirmed; table reflects change
- [x] 4. **Delete** — Clicked Delete on TestPlayer (ID 7); green "Player 7 deleted" message; row removed, back to 5 original players

## Games (`/games`)
- [x] 5. **Browse** — Loaded /games, all 4 sample games display with title, release year, and developer columns
- [x] 6. **Add** — Inserted "TestGame" (1986, tiger electronics) as ID 5; also inserted "test123" with NULL releaseYear and NULL developer as ID 6; both NULLs displayed correctly
- [x] 7. **Update** — Clicked Edit on TestGame (ID 5), changed releaseYear from 1986 to 1999; green "Game 5 updated" message confirmed
- [x] 8. **Delete** — Deleted TestGame (ID 5); green "Game 5 deleted" message; table back to original 4 games

## Platforms (`/platforms`)
- [x] 9. **Browse** — Loaded /platforms, 4 sample platforms displayed (PC, Nintendo 64, Nintendo Switch, PlayStation 5)
- [x] 10. **Add** — Inserted "Sega Genesis" as ID 5; green success message; row appeared in table
- [x] 11. **Update** — Clicked Edit on platform 5, renamed "Sega Genesis" to "Sega Mega Drive"; green "Platform 5 updated" confirmed
- [x] 12. **Delete** — Deleted platform 5; green "Platform 5 deleted"; back to 4 original platforms

## Run Categories (`/run-categories`)
- [x] 13. **Browse** — Loaded /run-categories, 5 categories display with Category ID, Name, Game association, and Ruleset text
- [x] 14. **Add** — Inserted "Test%" for Portal with ruleset blank; green success message; row ID 6 appeared with NULL ruleset
- [x] 15. **Update** — Edited category 6 name from "Test%" to "Urin-Stream-Distance(Off Platform IRL)"; green "Run category 6 updated" confirmed
- [x] 16. **Delete** — Deleted category 6 ("Urin-Stream-Distance"); green "Run category 6 deleted"; back to 5 original categories

## Run Submissions (`/run-submissions`)
- [x] 17. **Browse** — Loaded /run-submissions, all 5 sample submissions display with all 11 columns; NULL verifiedDates and videoLinks render correctly
- [x] 18. **Add** — Inserted test run ID 8: GlitchHunter / Celeste / Any% / Nintendo 64 / 00:01:33 / 2026-02-12 / No / NULL verifiedDate / NULL videoLink; green success message
- [x] 19. **Update** — Updated test run (ID 8), confirmed working (no screenshot)
- [x] 20. **Delete** — Deleted test run ID 8; back to 5 original submissions

## Games on Platforms (`/games-on-platforms`)
- [x] 21. **Browse** — Loaded /games-on-platforms, 8 associations display with Association ID, Game title, and Platform name; sorted alphabetically
- [x] 22. **Add** — Added Celeste / Nintendo 64 association (ID 11); green "Game-platform association added" confirmed
- [x] 23. **Remove** — Removed association ID 11 (Celeste / Nintendo 64); green "Association 11 removed"; back to 7 original associations

## NULLable Fields
- [x] 24. **Verify NULL display** — Confirmed: TestPlayer's country showed as "NULL" text in the table, not blank or "undefined"
- [x] 25. **Verify NULL insert** — Confirmed: leaving country blank on Add stored NULL in the database correctly
- [x] 25b. **Verify NULL in other entities** — Confirmed NULLs display correctly in Games (test123: NULL/NULL), Run Categories (Test%: NULL ruleset), Run Submissions (verifiedDate/videoLink NULLs)

## General
- [x] 26. **Success messages** — Green confirmation messages verified on Players Add ("Player TestPlayer added") and Update ("Player 7 updated")
- [x] 27. **Error handling** — Attempted duplicate game-platform insert (Super Mario 64 / PC, already exists); red "Database error: Duplicate entry '3-1' for key 'gameID'" displayed correctly
- [x] 28. **Navigation** — All nav links on homepage confirmed working, each reaches correct entity page
