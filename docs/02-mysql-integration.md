# MySQL Integration in Our Project

This doc explains how our Astro app talks to the MySQL database on the ENGR server.

## The Connection Helper (`src/lib/db.ts`)

```typescript
import mysql from 'mysql2/promise';

export async function getConnection() {
  return await mysql.createConnection({
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,
  });
}
```

That's the whole file. It:
1. Imports `mysql2/promise` (the async/await version of the mysql2 library)
2. Reads credentials from environment variables (set in `.env`)
3. Returns a fresh database connection

## The `.env` File

```
MYSQL_HOST=classmysql.engr.oregonstate.edu
MYSQL_USER=cs340_brooksc3
MYSQL_PASSWORD=3434
MYSQL_DATABASE=cs340_brooksc3
```

This file is **gitignored** — you have to create it yourself after cloning (see SETUP.md).

**Important:** The MySQL server is only reachable from the OSU network. You need to be on the VPN when running locally.

## How We Use It in Pages

In every page's frontmatter, the pattern is:

```typescript
---
import { getConnection } from '../lib/db';

// Get a connection
const db = await getConnection();

// Run a query
const [rows] = await db.execute('SELECT * FROM Players ORDER BY playerID');

// Always close when done
await db.end();
---
```

## Parameterized Queries (Preventing SQL Injection)

**Never** build queries with string concatenation. Always use `?` placeholders:

```typescript
// BAD — SQL injection vulnerability
await db.execute(`SELECT * FROM Players WHERE playerID = ${id}`);

// GOOD — parameterized query
await db.execute('SELECT * FROM Players WHERE playerID = ?', [id]);
```

The `?` gets replaced with the value from the array, and `mysql2` handles escaping.

## Common Query Patterns

### SELECT all rows
```typescript
const [rows] = await db.execute('SELECT playerID, displayName, country FROM Players ORDER BY playerID');
// rows is an array of objects: [{playerID: 1, displayName: "SpeedDemon42", ...}, ...]
```

### SELECT with JOIN (making FKs readable)
```typescript
const [rows] = await db.execute(`
  SELECT rc.runCategoryID, rc.name, rc.ruleset, g.title AS gameTitle
  FROM RunCategories rc
  INNER JOIN Games g ON rc.gameID = g.gameID
  ORDER BY rc.runCategoryID
`);
// Now each row has gameTitle (e.g. "Super Mario 64") instead of just gameID (e.g. 1)
```

### INSERT
```typescript
await db.execute(
  'INSERT INTO Players (displayName, country) VALUES (?, ?)',
  [displayName, country]
);
```

### UPDATE
```typescript
await db.execute(
  'UPDATE Players SET displayName = ?, country = ? WHERE playerID = ?',
  [displayName, country, playerID]
);
```

### DELETE
```typescript
await db.execute('DELETE FROM Players WHERE playerID = ?', [playerID]);
```

## Handling NULL Values

When a form field is left blank, we convert it to `null` before sending to MySQL:

```typescript
const country = form.get('country') || null;
// If the user left country blank, this becomes null
// MySQL stores it as NULL in the database
```

## The DML.sql File

Our `DML.sql` file documents every query the app uses, with `:variableName` syntax to show where backend values get inserted:

```sql
-- The : character denotes variables from the backend
INSERT INTO Players (displayName, country)
VALUES (:displayNameInput, :countryInput);
```

In the actual Astro code, these become `?` placeholders with values from `form.get()`.

## Next Steps

- Read `03-crud-patterns.md` to see how forms and queries work together in a complete page
