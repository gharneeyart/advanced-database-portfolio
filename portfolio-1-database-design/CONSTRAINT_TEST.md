#Constraints Tests
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
<img width="1286" height="471" alt="Screenshot 2026-10-21 at 12 44 43" src="https://github.com/user-attachments/assets/398c64bd-9969-4a17-b6d4-640ba35aa18e" />
<img width="1280" height="551" alt="Screenshot 2026-10-21 at 12 56 43" src="https://github.com/user-attachments/assets/cc1b1774-8724-424b-9dc1-a49df37dbf87" />


## 3. Product
```sql
-- NEGATIVE TESTS
-- Negative price violates CHECK constraint
INSERT INTO products (product_name, category_id, current_price, quantity_in_stock)
VALUES ('Yam Flour 5kg', 1, -500.00, 10);

-- Negative stock violates CHECK constraint
INSERT INTO products (product_name, category_id, current_price, quantity_in_stock)
VALUES ('Yam Flour 5kg', 1, 5000.00, -5);

-- Non-existent category_id violates Foreign Key
INSERT INTO products (product_name, category_id, current_price, quantity_in_stock)
VALUES ('Imported Tea', 999, 2500.00, 10);

-- POSITIVE TESTS
-- Boundary values: zero price and zero stock (e.g., free samples out of stock)
INSERT INTO products (product_name, category_id, current_price, quantity_in_stock)
VALUES ('Promo Salt', 3, 0.00, 0);

-- Standard positive price and stock
INSERT INTO products (product_name, category_id, current_price, quantity_in_stock)
VALUES ('Flour 10kg', 1, 15000.50, 50);
```
<img width="1282" height="628" alt="Screenshot 2026-10-21 at 12 57 50" src="https://github.com/user-attachments/assets/4e110311-f057-4377-97f6-27ba2522257d" />
<img width="1245" height="702" alt="Screenshot 2026-10-21 at 12 59 45" src="https://github.com/user-attachments/assets/efcd4c38-292b-4135-a6c1-0c27b4f13bcc" />


## 4. Sales
```sql
-- NEGATIVE TESTS 
-- Negative total amount violates CHECK constraint
INSERT INTO sales (customer_id, total_amount)
VALUES (1, -100.00);

-- Non-existent customer_id violates Foreign Key
INSERT INTO sales (customer_id, total_amount)
VALUES (999, 5000.00);

-- POSITIVE TESTS 
-- Walk-in sale (customer_id is optional / NULL)
INSERT INTO sales (customer_id, total_amount)
VALUES (NULL, 14300.00);

-- Valid sale linked to an existing customer
INSERT INTO sales (customer_id, total_amount)
VALUES (2, 25000.00);
```
<img width="1284" height="559" alt="Screenshot 2026-10-21 at 13 01 44" src="https://github.com/user-attachments/assets/f4c70095-3bce-4456-a890-686294346d99" />
<img width="1250" height="697" alt="Screenshot 2026-10-21 at 13 04 52" src="https://github.com/user-attachments/assets/dd9331ca-6398-4586-87a4-6d17e267c32e" />


## 5. Sale Items
```sql
-- NEGATIVE TESTS 
-- Quantity cannot be zero or negative
INSERT INTO sale_items (sale_id, product_id, quantity, unit_price)
VALUES (1, 1, 0, 95000.00);

-- Unit price cannot be negative
INSERT INTO sale_items (sale_id, product_id, quantity, unit_price)
VALUES (1, 1, 1, -10.00);

-- Non-existent sale_id violates Foreign Key
INSERT INTO sale_items (sale_id, product_id, quantity, unit_price)
VALUES (999, 1, 1, 1000.00);

-- POSITIVE TESTS
-- Minimum quantity (1) with zero unit price 
INSERT INTO sale_items (sale_id, product_id, quantity, unit_price)
VALUES (1, 4, 1, 0.00);

-- Standard positive quantity and unit price
INSERT INTO sale_items (sale_id, product_id, quantity, unit_price)
VALUES (1, 4, 3, 2000.00);
```
<img width="1283" height="630" alt="Screenshot 2026-10-21 at 13 08 03" src="https://github.com/user-attachments/assets/9a2787bb-60d1-4182-9c55-0b7b5f6da185" />
<img width="1215" height="722" alt="Screenshot 2026-10-21 at 13 10 22" src="https://github.com/user-attachments/assets/b56745aa-ea42-4b02-97d2-8f02c8fbc33c" />


## 6. Payments
```sql
-- NEGATIVE TESTS
-- Amount must be strictly greater than 0
INSERT INTO payments (sale_id, amount, payment_method)
VALUES (1, 0.00, 'CASH');

-- Invalid payment method restricted by CHECK constraint
INSERT INTO payments (sale_id, amount, payment_method)
VALUES (1, 5000.00, 'CREDIT_CARD');

-- POSITIVE TESTS 
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
<img width="1289" height="550" alt="Screenshot 2026-10-21 at 13 23 17" src="https://github.com/user-attachments/assets/9ba88026-74a7-4b80-b35d-8c31de363bdc" />
<img width="1366" height="514" alt="Screenshot 2026-10-21 at 13 27 16" src="https://github.com/user-attachments/assets/2b62727a-7895-4f55-a907-203e01cd5c96" />



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

-- POSITIVE TESTS 
-- Step 1: Create a new sale
INSERT INTO sales (customer_id, total_amount) 
VALUES (1, 2000.00); 

-- Step 2: Create a new sale_item linked to that new sale and an existing product (e.g., product_id 4)
INSERT INTO sale_items (sale_id, product_id, quantity, unit_price) 
VALUES (5, 4, 1, 2000.00); 

-- Step 3: Now successfully run the inventory movement for that new sale item
INSERT INTO inventory_movements (product_id, sale_item_id, movement_type, quantity)
VALUES (4, 9, 'SALE', 1);
```
<img width="1289" height="662" alt="Screenshot 2026-10-21 at 13 30 50" src="https://github.com/user-attachments/assets/30a07dac-a066-42f1-bc65-2e07ea054de5" />
<img width="1442" height="484" alt="Screenshot 2026-10-21 at 13 37 57" src="https://github.com/user-attachments/assets/c5e4ce0a-dcf2-44fc-b19d-5fc46e2a3b08" />


