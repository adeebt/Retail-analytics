-- ================================================
-- Script 4: Cohort Retention Analysis
-- ================================================

-- Customer first purchase month
CREATE VIEW customer_cohort AS
SELECT
    CustomerID,
    DATE_FORMAT(MIN(InvoiceDate), '%Y-%m') AS CohortMonth
FROM invoices
WHERE YEAR(InvoiceDate) > 1900
GROUP BY CustomerID;

-- Cohort data with month numbers
CREATE VIEW cohort_data AS
SELECT
    i.CustomerID,
    c.CohortMonth,
    DATE_FORMAT(i.InvoiceDate, '%Y-%m')    AS PurchaseMonth,
    PERIOD_DIFF(
        DATE_FORMAT(i.InvoiceDate, '%Y%m'),
        DATE_FORMAT(STR_TO_DATE(
            CONCAT(c.CohortMonth, '-01'),
            '%Y-%m-%d'), '%Y%m')
    )                                       AS MonthNumber
FROM invoices i
JOIN customer_cohort c
    ON i.CustomerID = c.CustomerID
WHERE YEAR(i.InvoiceDate) > 1900;

-- Cohort retention counts
CREATE VIEW cohort_retention AS
SELECT
    CohortMonth,
    MonthNumber,
    COUNT(DISTINCT CustomerID)             AS Customers
FROM cohort_data
GROUP BY CohortMonth, MonthNumber
ORDER BY CohortMonth, MonthNumber;

-- Cohort sizes
CREATE VIEW cohort_size AS
SELECT
    CohortMonth,
    COUNT(DISTINCT CustomerID)             AS CohortSize
FROM customer_cohort
GROUP BY CohortMonth
ORDER BY CohortMonth;

-- Retention percentages
CREATE VIEW cohort_retention_pct AS
SELECT
    cr.CohortMonth,
    cr.MonthNumber,
    cr.Customers,
    cs.CohortSize,
    ROUND(cr.Customers * 100.0
          / cs.CohortSize, 2)              AS RetentionPct
FROM cohort_retention cr
JOIN cohort_size cs
    ON cr.CohortMonth = cs.CohortMonth
ORDER BY cr.CohortMonth, cr.MonthNumber;