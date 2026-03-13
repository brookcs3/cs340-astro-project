# Making Changes for Step 3 Final

This doc covers what you need to know to make modifications for the Final submission. **Due: Thursday Feb 23 by 11:59pm.**

## What's Already Done (from the Draft)

- [x] Website live at `http://classwork.engr.oregonstate.edu:8742`
- [x] All 6 entity pages with full CRUD (Browse, Add, Update, Delete)
- [x] `DML.sql` with all queries using `:variable` syntax
- [x] `DDL.sql` with CREATE TABLE statements and sample INSERT data
- [x] JOINs making FKs user-friendly (dropdowns show names, not raw IDs)
- [x] ON DELETE CASCADE on all FKs (handles M:M delete without anomalies)
- [x] GamesOnPlatforms intersection table page (Add/Remove associations)
- [x] All 28 testing checklist items passed

## What Still Needs to Be Done for Final

### Code Changes
- [ ] **Add a NULLable FK relationship** — The rubric requires at least one FK that uses `ON DELETE SET NULL` instead of `ON DELETE CASCADE`. See the detailed instructions below.
- [ ] **Rebuild and redeploy** — After any code changes, rebuild and restart on the ENGR server

### PDF / LaTeX Changes
- [ ] **Add verbatim Step 3 Draft peer feedback** — Once we get reviews on Ed Discussion, paste them into the LaTeX document word-for-word
- [ ] **Add "Actions Based on Feedback" section** — For each reviewer comment, describe what we did (or why we chose not to act on it)
- [ ] **Add "Upgrades to Draft" section** — List any design changes we made on our own (e.g., the NULLable FK change)
- [ ] **Fix LaTeX typo** — `\usepackage[margin=1in]{gaeometry}` needs to be `{geometry}`
- [ ] **Fix ERD image reference** — The LaTeX references `ERD.PNG` but the file is actually called `unnamed-3.png`. Either rename the file or update the LaTeX.
- [ ] **Fill in Claude citation prompt** — The Citations section says "TBD" for the Claude prompt. Fill in what we actually asked.
- [ ] **Rename the .tex file** — Should be `ProjectGroup101_Step3_FINAL.tex` for the final

### Packaging & Submission
- [ ] **Create ZIP** — `ProjectGroup101_Step3_FINAL.zip` containing:
  - `ProjectGroup101_Step3_FINAL.pdf`
  - `DML.sql`
  - `DDL.sql`
- [ ] **Upload ZIP to Canvas** — File upload submission
- [ ] **Add URL in Canvas comment** — Paste `http://classwork.engr.oregonstate.edu:8742` as a comment on the submission

## Rubric Highlights (200 points total)

The Final is graded on these criteria (not just completion like the Draft):

| Criteria | What They're Looking For |
|----------|------------------------|
| **PDF content** | Updated outline, ERD, schema, sample data. Verbatim feedback + actions taken. |
| **UI pages** | Every table has a page. Forms for INSERT, UPDATE, DELETE. Clear labels/headers. |
| **SELECT queries** | Each page displays data from its table. JOINs used to show names not IDs. |
| **INSERT** | Can add rows to every table including the M:N intersection table. FK fields use dropdowns. |
| **UPDATE** | Can update rows. At least one UPDATE sets a FK to NULL (NULLable relationship). |
| **DELETE** | Can delete from M:M without anomalies. ON DELETE CASCADE or SET NULL handles it. |
| **DML.sql** | All queries documented with `:variable` syntax. Syntactically correct. |
| **DDL.sql** | Tables, constraints, sample data all present and correct. |
| **NULLable FK** | At least one relationship where a FK can be set to NULL. |

## How to Run the Dev Server

```bash
# Make sure you're on the VPN first
npm run dev
```

Open `http://localhost:8742` in your browser. Changes to `.astro` files hot-reload automatically.

## How to Add a New Field to a Page

Say you want to add a new column to an existing entity:

1. **Update DDL.sql** — add the column to the CREATE TABLE statement
2. **Update the database** — run the ALTER TABLE on phpMyAdmin or re-import the DDL
3. **Update the page's SELECT** — add the column to the query in the frontmatter
4. **Update the browse table** — add a `<th>` and `<td>` for the column
5. **Update the Add form** — add an input field
6. **Update the INSERT query** — add the column and `?` placeholder
7. **Update the Update form** — add an input field
8. **Update the UPDATE query** — add the SET clause
9. **Update DML.sql** — add the column to the documented queries

## How to Add a NULLable FK Relationship

The assignment requires at least one relationship where deleting a parent sets the FK to NULL instead of cascading the delete. Here's how:

### Example: Making playerID NULLable in RunSubmissions

Instead of ON DELETE CASCADE (which deletes all runs when a player is deleted), we could SET NULL (which keeps the runs but removes the player association):

1. **DDL change:**
```sql
-- Change the FK constraint
ALTER TABLE RunSubmissions
DROP FOREIGN KEY fk_runsubmissions_player;

ALTER TABLE RunSubmissions
MODIFY playerID int NULL;

ALTER TABLE RunSubmissions
ADD CONSTRAINT fk_runsubmissions_player
FOREIGN KEY (playerID) REFERENCES Players(playerID)
ON DELETE SET NULL ON UPDATE CASCADE;
```

