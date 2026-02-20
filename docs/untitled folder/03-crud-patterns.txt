# CRUD Patterns in Our Astro Pages

Every entity page follows the same pattern. Once you understand one, you understand all six.

## The Page Lifecycle

When a user visits `/players`:

1. **GET request** → Astro runs the frontmatter → queries the database → renders the HTML with data
2. User fills out a form and clicks Submit
3. **POST request** → Astro runs the frontmatter again → detects it's a POST → processes the form → runs INSERT/UPDATE/DELETE → then queries fresh data → renders updated HTML

Everything happens on the same page. No separate API routes.

## The Frontmatter Structure

Every page's frontmatter follows this skeleton:

```typescript
---
import Layout from '../layouts/Layout.astro';
import { getConnection } from '../lib/db';

let message = '';
let error = '';

// ====== HANDLE POST (form submissions) ======
if (Astro.request.method === 'POST') {
  try {
    const form = await Astro.request.formData();
    const action = form.get('action'); // 'insert', 'update', or 'delete'
    const db = await getConnection();

    if (action === 'insert') {
      // ... INSERT query
      message = 'Record added.';
    } else if (action === 'update') {
      // ... UPDATE query
      message = 'Record updated.';
    } else if (action === 'delete') {
      // ... DELETE query
      message = 'Record deleted.';
    }

    await db.end();
  } catch (e: any) {
    error = e.message;
  }
}

// ====== FETCH DATA (runs on every request, GET or POST) ======
const db = await getConnection();
const [rows] = await db.execute('SELECT ... FROM ...');
await db.end();
---
```

**Key insight:** The SELECT always runs last, so after an INSERT/UPDATE/DELETE the page immediately shows the updated data.

## The Hidden `action` Field

Every form has a hidden input that tells the server what operation to perform:

```html
<form method="POST">
  <input type="hidden" name="action" value="insert" />
  <!-- ... other fields ... -->
  <button type="submit">Add</button>
</form>
```

The frontmatter checks `form.get('action')` to know which branch to execute.

## Browse (SELECT)

The template section displays data in a table:

```astro
<table>
  <thead>
    <tr>
      <th>Player ID</th>
      <th>Display Name</th>
      <th>Country</th>
      <th>Actions</th>
    </tr>
  </thead>
  <tbody>
    {rows.map((row: any) => (
      <tr>
        <td>{row.playerID}</td>
        <td>{row.displayName}</td>
        <td>{row.country ?? 'NULL'}</td>
        <td>
          <button>Edit</button>
          <form method="POST" style="display:inline;">
            <input type="hidden" name="action" value="delete" />
            <input type="hidden" name="playerID" value={row.playerID} />
            <button type="submit">Delete</button>
          </form>
        </td>
      </tr>
    ))}
  </tbody>
</table>
```

**Note:** `{row.country ?? 'NULL'}` uses the nullish coalescing operator — if country is null, it displays the text "NULL".

## Add (INSERT)

A form with fields for each column (except auto-increment ID):

```html
<h2>Add New Player</h2>
<form method="POST">
  <input type="hidden" name="action" value="insert" />

  <label>Display Name *</label>
  <input type="text" name="displayName" required />

  <label>Country</label>
  <input type="text" name="country" />

  <button type="submit">Add Player</button>
</form>
```

The frontmatter handles it:

```typescript
if (action === 'insert') {
  const displayName = form.get('displayName');
  const country = form.get('country') || null;  // empty string → null
  await db.execute(
    'INSERT INTO Players (displayName, country) VALUES (?, ?)',
    [displayName, country]
  );
  message = `Player "${displayName}" added.`;
}
```

## Update (UPDATE)

Update is trickier because it has two steps:
1. Click "Edit" → the form pre-fills with current values
2. Change values → click "Update"

Our pages use JavaScript to populate an edit form when "Edit" is clicked:

```html
<button onclick={`editPlayer(${row.playerID}, '${row.displayName}', '${row.country || ''}')`}>
  Edit
</button>
```

The edit form:

```html
<form method="POST" id="updateForm" style="display:none;">
  <input type="hidden" name="action" value="update" />
  <input type="hidden" name="playerID" id="editPlayerID" />

  <label>Display Name *</label>
  <input type="text" name="displayName" id="editDisplayName" required />

  <label>Country</label>
  <input type="text" name="country" id="editCountry" />

  <button type="submit">Update</button>
  <button type="button" onclick="cancelEdit()">Cancel</button>
</form>
```

## Delete (DELETE)

Each row has a small inline form with just the ID and a delete button:

```html
<form method="POST" style="display:inline;">
  <input type="hidden" name="action" value="delete" />
  <input type="hidden" name="playerID" value={row.playerID} />
  <button type="submit">Delete</button>
</form>
```

The frontmatter:

```typescript
if (action === 'delete') {
  const playerID = form.get('playerID');
  await db.execute('DELETE FROM Players WHERE playerID = ?', [playerID]);
  message = `Player ${playerID} deleted.`;
}
```

## Success/Error Messages

At the top of the template, we show feedback:

```astro
{message && <p style="color: green; font-weight: bold;">{message}</p>}
{error && <p style="color: red; font-weight: bold;">Database error: {error}</p>}
```

## Dropdown Menus for Foreign Keys

When a form needs a FK (like selecting a Game for a Run Category), we query the related table and build a `<select>`:

```typescript
// In frontmatter
const [games] = await db.execute('SELECT gameID, title FROM Games ORDER BY title');
```

```html
<!-- In template -->
<select name="gameID" required>
  <option value="">-- Select a Game --</option>
  {games.map((g: any) => (
    <option value={g.gameID}>{g.title}</option>
  ))}
</select>
```

This is the "JOINs used to make FKs user-friendly" requirement — users see game titles, not raw IDs.

## The Intersection Table (Games on Platforms)

`games-on-platforms.astro` is slightly different:
- **No Update** — you just add or remove associations
- **Add** uses two dropdowns (Game + Platform)
- **Delete** removes the association row

## Next Steps

- Read `04-project-walkthrough.md` for a line-by-line walkthrough of `players.astro`
