# Step 3 Testing Checklist

Test each operation below while connected to the OSU VPN with the dev server running (`npm run dev`).

## Players (`/players`)
- [ ] 1. **Browse** — Page loads and displays all players from the database
- [ ] 2. **Add** — Insert a new player (with and without the optional Country field set to NULL)
- [ ] 3. **Update** — Click Edit on a player row, modify fields, submit update
- [ ] 4. **Delete** — Click Delete on a player row, confirm it's removed

## Games (`/games`)
- [ ] 5. **Browse** — Page loads and displays all games
- [ ] 6. **Add** — Insert a new game (test with releaseYear and developer both NULL)
- [ ] 7. **Update** — Edit an existing game's title, release year, or developer
- [ ] 8. **Delete** — Delete a game

## Platforms (`/platforms`)
- [ ] 9. **Browse** — Page loads and displays all platforms
- [ ] 10. **Add** — Insert a new platform
- [ ] 11. **Update** — Edit an existing platform's name
- [ ] 12. **Delete** — Delete a platform

## Run Categories (`/run-categories`)
- [ ] 13. **Browse** — Page loads showing categories with their associated game
- [ ] 14. **Add** — Insert a new category (test with ruleset as NULL)
- [ ] 15. **Update** — Edit a category's name, game, or ruleset
- [ ] 16. **Delete** — Delete a category

## Run Submissions (`/run-submissions`)
- [ ] 17. **Browse** — Page loads showing all submissions with player, game, platform, category
- [ ] 18. **Add** — Insert a new run submission (test with verifiedDate and videoLink as NULL)
- [ ] 19. **Update** — Click Edit, change fields (e.g. set verified to Yes, add a verifiedDate)
- [ ] 20. **Delete** — Delete a run submission

## Games on Platforms (`/games-on-platforms`)
- [ ] 21. **Browse** — Page loads showing all game-platform associations
- [ ] 22. **Add** — Associate a game with a platform using the dropdowns
- [ ] 23. **Remove** — Remove an association (no update — this is an M:N intersection table)

## NULLable Fields
- [ ] 24. **Verify NULL display** — NULL values show as "NULL" in the table (not blank or "undefined")
- [ ] 25. **Verify NULL insert** — Leaving optional fields blank correctly stores NULL in the database

## General
- [ ] 26. **Success messages** — Green confirmation message appears after each add/update/delete
- [ ] 27. **Error handling** — Red error message appears if a database constraint is violated (e.g. duplicate entry)
- [ ] 28. **Navigation** — All nav links on the homepage work and reach the correct pages
