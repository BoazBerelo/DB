# 🔍 moniDBase

A repository containing SQL schema and initialization scripts for the "moniDB" database, which stores user and website scanning information.

## 📋 Overview

This repository contains the necessary files to set up a PostgreSQL database for a website scanning application. The database structure includes:

- `users` table: Stores user information including authentication details
- `scans` table: Stores website scan results with SSL and status information

## 📦 Repository Contents

- `init_db.sql`: SQL initialization script that creates the necessary tables and constraints
- `install_db.sh`: Shell script for easy one-line installation
- Additional application files (if any)

## ⚙️ Requirements

- Amazon EC2 instance (Ubuntu recommended)
- Docker
- Git

## ⚡ Quick Installation

The easiest way to install the database is using our installation script:

```bash
curl -s https://raw.githubusercontent.com/danette14/moniDBase/main/install_db.sh | bash
```

This will automatically install Docker, set up PostgreSQL, and initialize the database with the required schema.

## 📝 Manual Installation Guide

Alternatively, follow these steps to manually set up the moniDB database on an EC2 instance:

### 1. Connect to your EC2 instance

```bash
ssh -i your-key.pem ubuntu@your-ec2-ip
```

### 2. Update system and install Docker

```bash
sudo -i
apt update -y && apt upgrade -y
apt install docker.io -y
```

### 3. Create a directory for PostgreSQL data persistence

```bash
mkdir -p ~/postgres_data
sudo chown -R 999:999 ~/postgres_data
```

### 4. Run PostgreSQL in a Docker container

```bash
docker run -d \
  --name my_postgres_db \
  -e POSTGRES_USER=myuser \
  -e POSTGRES_PASSWORD=mypassword \
  -e POSTGRES_DB=moniDB \
  -v ~/postgres_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:13
```

### 5. Clone this repository

```bash
cd /
git clone https://github.com/danette14/moniDBase.git
```

### 6. Initialize the database with the SQL schema

```bash
cd /moniDBase
docker cp init_db.sql my_postgres_db:/init_db.sql
docker exec -it my_postgres_db psql -U myuser -d moniDB -f /init_db.sql
```

## 🗃️ Database Schema

### Users Table

| Column        | Type          | Description                            |
|---------------|---------------|----------------------------------------|
| user_id       | SERIAL        | Primary key, auto-incrementing ID      |
| full_name     | VARCHAR(50)   | User's full name                       |
| username      | VARCHAR(50)   | Unique username for login              |
| password      | TEXT          | Encrypted password                     |
| is_google_user| BOOLEAN       | Flag for Google authentication users   |
| picture       | TEXT          | URL to user's profile picture          |

### Scans Table

| Column          | Type          | Description                          |
|-----------------|---------------|--------------------------------------|
| scan_id         | SERIAL        | Primary key, auto-incrementing ID    |
| url             | VARCHAR(50)   | URL of the scanned website           |
| status_code     | VARCHAR(10)   | HTTP status code of the scan         |
| ssl_status      | VARCHAR(20)   | SSL certificate status               |
| expiration_date | VARCHAR(30)   | SSL certificate expiration date      |
| issuer          | TEXT          | SSL certificate issuer               |
| user_id         | INT           | Foreign key to users table           |

## 🔒 Security Notes

- For production environments, consider changing the default database credentials
- Secure your EC2 instance with appropriate security groups
- Consider adding database backups for data persistence

## 🔌 Connecting to the Database

You can connect to the database using the following credentials:
- Host: `localhost` (or your EC2 public IP for remote connections)
- Port: `5432`
- Database: `moniDB`
- Username: `myuser`
- Password: `mypassword`

Sample connection command:
```bash
psql -h localhost -p 5432 -U myuser -d moniDB
```


