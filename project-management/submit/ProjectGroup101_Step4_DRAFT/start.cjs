const { execSync } = require('child_process');
const { spawn } = require('child_process');

process.env.MYSQL_HOST = 'classmysql.engr.oregonstate.edu';
process.env.MYSQL_USER = 'cs340_brooksc3';
process.env.MYSQL_PASSWORD = '3434';
process.env.MYSQL_DATABASE = 'cs340_brooksc3';
process.env.HOST = '0.0.0.0';
process.env.PORT = '8742';

import('./dist/server/entry.mjs');
