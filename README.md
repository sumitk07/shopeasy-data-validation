# ShopEasy E-Commerce Data Migration Validation

## Project Overview
Simulated a real-world data migration scenario for an e-commerce platform (ShopEasy) moving order data from an old system (**Source**) to a new system (**Target**). As the Data Tester, I validated the migration using SQL, identified 5 data defects, and documented them following industry-standard testing practices.

## Objective
Verify that data migrated from Source to Target is **complete, accurate, and consistent**, by checking:
- Record completeness (no missing rows)
- No duplicate records
- Field-level data accuracy
- Null checks on required fields
- Business rule validation (order_total = quantity × unit_price)

## Tech Stack
- SQLite (via DB Browser for SQLite)
- SQL (DDL, DML, JOINs, GROUP BY, aggregate functions)
- Excel (test case documentation, bug reporting)

## Project Structure
```
shopeasy-project/
├── 01_source_database.sql        # Source DB schema + data (ground truth)
├── 02_target_database.sql        # Target DB schema + data (contains 5 planted defects)
├── 03_validation_queries.sql     # 10 SQL test queries used to validate migration
├── Test_Cases_and_Bug_Report.xlsx # Test case sheet, bug report, and execution summary
└── README.md
```

## Defects Found

| # | Defect Type | Description | Severity |
|---|---|---|---|
| 1 | Missing record | Order 1002 not migrated to Target | High |
| 2 | Duplicate record | Order 1007 inserted twice in Target | Medium |
| 3 | Data value mismatch | Order 1009 total shows 9999.00 instead of 1500.00 | High |
| 4 | Null in required field | Order 1010 has NULL status | Medium |
| 5 | Business rule violation | order_total ≠ quantity × unit_price for order 1009 | High |

## Testing Approach
1. Set up two SQLite databases (Source and Target) representing pre- and post-migration states
2. Wrote 10 SQL validation queries covering record counts, duplicates, nulls, value mismatches, referential integrity, and business rules
3. Executed each query and logged results in a structured Test Case sheet (Pass/Fail status, expected vs actual)
4. Documented all failures as formal bug reports with severity, priority, and reproduction steps

## Sample Validation Query
```sql
-- Business rule validation: order_total must equal quantity x unit_price
SELECT order_id, quantity, unit_price, order_total,
       (quantity * unit_price) AS expected_total
FROM orders
WHERE order_total != (quantity * unit_price);
```

## Result
7 of 10 test cases failed, surfacing 5 distinct defects. Migration was flagged as **not ready for production** until all P1 (critical) defects are resolved and re-tested.

## Author
    Sumit — Data Tester
# shopeasy-data-validation
