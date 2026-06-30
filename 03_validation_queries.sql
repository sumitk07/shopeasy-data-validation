-- ============================================================
-- SHOPEASY DATA MIGRATION PROJECT
-- VALIDATION QUERIES (run against TARGET unless noted)
-- Each query below corresponds to one Test Case in the
-- Test_Cases_and_Bug_Report.xlsx file.
-- ============================================================

-- TC01: Record count check (Source vs Target)
-- Run on Source, then Target, compare manually
SELECT COUNT(*) AS total_orders FROM orders;
-- Expected (Source): 10 | Actual (Target): 9 -> FAIL (1 row missing)


-- TC02: Find order_ids present in Source but missing in Target
-- (Run with both DBs attached, or compare exported order_id lists)
SELECT order_id FROM source_orders
WHERE order_id NOT IN (SELECT order_id FROM target_orders);
-- Expected: no rows | Actual: 1002 -> FAIL


-- TC03: Duplicate record detection
SELECT order_id, COUNT(*) AS occurrences
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;
-- Expected: no rows | Actual: 1007 | 2 -> FAIL


-- TC04: Null check on required field (status)
SELECT order_id, status
FROM orders
WHERE status IS NULL;
-- Expected: no rows | Actual: 1010 | NULL -> FAIL


-- TC05: Business rule validation (order_total = quantity x unit_price)
SELECT order_id, quantity, unit_price,
       order_total AS actual_total,
       (quantity * unit_price) AS expected_total
FROM orders
WHERE order_total != (quantity * unit_price);
-- Expected: no rows | Actual: 1009 | 9999.00 vs 1500.00 -> FAIL


-- TC06: Field-level value comparison between Source and Target (for matching IDs)
SELECT s.order_id, s.order_total AS source_total, t.order_total AS target_total
FROM source_orders s
JOIN target_orders t ON s.order_id = t.order_id
WHERE s.order_total != t.order_total;
-- Expected: no rows | Actual: 1009 -> FAIL


-- TC07: Referential integrity check - every customer_id in orders exists in customers
SELECT o.order_id, o.customer_id
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
-- Expected: no rows | Actual: no rows -> PASS


-- TC08: Referential integrity check - every product_id in orders exists in products
SELECT o.order_id, o.product_id
FROM orders o
LEFT JOIN products p ON o.product_id = p.product_id
WHERE p.product_id IS NULL;
-- Expected: no rows | Actual: no rows -> PASS


-- TC09: Aggregate comparison - total revenue (Source vs Target)
SELECT SUM(order_total) AS total_revenue FROM orders;
-- Expected (Source): 13619.20 | Actual (Target): varies due to defects -> compare and flag


-- TC10: Range/format check - no negative or zero quantities
SELECT order_id, quantity
FROM orders
WHERE quantity <= 0;
-- Expected: no rows | Actual: no rows -> PASS
