
-- Adetwin Stores sample data
BEGIN;

-- 1. CATEGORIES
INSERT INTO categories (category_name)
VALUES
    ('Grains'),
    ('Cooking Oil'),
    ('Groceries');

-- 2. PRODUCTS
-- Initial stock is the opening stock before sample sales.

INSERT INTO products
    (product_name, category_id, current_price, quantity_in_stock)
VALUES
    ('Rice 50kg', 1, 95000.00, 25),
    ('Beans 25kg', 1, 48000.00, 18),
    ('Vegetable Oil 5L', 2, 12500.00, 30),
    ('Sugar 1kg', 3, 2000.00, 60),
    ('Garri 5kg', 1, 6500.00, 40);

-- 3. REGISTERED CUSTOMERS
INSERT INTO customers (customer_name, phone)
VALUES
    ('Ganiyat Salami', '08030000001'),
    ('Aderonke Falemi', '08030000002'),
    ('Agnes Fabian', '08030000003');

-- 4. SALES
-- Sale 1: registered customer, fully paid
-- Sale 2: walk-in customer, fully paid
-- Sale 3: registered customer, partially paid
-- Sale 4: registered customer, unpaid

INSERT INTO sales (customer_id, sale_date, total_amount)
VALUES
    (1, '2026-10-20 09:15:00', 96800.00),
    (NULL, '2026-10-20 10:05:00', 14300.00),
    (2, '2026-10-20 11:20:00', 62800.00),
    (3, '2026-10-20 12:10:00', 48000.00);

-- 5. SALE ITEMS
INSERT INTO sale_items
    (sale_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 1, 95000.00),
    (1, 4, 1, 1800.00),

    (2, 3, 1, 12500.00),
    (2, 4, 1, 1800.00),

    (3, 2, 1, 48000.00),
    (3, 4, 1, 1800.00),
    (3, 5, 2, 6500.00),

    (4, 2, 1, 48000.00);

-- 6. PAYMENTS
INSERT INTO payments
    (sale_id, amount, payment_date, payment_method)
VALUES
    (1, 96800.00, '2026-10-20 09:16:00', 'TRANSFER'),
    (2, 14300.00, '2026-10-20 10:06:00', 'CASH'),
    (3, 30000.00, '2026-10-20 11:25:00', 'POS');

-- Sale 4 is unpaid, so it has no payment record.

-- 7. OPENING INVENTORY MOVEMENTS
INSERT INTO inventory_movements
    (product_id, movement_type, quantity, movement_date)
VALUES
    (1, 'STOCK_IN', 25, '2026-10-01 08:00:00'),
    (2, 'STOCK_IN', 18, '2026-10-01 08:05:00'),
    (3, 'STOCK_IN', 30, '2026-10-01 08:10:00'),
    (4, 'STOCK_IN', 60, '2026-10-01 08:15:00'),
    (5, 'STOCK_IN', 40, '2026-10-01 08:20:00');

-- 8. INVENTORY MOVEMENTS FOR ITEMS SOLD
INSERT INTO inventory_movements
    (product_id, sale_item_id, movement_type, quantity, movement_date)
VALUES
    (1, 1, 'SALE', 1, '2026-10-20 09:15:00'),
    (4, 2, 'SALE', 1, '2026-10-20 09:15:00'),
    (3, 3, 'SALE', 1, '2026-10-20 10:05:00'),
    (4, 4, 'SALE', 1, '2026-10-20 10:05:00'),
    (2, 5, 'SALE', 1, '2026-10-20 11:20:00'),
    (4, 6, 'SALE', 1, '2026-10-20 11:20:00'),
    (5, 7, 'SALE', 2, '2026-10-20 11:20:00'),
    (2, 8, 'SALE', 1, '2026-10-20 12:10:00');

-- 9. UPDATE CURRENT STOCK AFTER SALES
UPDATE products
SET quantity_in_stock = CASE product_id
    WHEN 1 THEN 24
    WHEN 2 THEN 16
    WHEN 3 THEN 29
    WHEN 4 THEN 58
    WHEN 5 THEN 38
END
WHERE product_id IN (1, 2, 3, 4, 5);

COMMIT;
