-- ============================================================
-- SHOPEASY DATA MIGRATION PROJECT
-- SOURCE DATABASE (old system - ground truth, correct data)
-- ============================================================

-- ---------- CUSTOMERS ----------
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

-- ---------- PRODUCTS ----------
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

-- ---------- ORDERS (10 rows, all correct) ----------
CREATE TABLE orders (
    order_id     INTEGER PRIMARY KEY,
    customer_id  INTEGER NOT NULL,
    product_id   INTEGER NOT NULL,
    quantity     INTEGER NOT NULL,
    unit_price   REAL NOT NULL,
    order_total  REAL NOT NULL,
    order_date   TEXT NOT NULL,
    status       TEXT
);

INSERT INTO orders VALUES
(1001, 1, 101, 1, 3200.00, 3200.00, '2024-01-05', 'Delivered'),
(1002, 2, 102, 2, 1500.00, 3000.00, '2024-01-07', 'Delivered'),
(1003, 3, 103, 3, 250.00,  750.00,  '2024-01-10', 'Shipped'),
(1004, 4, 104, 5, 49.90,   249.50,  '2024-01-12', 'Delivered'),
(1005, 5, 105, 2, 320.00,  640.00,  '2024-01-15', 'Pending'),
(1006, 1, 103, 1, 250.00,  250.00,  '2024-01-18', 'Delivered'),
(1007, 2, 104, 3, 49.90,   149.70,  '2024-01-20', 'Shipped'),
(1008, 3, 101, 1, 3200.00, 3200.00, '2024-01-22', 'Delivered'),
(1009, 4, 102, 1, 1500.00, 1500.00, '2024-01-25', 'Pending'),
(1010, 5, 105, 4, 320.00,  1280.00, '2024-01-28', 'Delivered');

-- Total rows in SOURCE: customers=5, products=5, orders=10