2. **Page change** — handle NULL playerID in the display:
```astro
<td>{row.playerName || <span class="null-value">NULL</span>}</td>
```

3. **DML.sql change** — document the updated constraint behavior

**Note:** Discuss with Cameron before making this change — it affects the schema.

## Prior Feedback We've Already Addressed

For context, here's what Step 2 reviewers said and how we handled it:

### Step 2 Feedback (4 reviewers: Rebecca Charles, Justin Lee, Ciaran Szwarc, Timothy Birmingham)

| Feedback | Our Response |
|----------|-------------|
| **Create separate Developers table** (Justin, Ciaran, Timothy) | Chose not to. `developer` is a simple attribute — not a full entity. Our normalization analysis shows Games is in 3NF: developer doesn't determine title or releaseYear. Creating a Developers table for 3 unique values adds unnecessary complexity. |
| **Create separate Countries table** (Ciaran, Timothy) | Same reasoning. Country is a simple varchar attribute on Players. A lookup table for 5 values is overengineering. |
| **GamesOnPlatforms: surrogate PK vs composite key** (Rebecca, Ciaran) | Kept the surrogate `gameOnPlatformID`. The UNIQUE constraint on (gameID, platformID) prevents duplicates. The surrogate PK simplifies DELETE operations in the UI. |
| **Schema line overlap / readability** (All reviewers) | Cleaned up the schema and ERD diagrams to reduce line crossings. |
| **int(11) vs int / year(4) vs year** (Timothy) | These are just phpMyAdmin display artifacts. `int` and `int(11)` are identical in MySQL. Same for `year` vs `year(4)`. |
| **videoLink missing from PDF sample data** (Timothy) | Noted it was omitted for space. Included in DDL.sql. |

### Step 1 Feedback (4 reviewers: Kain Sherman, Olivia Choi, Bryant Aragon, Lucas Feldsien)

All Step 1 feedback was addressed in Step 2. See the "Feedback Change Log" section in the LaTeX for the full list (8 items including naming consistency, verifiedDate attribute, numerical scope, etc.)

## How to Modify the LaTeX/PDF

The PDF is built from `ProjectGroup101_Step2_DRAFT.tex` (we should rename it for Step 3). To compile:

1. Edit the `.tex` file
2. Run `pdflatex ProjectGroup101_Step3_FINAL.tex` (or use TeXShop on Mac)
3. Check the output PDF

For the Final, you need to add these sections to the LaTeX:

```latex
\section*{Step 3 Draft Feedback}
\textbf{Reviewers:} [Names of reviewers]

[Paste the verbatim review text here]

\subsection*{Actions Based on Feedback}
\begin{enumerate}
    \item \textbf{[Issue from reviewer]} — [What we did about it]
    \item ...
\end{enumerate}
```

## How to Update DML.sql

The `DML.sql` file uses `:variableName` to represent backend values:

```sql
-- Use : prefix for all variables
INSERT INTO Players (displayName, country)
VALUES (:displayNameInput, :countryInput);
```

If you add a new query to a page, add the matching documented query to `DML.sql`.

## How to Redeploy to the ENGR Server

After pushing changes to GitHub:

```bash
ssh classwork
cd ~/CS340/project
export PATH=~/.nvm/versions/node/v18.20.8/bin:$PATH
git pull origin main
npm install
npm run build
npx forever stopall
npx forever start start.cjs
```

See SETUP.md for the full deployment guide.

## Common Issues

### "Cannot find module" error
Run `npm install` — you probably pulled new dependencies.

### Form submits but nothing happens
Check that your form has:
- `method="POST"`
- A hidden `<input name="action" value="insert/update/delete">`
- The `name` attributes match what the frontmatter expects

### NULL not storing correctly
Make sure you're converting empty strings to null:
```typescript
const value = form.get('fieldName') || null;
```

### Database connection error
- Are you on the VPN?
- Does `.env` exist with correct credentials?
- Is the MySQL server up? (check phpMyAdmin)

### Changes not showing on the ENGR server
Did you rebuild? The production server runs from `dist/` (the build output), not the source files. You need to `npm run build` after changes, then restart forever.

## File Reference

| File | What It Does |
|------|-------------|
| `src/pages/*.astro` | Entity pages with CRUD |
| `src/lib/db.ts` | Database connection helper |
| `src/layouts/Layout.astro` | Shared nav/styles wrapper |
| `astro.config.mjs` | Server config (port, SSR mode) |
| `.env` | Database credentials (gitignored) |
| `DDL.sql` | CREATE TABLE + sample INSERT statements |
| `DML.sql` | Documented queries with `:variable` syntax |
| `start.cjs` | Node wrapper for production (sets env vars) |
| `SETUP.md` | Setup + deployment guide |
| `CHECKLIST.md` | Testing checklist (all 28 items passed) |
