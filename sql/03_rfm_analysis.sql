-- ================================================
-- Script 3: RFM Analysis
-- ================================================

-- Base RFM metrics
CREATE VIEW rfm_base AS
SELECT
    c.CustomerID,
    c.Country,
    MAX(i.InvoiceDate)                      AS LastPurchaseDate,
    COUNT(DISTINCT s.Invoice)               AS Frequency,
    ROUND(SUM(s.Quantity * s.Price), 2)     AS Monetary
FROM sales s
JOIN invoices  i ON s.Invoice    = i.Invoice
JOIN customers c ON i.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.Country;

-- RFM Scores using NTILE
CREATE VIEW rfm_scored AS
SELECT
    CustomerID,
    Country,
    LastPurchaseDate,
    DATEDIFF(
        (SELECT MAX(InvoiceDate) FROM invoices),
        LastPurchaseDate
    )                                           AS Recency_Days,
    Frequency,
    Monetary,
    NTILE(5) OVER (
        ORDER BY LastPurchaseDate ASC)          AS R_Score,
    NTILE(5) OVER (
        ORDER BY Frequency ASC)                 AS F_Score,
    NTILE(5) OVER (
        ORDER BY Monetary ASC)                  AS M_Score
FROM rfm_base;

-- RFM Segments
CREATE VIEW rfm_segments AS
SELECT *,
    CASE
        WHEN R_Score >= 4
         AND F_Score >= 4
         AND M_Score >= 4  THEN 'Champion'
        WHEN R_Score <= 2
         AND F_Score >= 3
         AND M_Score >= 3  THEN 'At Risk'
        WHEN R_Score >= 3
         AND F_Score >= 3  THEN 'Loyal'
        WHEN R_Score <= 2
         AND F_Score <= 2  THEN 'Lost'
        WHEN R_Score >= 4
         AND F_Score <= 2  THEN 'New Customer'
        ELSE                    'Potential'
    END AS Segment
FROM rfm_scored;