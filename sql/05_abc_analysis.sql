-- ================================================
-- Script 5: ABC Product Analysis
-- ================================================

-- Product revenue summary
CREATE VIEW product_revenue AS
SELECT
    p.StockCode,
    p.Product,
    SUM(s.Quantity)                         AS TotalQuantity,
    ROUND(SUM(s.Quantity * s.Price), 2)     AS TotalRevenue,
    COUNT(DISTINCT s.Invoice)               AS TotalOrders,
    ROUND(AVG(s.Price), 2)                  AS AvgPrice
FROM sales s
JOIN products p ON s.StockCode = p.StockCode
GROUP BY p.StockCode, p.Product
ORDER BY TotalRevenue DESC;

-- ABC Classification
CREATE VIEW product_abc_analysis AS
SELECT
    StockCode,
    Product,
    TotalQuantity,
    TotalRevenue,
    TotalOrders,
    AvgPrice,
    ROUND(TotalRevenue * 100.0 /
        SUM(TotalRevenue) OVER (), 2)       AS RevenuePercent,
    ROUND(SUM(TotalRevenue) OVER (
        ORDER BY TotalRevenue DESC
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW) * 100.0 /
        SUM(TotalRevenue) OVER (), 2)       AS CumulativePct,
    CASE
        WHEN SUM(TotalRevenue) OVER (
            ORDER BY TotalRevenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW) * 100.0 /
            SUM(TotalRevenue) OVER () <= 80
             THEN 'A'
        WHEN SUM(TotalRevenue) OVER (
            ORDER BY TotalRevenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW) * 100.0 /
            SUM(TotalRevenue) OVER () <= 95
             THEN 'B'
        ELSE 'C'
    END                                     AS ABC_Class
FROM product_revenue
ORDER BY TotalRevenue DESC;

-- Dead stock (never sold)
CREATE VIEW dead_stock AS
SELECT
    p.StockCode,
    p.Product
FROM products p
WHERE p.StockCode NOT IN (
    SELECT DISTINCT StockCode
    FROM sales
);