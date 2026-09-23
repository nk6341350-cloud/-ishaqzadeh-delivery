CREATE TABLE IF NOT EXISTS users (
 id TEXT PRIMARY KEY, full_name TEXT NOT NULL, phone TEXT NOT NULL UNIQUE,
 pin_hash TEXT NOT NULL, pin_salt TEXT NOT NULL, role TEXT NOT NULL DEFAULT 'agent',
 status TEXT NOT NULL DEFAULT 'pending', selfie_path TEXT, created_at TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_users_phone ON users(phone);
CREATE TABLE IF NOT EXISTS sessions (
 token_hash TEXT PRIMARY KEY, user_id TEXT NOT NULL, expires_at TEXT NOT NULL,
 FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
);
CREATE INDEX IF NOT EXISTS idx_sessions_user ON sessions(user_id);
CREATE TABLE IF NOT EXISTS orders (
 id TEXT PRIMARY KEY, product_name TEXT NOT NULL, customer_phone TEXT NOT NULL,
 province TEXT NOT NULL, quantity INTEGER NOT NULL, address TEXT NOT NULL,
 price INTEGER NOT NULL, photo_path TEXT NOT NULL, status TEXT NOT NULL DEFAULT 'registered',
 created_by TEXT NOT NULL, created_at TEXT NOT NULL, processed_at TEXT,
 FOREIGN KEY(created_by) REFERENCES users(id)
);
CREATE INDEX IF NOT EXISTS idx_orders_created ON orders(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_orders_creator ON orders(created_by,created_at DESC);
CREATE INDEX IF NOT EXISTS idx_orders_processed ON orders(processed_at DESC);
