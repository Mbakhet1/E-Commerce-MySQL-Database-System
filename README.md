# E-Commerce-MySQL-Database-System
Bookstore Operations & Transaction Analytics
Project Overview
This project provides a comprehensive relational database solution for a retail bookstore, focusing on the seamless integration of Customer Relationship Management (CRM) and Inventory Lifecycle Management. By connecting sales data with detailed product information, the system enables deeper insights into business performance and operational efficiency.

Database Architecture
The system is architected into two primary modules that maintain data integrity through relational keys:

1. The Business Module (Transactions)
This module focuses on the customer journey and order fulfillment logistics:

Customer Data: Tracks personal identifiers and contact details for every shopper.

Order Tracking: Manages unique order IDs, transaction dates, and specific item quantities for every purchase.

2. The Inventory Module (Products)
This module manages the product catalog and supplier relationships:

Book Catalog: Stores titles, genres, and precise pricing using optimized data types.

Author Profiles: A normalized table that organizes writer information to reduce data redundancy.

The Relational Link
The core of this system is the relational bridge between the order_items table (Business Module) and the Books table (Inventory Module). By using a shared BookID, the database can instantly associate specific customer transactions with the corresponding inventory details, allowing for real-time stock updates and accurate revenue reporting.

Technical Implementation Highlights
Data Normalization: Structured the database across multiple tables to eliminate duplicate information and ensure a scalable design.

Integrity Constraints: Used PRIMARY KEY and FOREIGN KEY definitions to ensure all transactions remain accurately linked to existing products and customers.

Precision Handling: Applied specific numerical data types for financial values to ensure accuracy in accounting and inventory valuation.

Business Impact
By unifying these datasets, the system provides the foundation for high-level business analytics, including:

Revenue Performance: Identifying top-selling authors and genres to guide procurement.

Inventory Valuation: Calculating the total financial value of stock on hand.

Customer Retention: Tracking purchasing patterns to improve sales strategies.

Deployment Instructions
Initialize Environment: Open a MySQL-compatible interface like MySQL Workbench.

Execute Schema Scripts: Run the provided SQL files to generate the tables and populate the system with seed data.

Validate Links: Test the relational connections by querying data across both the Business and Inventory modules.

<img width="1086" height="630" alt="image" src="https://github.com/user-attachments/assets/1b7b9291-fa56-41e1-b49d-098acd8e1e8c" />


About the Author
Mohamed A. Bakhet Bachelor of Science in Business Analytics and Information Systems University of South Florida (USF)

Connect: https://www.linkedin.com/in/mohamed-bakhet-809288328/
