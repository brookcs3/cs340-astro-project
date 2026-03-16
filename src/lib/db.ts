// CS340 Portfolio Project - Group 101
// Cameron Brooks & Brayden Plumb
// Database connection utility
//
// Citation: Connection pattern from mysql2/promise docs (https://www.npmjs.com/package/mysql2).
// Environment variable loading via Astro's import.meta.env (https://docs.astro.build/en/guides/environment-variables/).

import mysql from 'mysql2/promise';

export async function getConnection() {
  return await mysql.createConnection({
    host: import.meta.env.MYSQL_HOST,
    user: import.meta.env.MYSQL_USER,
    password: import.meta.env.MYSQL_PASSWORD,
    database: import.meta.env.MYSQL_DATABASE,
  });
}
