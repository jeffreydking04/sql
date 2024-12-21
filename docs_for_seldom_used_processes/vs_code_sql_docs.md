# Setting Up PostgreSQL Development Environment in VS Code

## Required Extensions
1. SQLTools
2. SQLTools PostgreSQL/Cockroach Driver

## Database Connection Setup
1. Open VS Code
2. Click Database icon in sidebar (cylinder shape)
3. Create New Connection:
   - Connection name: Any descriptive name
   - Host: localhost
   - Database: Name of target database
   - User: postgres (default for local installation)
   - Password: Your PostgreSQL password (click for dropdown to select no password needed if applicable)
   - Port: 5432 (default)

## Creating Database
1. Open PostgreSQL application
2. View existing databases or create new one
3. Note database name for connection

## Creating Table and Importing CSV
1. Create table with required columns:
```sql
CREATE TABLE table_name (
    column1 type,
    column2 type,
    ...
);
```

2. Import CSV data:
```sql
COPY table_name FROM '/path/to/your.csv' CSV HEADER;
```

## Tips
- To get file path on Mac: 
  - Right-click file
  - Hold Option key
  - Select "Copy as Pathname"
- Database must be created before connecting in VS Code
- Ensure CSV column order matches table structure
