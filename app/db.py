"""Acceso a la base de datos del Museo Digital.

Dos motores con el MISMO esquema (db/init/01_schema.sql):
  * MySQL  -> cuando existe la variable DB_HOST (modo Docker).
  * SQLite -> modo local sin instalar nada (el esquema de MySQL se traduce al vuelo).
"""

import os
import re
import sqlite3
import time
from datetime import date, datetime
from decimal import Decimal
from pathlib import Path

ROOT = Path(__file__).resolve().parent
ENGINE = "mysql" if os.environ.get("DB_HOST") else "sqlite"
SQLITE_PATH = Path(os.environ.get("SQLITE_PATH", ROOT / "museo.sqlite3"))
SQL_DIR = Path(os.environ.get("SQL_DIR", ROOT.parent / "db" / "init"))

if ENGINE == "mysql":
    import pymysql
    import pymysql.cursors
    IntegrityErrors = (sqlite3.IntegrityError, pymysql.err.IntegrityError)
else:
    IntegrityErrors = (sqlite3.IntegrityError,)


# ----------------------------------------------------------------- utilidades
def _plain(value):
    if isinstance(value, datetime):
        return value.strftime("%Y-%m-%d %H:%M:%S")
    if isinstance(value, date):
        return value.isoformat()
    if isinstance(value, Decimal):
        return int(value) if value == value.to_integral_value() else float(value)
    return value


def _dict_factory(cursor, row):
    return {d[0]: _plain(v) for d, v in zip(cursor.description, row)}


class Cursor:
    def __init__(self, cursor):
        self._c = cursor
        self.lastrowid = cursor.lastrowid
        self.rowcount = cursor.rowcount

    def fetchone(self):
        row = self._c.fetchone()
        return None if row is None else {k: _plain(v) for k, v in row.items()}

    def fetchall(self):
        return [{k: _plain(v) for k, v in r.items()} for r in self._c.fetchall()]

    def scalar(self):
        row = self.fetchone()
        return None if row is None else next(iter(row.values()))


class Connection:
    """Se usa con `with connection() as db:` -> confirma al salir, revierte si hay error."""

    def __init__(self, raw):
        self.raw = raw

    def execute(self, sql, params=()):
        if ENGINE == "mysql":
            cur = self.raw.cursor()
            cur.execute(sql.replace("?", "%s"), tuple(params) if params else None)
        else:
            cur = self.raw.cursor()
            cur.row_factory = _dict_factory
            cur.execute(sql, tuple(params))
        return Cursor(cur)

    def script(self, sql):
        """Ejecuta una sentencia tal cual (sin parámetros): esquema y datos de prueba."""
        if ENGINE == "mysql":
            self.raw.cursor().execute(sql)
        else:
            self.raw.execute(sql)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc, tb):
        try:
            if exc_type is None:
                self.raw.commit()
            else:
                self.raw.rollback()
        finally:
            self.raw.close()
        return False


def connection():
    if ENGINE == "mysql":
        raw = pymysql.connect(
            host=os.environ["DB_HOST"],
            port=int(os.environ.get("DB_PORT", "3306")),
            user=os.environ.get("DB_USER", "museo"),
            password=os.environ.get("DB_PASSWORD", ""),
            database=os.environ.get("DB_NAME", "museo_digital"),
            charset="utf8mb4",
            autocommit=False,
            cursorclass=pymysql.cursors.DictCursor,
        )
    else:
        raw = sqlite3.connect(SQLITE_PATH)
        raw.execute("PRAGMA foreign_keys = ON")
    return Connection(raw)


# ------------------------------------------------- scripts SQL (esquema/datos)
def split_sql(text):
    """Separa sentencias por ';' respetando textos entre comillas simples."""
    statements, buf, quote, i = [], [], False, 0
    while i < len(text):
        ch = text[i]
        if quote:
            buf.append(ch)
            if ch == "'":
                if i + 1 < len(text) and text[i + 1] == "'":
                    buf.append("'")
                    i += 1
                else:
                    quote = False
        elif ch == "'":
            quote = True
            buf.append(ch)
        elif ch == "-" and text.startswith("--", i):
            j = text.find("\n", i)
            i = len(text) if j == -1 else j
            continue
        elif ch == ";":
            statement = "".join(buf).strip()
            if statement:
                statements.append(statement)
            buf = []
        else:
            buf.append(ch)
        i += 1
    tail = "".join(buf).strip()
    if tail:
        statements.append(tail)
    return statements


def mysql_to_sqlite(statement):
    """Traduce un CREATE TABLE de MySQL a SQLite (solo lo que usa nuestro esquema)."""
    s = statement
    s = re.sub(r"\bINT\s+AUTO_INCREMENT\s+PRIMARY\s+KEY", "INTEGER PRIMARY KEY AUTOINCREMENT", s)
    s = re.sub(r"\)\s*ENGINE\s*=\s*InnoDB", ")", s)
    s = re.sub(r"\n\s*(FULLTEXT\s+)?(INDEX|KEY)\s+\w+\s*\([^)]*\)\s*,?", "", s)
    s = re.sub(r"UNIQUE\s+KEY\s+\w+\s*\(", "UNIQUE (", s)
    s = re.sub(r"\s+ON\s+UPDATE\s+CURRENT_TIMESTAMP", "", s)
    s = re.sub(r"TINYINT\(1\)", "INTEGER", s)
    s = re.sub(r"VARCHAR\(\d+\)", "TEXT", s)
    s = re.sub(r"\bJSON\b", "TEXT", s)
    s = re.sub(r"\bINT\b", "INTEGER", s)
    s = re.sub(r",\s*\)", "\n)", s)          # coma sobrante antes de ')'
    return s


def _run_script(db, path):
    for statement in split_sql(path.read_text(encoding="utf-8")):
        head = statement.upper()
        if ENGINE == "sqlite":
            if head.startswith(("CREATE DATABASE", "USE ", "SET ")):
                continue
            if head.startswith("CREATE TABLE"):
                statement = mysql_to_sqlite(statement)
        db.script(statement)


def _has_tables(db):
    if ENGINE == "mysql":
        return db.execute(
            "SELECT COUNT(*) AS n FROM information_schema.tables "
            "WHERE table_schema = DATABASE() AND table_name = 'usuarios'"
        ).scalar() > 0
    return db.execute(
        "SELECT COUNT(*) AS n FROM sqlite_master WHERE type='table' AND name='usuarios'"
    ).scalar() > 0


def init_db():
    """Crea el esquema y los datos de prueba si la base está vacía."""
    for attempt in range(30):                      # MySQL tarda unos segundos en arrancar
        try:
            with connection() as db:
                created = False
                if not _has_tables(db):
                    schema = SQL_DIR / "01_schema.sql"
                    if not schema.exists():
                        raise RuntimeError(f"No encuentro {schema}; define SQL_DIR")
                    _run_script(db, schema)
                    created = True
                if db.execute("SELECT COUNT(*) AS n FROM usuarios").scalar() == 0:
                    seed = SQL_DIR / "02_seed.sql"
                    if seed.exists():
                        _run_script(db, seed)
                return created
        except IntegrityErrors:
            raise
        except Exception as error:
            if ENGINE != "mysql" or attempt == 29:
                raise
            print(f"Esperando a MySQL ({error.__class__.__name__})...", flush=True)
            time.sleep(2)
