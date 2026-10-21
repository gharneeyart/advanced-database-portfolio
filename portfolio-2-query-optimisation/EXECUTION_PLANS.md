## Experiment 1: Search by product name
### BEFORE creating the index
```sql
EXPLAIN ANALYZE
SELECT
    product_id,
    product_name,
    current_price
FROM products
WHERE product_name = 'Rice 50kg';
```
<img width="1508" height="517" alt="Screenshot 2026-10-21 at 17 12 21" src="https://github.com/user-attachments/assets/386ad8a5-0161-4162-b36d-9ad04b25f93c" />

### AFTER creating the index
```sql
CREATE INDEX IF NOT EXISTS idx_products_product_name
ON products (product_name);

EXPLAIN ANALYZE
SELECT
    product_id,
    product_name,
    current_price
FROM products
WHERE product_name = 'Rice 50kg';
```
<img width="1507" height="576" alt="Screenshot 2026-10-21 at 17 18 24" src="https://github.com/user-attachments/assets/4a51b40f-4e08-43b4-b7fe-6d091ae280db" />

## Experiment 2: Search by stock quantity
### BEFORE creating the index
```sql

EXPLAIN ANALYZE
SELECT
    product_name,
    quantity_in_stock
FROM products
WHERE quantity_in_stock < 30;
```
<img width="1503" height="371" alt="Screenshot 2026-10-21 at 17 22 02" src="https://github.com/user-attachments/assets/b4a5f053-7a50-47b2-aaf0-9ce4ba0938cf" />

### AFTER creating the index
```sql
CREATE INDEX IF NOT EXISTS idx_products_quantity_in_stock
ON products (quantity_in_stock);

EXPLAIN ANALYZE
SELECT
    product_name,
    quantity_in_stock
FROM products
WHERE quantity_in_stock < 30;
```
<img width="1511" height="578" alt="Screenshot 2026-10-21 at 17 24 12" src="https://github.com/user-attachments/assets/ff08732b-5fb0-4c78-8685-bfecef6de20b" />









