-- ================================================
-- Script 2: Data Cleaning
-- ================================================

-- Separate sales from returns
CREATE TABLE sales AS
SELECT * FROM invoice_items
WHERE Quantity > 0
AND Price > 0
AND LEFT(Invoice, 1) != 'C';

-- Create returns table
CREATE TABLE returns AS
SELECT * FROM invoice_items
WHERE LEFT(Invoice, 1) = 'C'
AND Quantity < 0;

-- Create stock adjustments table
CREATE TABLE stock_adjustments AS
SELECT * FROM invoice_items
WHERE Quantity < 0
AND Price = 0
AND LEFT(Invoice, 1) != 'C';

-- Create free samples table
CREATE TABLE free_samples AS
SELECT * FROM invoice_items
WHERE Price = 0
AND Quantity > 0;

-- Create financial adjustments table
CREATE TABLE financial_adjustments AS
SELECT * FROM invoice_items
WHERE StockCode IN ('B', 'M');

-- Remove B/M from other tables
DELETE FROM sales
WHERE StockCode IN ('B', 'M');

DELETE FROM returns
WHERE StockCode IN ('B', 'M');

DELETE FROM free_samples
WHERE StockCode IN ('B', 'M');