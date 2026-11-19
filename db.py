from contextlib import contextmanager
from psycopg2 import pool
from psycopg2.extras import RealDictCursor
from config import Config

_connection_pool = None


def get_pool() -> pool.ThreadedConnectionPool:
    """Lazily initialize and return the PostgreSQL connection pool."""
    global _connection_pool
    if _connection_pool is None:
        _connection_pool = pool.ThreadedConnectionPool(
            minconn=1,
            maxconn=10,
            **Config.get_db_params(),
        )
    return _connection_pool


def close_pool() -> None:
    """Close all connections in the pool on application shutdown."""
    global _connection_pool
    if _connection_pool is not None:
        _connection_pool.closeall()
        _connection_pool = None


@contextmanager
def get_connection():
    """Borrow a connection from the pool and return it cleanly."""
    conn_pool = get_pool()
    conn = conn_pool.getconn()
    try:
        yield conn
    finally:
        conn_pool.putconn(conn)


def fetch_all(query: str, params=None) -> list:
    """Execute a SELECT query and return all rows as a list of dicts."""
    with get_connection() as conn:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(query, params)
            return [dict(row) for row in cur.fetchall()]


def fetch_one(query: str, params=None):
    """Execute a SELECT query and return a single row as a dict, or None."""
    with get_connection() as conn:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(query, params)
            row = cur.fetchone()
            return dict(row) if row is not None else None


def execute_query(query: str, params=None, returning: bool = False):
    """Execute an INSERT, UPDATE, or DELETE statement with auto-commit/rollback."""
    with get_connection() as conn:
        try:
            with conn.cursor(cursor_factory=RealDictCursor) as cur:
                cur.execute(query, params)
                result = cur.fetchone() if returning else cur.rowcount
            conn.commit()
            return dict(result) if (returning and result is not None) else result
        except Exception:
            conn.rollback()
            raise


@contextmanager
def transaction():
    """Provide a transactional scope around a series of database operations."""
    with get_connection() as conn:
        try:
            with conn.cursor(cursor_factory=RealDictCursor) as cur:
                yield cur
            conn.commit()
        except Exception:
            conn.rollback()
            raise
