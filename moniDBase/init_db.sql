--Create tables
CREATE TABLE IF NOT EXISTS users (
user_id SERIAL PRIMARY KEY,
full_name VARCHAR(50),
username VARCHAR(50) UNIQUE,
password TEXT NOT NULL,
is_google_user BOOLEAN,
picture TEXT
);

CREATE TABLE IF NOT EXISTS scans (
scan_id SERIAL PRIMARY KEY,
url VARCHAR(50),
status_code VARCHAR(10),
ssl_status VARCHAR(20),
expiration_date VARCHAR(30),
issuer TEXT,
user_id INT,
CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

ALTER TABLE scans ADD CONSTRAINT unique_user_url UNIQUE (user_id, url);




