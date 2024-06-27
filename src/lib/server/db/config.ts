import { DB_HOST, DB_NAME, DB_PASS, DB_PORT, DB_USER } from '$env/static/private';
import mariadb from 'mariadb';

let pool: mariadb.Pool | null = null;

export function getPool() {
  if (!pool) {
    pool = mariadb.createPool({
      host: DB_HOST,
      user: DB_USER,
      password: DB_PASS,
      port: parseInt(DB_PORT),
      database: DB_NAME,
      connectionLimit: 5,
      bigIntAsNumber: true,
    });
  }
  return pool;
}