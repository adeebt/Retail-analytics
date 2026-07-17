-- ================================================
-- Retail Analytics Project
-- Script 1: Create Tables
-- Author: Adeeb
-- Date: 2024
-- ================================================

CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

-- Customers table
CREATE TABLE customers (
    CustomerID  VARCHAR(20) PRIMARY KEY,
    Country     VARCHAR(100)
);

-- Products table
CREATE TABLE products (
    StockCode   VARCHAR(20) PRIMARY KEY,
    Product     VARCHAR(200)
);

-- Invoices table
CREATE TABLE invoices (
    Invoice     VARCHAR(20) PRIMARY KEY,
    CustomerID  VARCHAR(20),
    InvoiceDate DATETIME,
    FOREIGN KEY (CustomerID)
        REFERENCES customers(CustomerID)
);

-- Invoice Items table
CREATE TABLE invoice_items (
    Invoice     VARCHAR(20),
    StockCode   VARCHAR(20),
    Quantity    INT,
    Price       DECIMAL(10,2),
    PRIMARY KEY (Invoice, StockCode),
    FOREIGN KEY (Invoice)
        REFERENCES invoices(Invoice),
    FOREIGN KEY (StockCode)
        REFERENCES products(StockCode)
);