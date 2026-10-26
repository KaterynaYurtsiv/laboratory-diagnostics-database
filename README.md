# Laboratory Diagnostics Database System

## Overview
A relational database project developed using MySQL to manage laboratory diagnostic workflows, including patient records, medical referrals, laboratory tests, results, and payments.

The project was developed as part of the Database Systems coursework at Igor Sikorsky Kyiv Polytechnic Institute in 2025.

## Technologies
- MySQL
- SQL
- Relational Database Design
- ER and UML Modeling
- Database Normalization

## Key Features
- Relational database schema for laboratory diagnostic processes
- Primary and foreign keys to maintain relationships between entities
- Data integrity constraints (NOT NULL, UNIQUE, CHECK)
- SQL views for retrieving and combining related information
- Triggers for enforcing business rules
- Indexes for improving query performance
- Query execution analysis using EXPLAIN

## Database Design
The database covers patient registration, medical staff, referrals, laboratory tests, diagnostic results, and payments.

The design includes conceptual and logical modeling, normalization, and implementation of the physical database schema.

### Entity-Relationship Diagram
The ER diagram illustrates the database entities and their relationships.

![ER Diagram](diagrams/ER%20Diagram.png)

### UML Class Diagram
The UML class diagram represents the logical database structure, including attributes and relationships.

![UML Class Diagram](diagrams/UML%20Class%20Diagram.png)

## Project Structure
- `sql/schema.sql` — Database schema and table relationships
- `sql/sample_data.sql` — Sample records
- `sql/views.sql` — SQL views
- `sql/triggers.sql` — Business-rule triggers
- `sql/indexes.sql` — Database indexes
- `sql/analysis_queries.sql` — Analytical queries and execution-plan analysis
- `diagrams/` — ER and UML diagrams

## How to Run
Requires a MySQL server and a SQL client (such as MySQL Workbench).

Run the SQL scripts in the following order:

1. `sql/schema.sql`
2. `sql/triggers.sql`
3. `sql/sample_data.sql`
4. `sql/views.sql`
5. `sql/indexes.sql`
6. `sql/analysis_queries.sql`

**Note:** The scripts have not yet been verified through a complete execution on a fresh MySQL database.

## Project Status
The coursework database schema, sample data, views, triggers, indexes, analysis queries, and design diagrams are included in this repository. End-to-end MySQL testing is pending.

## Author
Kateryna Yurtsiv  
Computer Science Student, Igor Sikorsky Kyiv Polytechnic Institute
