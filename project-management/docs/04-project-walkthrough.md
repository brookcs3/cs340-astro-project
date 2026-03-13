# Complete Walkthrough: `players.astro`

Let's go through `src/pages/players.astro` line by line. Once you understand this page, every other page is the same pattern with different fields.

## The Frontmatter (Lines 1–48)

### Imports and Setup (Lines 1–10)

```typescript
---
import Layout from '../layouts/Layout.astro';
import { getConnection } from '../lib/db';

let players: any[] = [];
let error = '';
let message = '';
```

- Import our shared layout (nav bar, styles)
- Import the database connection helper
- Initialize empty arrays/strings that the template will use

### POST Handler (Lines 12–39)

```typescript
if (Astro.request.method === 'POST') {
```

This block **only runs when a form is submitted**. On a normal page visit (GET), this entire block is skipped.

```typescript
  try {
    const form = await Astro.request.formData();
    const action = form.get('action');
    const db = await getConnection();
```

- `Astro.request.formData()` — parses the submitted form
- `form.get('action')` — reads the hidden `action` field to know what to do
- `getConnection()` — opens a database connection

#### INSERT branch (Lines 18–22)

```typescript
    if (action === 'insert') {
      const displayName = form.get('displayName');
      const country = form.get('country') || null;
      await db.execute('INSERT INTO Players (displayName, country) VALUES (?, ?)',
        [displayName, country]);
      message = `Player "${displayName}" added.`;
```

- Reads form values
- `form.get('country') || null` — converts empty string to `null` for the database
- Runs a parameterized INSERT
- Sets the green success message

#### UPDATE branch (Lines 23–28)

```typescript
    } else if (action === 'update') {
      const playerID = form.get('playerID');
      const displayName = form.get('displayName');
      const country = form.get('country') || null;
      await db.execute('UPDATE Players SET displayName = ?, country = ? WHERE playerID = ?',
        [displayName, country, playerID]);
      message = `Player ${playerID} updated.`;
```

Same pattern — read form values, run parameterized UPDATE.

#### DELETE branch (Lines 29–33)

```typescript
    } else if (action === 'delete') {
      const playerID = form.get('playerID');
      await db.execute('DELETE FROM Players WHERE playerID = ?', [playerID]);
      message = `Player ${playerID} deleted.`;
    }
```

Just needs the ID.

#### Cleanup and error handling (Lines 35–39)

```typescript
    await db.end();
  } catch (e: any) {
    error = e.message;
  }
}
```

- Always close the connection
- If anything fails (constraint violation, connection error), catch it and store the error message

### SELECT (Lines 41–48) — Runs on EVERY request

```typescript
try {
  const db = await getConnection();
  const [rows] = await db.execute(
    'SELECT playerID, displayName, country FROM Players ORDER BY playerID'
  );
  players = rows as any[];
  await db.end();
} catch (e: any) {
  error = e.message;
}
---
```

This always runs — after a POST (so you see updated data) or on a GET (normal page load). The `players` array is now populated for the template.

## The Template (Lines 50–142)

### Page wrapper

```astro
<Layout title="Players">
  <h1 class="page-title">Players</h1>
```

Wraps everything in our shared layout. The `title` prop sets the `<title>` tag.

### Feedback messages (Lines 54–55)

```astro
  {message && <p style="color: green; font-weight: bold;">{message}</p>}
  {error && <p style="color: red;">Database error: {error}</p>}
```

Conditional rendering — only shows if `message` or `error` have content.

### Browse table (Lines 58–93)

```astro
  {players.map((player) => (
    <tr>
      <td>{player.playerID}</td>
      <td>{player.displayName}</td>
      <td>{player.country || <span class="null-value">NULL</span>}</td>
```

- `.map()` loops over the players array, creating a `<tr>` for each
- `player.country || <span>NULL</span>` — displays "NULL" styled text when country is null

### Edit button (Line 81)

```astro
<button onclick={`
  document.getElementById('edit-id').value='${player.playerID}';
  document.getElementById('edit-displayName').value='${player.displayName}';
  document.getElementById('edit-country').value='${player.country || ''}';
  document.getElementById('edit-section').scrollIntoView({behavior:'smooth'})
`}>Edit</button>
```

This is client-side JavaScript — when clicked, it fills in the Update form below with the current row's values and scrolls down to it.

### Delete button (Lines 82–86)

```astro
<form method="POST" action="/players" style="display:inline;">
  <input type="hidden" name="action" value="delete" />
  <input type="hidden" name="playerID" value={player.playerID} />
  <button type="submit" class="btn btn-danger btn-sm">Delete</button>
</form>
```

Each delete button is its own tiny form that POSTs back to the same page with `action=delete` and the player's ID.

### Add form (Lines 96–115)

Standard HTML form with `method="POST"`, a hidden `action=insert` field, and input fields for each non-PK column. The `required` attribute on Display Name enforces client-side validation.

### Update form (Lines 118–141)

Same as Add, but with `action=update` and an additional read-only `playerID` field that gets populated by the Edit button's JavaScript.

## The Complete Data Flow

```
User clicks "Add Player" submit
        ↓
Browser sends POST to /players
        ↓
Astro runs frontmatter
        ↓
POST detected → form parsed → action = 'insert'
        ↓
INSERT INTO Players ... executed
        ↓
message = 'Player "Name" added.'
        ↓
SELECT * FROM Players executed (fresh data)
        ↓
Template renders with updated players array + green message
        ↓
HTML sent to browser → user sees the new player in the table
```

## Next Steps

- Read `05-making-changes.md` to learn how to modify pages and add features
