-- ============================================================
-- SHOPEASY DATA MIGRATION PROJECT
-- TARGET DATABASE (new system - after migration, contains 5 defects)
-- ============================================================

-- ---------- CUSTOMERS (identical to source - no defects) ----------
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name        TEXT NOT NULL,
    email       TEXT NOT NULL,
    city        TEXT
);

INSERT INTO customers VALUES
(1, 'Arun Kumar', 'arun@email.com', 'Kuala Lumpur'),
(2, 'Priya Nair', 'priya@email.com', 'Penang'),
(3, 'Raj Mohan', 'raj@email.com', 'Johor Bahru'),
(4, 'Siti Aminah', 'siti@email.com', 'Kuala Lumpur'),
(5, 'Chen Wei', 'chen@email.com', 'Ipoh');

-- ---------- PRODUCTS (identical to source - no defects) ----------
CREATE TABLE products (
    product_id   INTEGER PRIMARY KEY,
    product_name TEXT NOT NULL,
    category     TEXT,
    unit_price   REAL NOT NULL
);

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 3200.00),
(102, 'Phone', 'Electronics', 1500.00),
(103, 'Headphones', 'Electronics', 250.00),
(104, 'T-Shirt', 'Clothing', 49.90),
(105, 'Running Shoes', 'Footwear', 320.00);

-- ---------- ORDERS (NOTE: no PRIMARY KEY constraint on order_id -----------
-- This simulates a real migration bug where a uniqueness constraint
-- was dropped, allowing the duplicate defect below to be inserted.
CREATE TABLE orders (
    order_id     INTEGER,
    customer_id  INTEGER,
    product_id   INTEGER,
    quantity     INTEGER,
    unit_price   REAL,
    order_total  REAL,
    order_date   TEXT,
    status       TEXT
);

INSERT INTO orders VALUES
(1001, 1, 101, 1, 3200.00, 3200.00, '2024-01-05', 'Delivered'),
-- DEFECT 1: order 1002 is MISSING ENTIRELY (not migrated)
(1003, 3, 103, 3, 250.00,  750.00,  '2024-01-10', 'Shipped'),
(1004, 4, 104, 5, 49.90,   249.50,  '2024-01-12', 'Delivered'),
(1005, 5, 105, 2, 320.00,  640.00,  '2024-01-15', 'Pending'),
(1006, 1, 103, 1, 250.00,  250.00,  '2024-01-18', 'Delivered'),
(1007, 2, 104, 3, 49.90,   149.70,  '2024-01-20', 'Shipped'),
(1007, 2, 104, 3, 49.90,   149.70,  '2024-01-20', 'Shipped'),
-- DEFECT 2: order 1007 is DUPLICATED (inserted twice)
(1008, 3, 101, 1, 3200.00, 3200.00, '2024-01-22', 'Delivered'),
(1009, 4, 102, 1, 1500.00, 9999.00, '2024-01-25', 'Pending'),
-- DEFECT 3 & 5: order 1009 has WRONG order_total (should be 1500.00, got 9999.00)
--              this also breaks the business rule: total = qty x unit_price
(1010, 5, 105, 4, 320.00,  1280.00, '2024-01-28', NULL);
-- DEFECT 4: order 1010 has NULL status (required field empty)

-- Total rows in TARGET: customers=5, products=5, orders=9 (one missing + one duplicate = 9 unique + 1 dup row = 10 physical rows)
