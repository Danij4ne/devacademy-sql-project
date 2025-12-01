# DevAcademy SQL Project

This project defines the complete relational database architecture for the DevAcademy system. It consolidates schema creation, entity constraints, relational design, seed data insertion, operational queries, and SQL logic for indexes, triggers, views, and stored procedures. An ERD diagram is included to illustrate the structural relationships across all entities.

## Purpose

The project establishes a structured SQL environment that models students, teachers, courses, companies, enrollments, identification records, and email-change tracking. It provides all components required for schema initialization, referential integrity, data operations, and analytical reporting.

## Concepts Addressed

- Database initialization
- Table creation and constraint definitions
- Relational structures (1:1, 1:N, N:M, and self-referential relationships)
- Seed data population
- Query operations for filtering, ordering, and pattern matching
- Aggregations and grouping logic
- Join operations across multiple entities
- Index management
- Trigger-based audit tracking
- View construction for reusable query layers
- Stored procedure definitions
- Update, delete, and structural modification operations

## Practical Use

The project enables operations such as course assignments, mentorship relationships, company–student associations, enrollment management, email-change auditing, and reporting workflows. The ERD file (`devacademy-erd.svg`) provides a structural overview of all entities and constraints.

## Exercises

The repository contains the following SQL files, each representing a specific operational unit:

- sql/01_create_database.sql
- sql/02_tables_and_constraints.sql
- sql/03_insert_seed_data.sql
- sql/04_basic_queries.sql
- sql/05_groupby_and_functions.sql
- sql/06_joins.sql
- sql/07_indexes_views_triggers.sql
- sql/08_updates_and_final_reports.sql

## Project Summary

The DevAcademy SQL project delivers a complete relational database implementation, covering schema creation, relationships, data insertion, analytical queries, procedural logic, and reporting. It provides a cohesive SQL architecture supported by a detailed ERD for structural reference.

**Author:** Daniel Jane García (danij4ne)
