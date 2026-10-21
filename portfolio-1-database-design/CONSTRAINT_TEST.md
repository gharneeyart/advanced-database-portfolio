## 1. Customer
```sql
-- NEGATIVE TESTS
-- customer_name cannot be NULL
INSERT INTO customers (customer_name, phone) 
VALUES (NULL, '08031111111');

-- POSITIVE TESTS
--customer with phone number
INSERT INTO customers (customer_name, phone) 
VALUES ('Sofiat Adigun', '08039998888');

-- Walk-in/anonymous style tracking where phone is omitted (NULL)
INSERT INTO customers (customer_name, phone) 
VALUES ('Zahra Bello', NULL);

```
<img width="1287" height="476" alt="Screenshot 2026-10-21 at 12 39 30" src="https://github.com/user-attachments/assets/4419c4e2-ecfc-409b-b1ef-cfdfde8bd4da" />

<img width="1288" height="562" alt="Screenshot 2026-10-21 at 12 42 13" src="https://github.com/user-attachments/assets/68f45781-ac72-4d7e-aa13-899e4eedb8a9" />

## 2. Categories
```sql
-- NEGATIVE TESTS (Should Fail)
-- category_name must be unique ('Grains' already exists from initial seed)
INSERT INTO categories (category_name) 
VALUES ('Grains');

-- POSITIVE TESTS (Should Pass)
-- New unique category
INSERT INTO categories (category_name) 
VALUES ('Noodles');
```

## 3. Product
```sql
-- NEGATIVE TESTS (Should Fail)
-- Negative price violates CHECK constraint
INSERT INTO products (product_name, category_id, current_price, quantity_in_stock)
VALUES ('Yam Flour 5kg', 1, -500.00, 10);

-- Negative stock violates CHECK constraint
INSERT INTO products (product_name, category_id, current_price, quantity_in_stock)
VALUES ('Yam Flour 5kg', 1, 5000.00, -5);

-- Non-existent category_id violates Foreign Key
INSERT INTO products (product_name, category_id, current_price, quantity_in_stock)
VALUES ('Imported Tea', 999, 2500.00, 10);

-- POSITIVE TESTS (Should Pass)
-- Boundary values: zero price and zero stock (e.g., free samples out of stock)
INSERT INTO products (product_name, category_id, current_price, quantity_in_stock)
VALUES ('Promo Salt', 3, 0.00, 0);

-- Standard positive price and stock
INSERT INTO products (product_name, category_id, current_price, quantity_in_stock)
VALUES ('Flour 10kg', 1, 15000.50, 50);
```

## 4. Sales
```sql
-- NEGATIVE TESTS (Should Fail)
-- Negative total amount violates CHECK constraint
INSERT INTO sales (customer_id, total_amount)
VALUES (1, -100.00);

-- Non-existent customer_id violates Foreign Key
INSERT INTO sales (customer_id, total_amount)
VALUES (999, 5000.00);

-- POSITIVE TESTS (Should Pass)
-- Walk-in sale (customer_id is optional / NULL)
INSERT INTO sales (customer_id, total_amount)
VALUES (NULL, 14300.00);

-- Zero-total promotional giveaway sale
INSERT INTO sales (customer_id, total_amount)
VALUES (1, 0.00);

-- Valid sale linked to an existing customer
INSERT INTO sales (customer_id, total_amount)
VALUES (2, 25000.00);
```

## 5. Sale Items
```sql
-- NEGATIVE TESTS (Should Fail)
-- Quantity cannot be zero or negative
INSERT INTO sale_items (sale_id, product_id, quantity, unit_price)
VALUES (1, 1, 0, 95000.00);

-- Unit price cannot be negative
INSERT INTO sale_items (sale_id, product_id, quantity, unit_price)
VALUES (1, 1, 1, -10.00);

-- Non-existent sale_id violates Foreign Key
INSERT INTO sale_items (sale_id, product_id, quantity, unit_price)
VALUES (999, 1, 1, 1000.00);

-- POSITIVE TESTS (Should Pass)
-- Minimum quantity (1) with zero unit price (free promotional item)
INSERT INTO sale_items (sale_id, product_id, quantity, unit_price)
VALUES (1, 4, 1, 0.00);

-- Standard positive quantity and unit price
INSERT INTO sale_items (sale_id, product_id, quantity, unit_price)
VALUES (1, 4, 3, 2000.00);
```
## 6. Payments
```sql
-- NEGATIVE TESTS (Should Fail)
-- Amount must be strictly greater than 0
INSERT INTO payments (sale_id, amount, payment_method)
VALUES (1, 0.00, 'CASH');

-- Invalid payment method restricted by CHECK constraint
INSERT INTO payments (sale_id, amount, payment_method)
VALUES (1, 5000.00, 'CREDIT_CARD');

-- POSITIVE TESTS (Should Pass)
-- Minimum positive amount using CASH
INSERT INTO payments (sale_id, amount, payment_method)
VALUES (1, 0.01, 'CASH');

-- Valid TRANSFER payment method
INSERT INTO payments (sale_id, amount, payment_method)
VALUES (1, 5000.00, 'TRANSFER');

-- Valid POS payment method
INSERT INTO payments (sale_id, amount, payment_method)
VALUES (1, 12000.00, 'POS');
```

## 7. Inventory movements
```sql
-- NEGATIVE TESTS (Should Fail)
-- SALE movement missing a required sale_item_id
INSERT INTO inventory_movements (product_id, movement_type, quantity)
VALUES (1, 'SALE', 1);

-- STOCK_IN movement cannot reference a sale_item_id
INSERT INTO inventory_movements (product_id, sale_item_id, movement_type, quantity)
VALUES (1, 1, 'STOCK_IN', 10);

-- Quantity must be greater than zero
INSERT INTO inventory_movements (product_id, movement_type, quantity)
VALUES (1, 'STOCK_IN', 0);

-- Re-using an already linked sale_item_id violates UNIQUE constraint
INSERT INTO inventory_movements (product_id, sale_item_id, movement_type, quantity)
VALUES (1, 1, 'SALE', 1);

-- POSITIVE TESTS (Should Pass)
-- STOCK_IN movement with NULL sale_item_id
INSERT INTO inventory_movements (product_id, movement_type, quantity)
VALUES (1, 'STOCK_IN', 50);

-- ADJUSTMENT movement with NULL sale_item_id
INSERT INTO inventory_movements (product_id, movement_type, quantity)
VALUES (1, 'ADJUSTMENT', 2);

-- SALE movement with a fresh, unlinked sale_item_id (assuming sale_item_id 9 exists and is unused)
INSERT INTO inventory_movements (product_id, sale_item_id, movement_type, quantity)
VALUES (4, 9, 'SALE', 1);
```
