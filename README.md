# Player Management System
## Docker Database Setup

This project runs a MySQL 8.0 database for the Player Management System inside a Docker container. The database automatically creates and seeds all tables on first startup.

---

## Project Structure

```
docker-database-project/
├── docker-compose.yml
├── init-db/
│   ├── 01_create_tables.sql
│   └── 02_insert_data.sql
└── README.md
```

---

## How to Start the Database

Make sure Docker Desktop is running, then from the project root:

```bash
docker compose up
```

To run it in the background (detached mode):

```bash
docker compose up -d
```

MySQL will automatically run the scripts in `init-db/` in order on first startup.

---

## How to Stop the Database

Stop the container (keeps your data):

```bash
docker compose down
```

Stop and delete all data (full reset):

```bash
docker compose down -v
```

---

## How to Connect to the Database

Via Docker terminal:

```bash
docker exec -it player_management_db mysql -u student -pstudent123 player_management
```

Via MySQL Workbench:

| Setting  | Value             |
|----------|-------------------|
| Host     | 127.0.0.1         |
| Port     | 3306              |
| User     | see .env          |
| Password | see .env          |
| Database | player_management |

---

## Verify Tables Loaded

Once connected via terminal:

```sql
SHOW TABLES;
SELECT * FROM League;
SELECT * FROM Team;
SELECT * FROM Player;
SELECT * FROM Game;
```

---

## Database Credentials

Credentials are stored in a .env file (not committed to GitHub). Copy .env.example to get started:

```bash
cp .env.example .env
```

Then fill in your own values before running `docker compose up`.
