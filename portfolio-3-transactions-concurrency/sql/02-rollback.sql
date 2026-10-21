BEGIN;

UPDATE products
SET quantity_in_stock = quantity_in_stock + 1
WHERE product_id = 1
RETURNING product_name, quantity_in_stock;

ROLLBACK;

SELECT product_name, quantity_in_stock
FROM products
WHERE product_id = 1;
