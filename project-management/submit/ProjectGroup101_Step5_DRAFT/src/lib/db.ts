// Database connection utility for CS340 Project
// Northern Oregon Speedrunners Association Database

import mysql from 'mysql2/promise';

export async function getConnection() {
  return await mysql.createConnection({
    host: import.meta.env.MYSQL_HOST,
    user: import.meta.env.MYSQL_USER,
    password: import.meta.env.MYSQL_PASSWORD,
    database: import.meta.env.MYSQL_DATABASE,
  });
}
