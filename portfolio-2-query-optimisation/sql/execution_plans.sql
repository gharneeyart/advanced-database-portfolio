-- Query Execution Plans

-- Query 8: Lookup by primary key
EXPLAIN ANALYZE
SELECT
    product_id,
    product_name,
    current_price
FROM products
WHERE product_id = 1;


-- Query 9: Search by product name
EXPLAIN ANALYZE
SELECT
    product_id,
    product_name,
    current_price
FROM products
WHERE product_name = 'Rice 50kg';


-- Query 10: Search by stock quantity
EXPLAIN ANALYZE
SELECT
    product_name,
    quantity_in_stock
FROM products
WHERE quantity_in_stock < 30;
