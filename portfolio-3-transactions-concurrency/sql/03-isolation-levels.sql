BEGIN TRANSACTION
ISOLATION LEVEL REPEATABLE READ;

SELECT product_name, quantity_in_stock
FROM products
WHERE product_id = 1;

SELECT product_name, quantity_in_stock
FROM products
WHERE product_id = 1;

COMMIT;

-- To demonstrate the isolation effect

BEGIN TRANSACTION
ISOLATION LEVEL REPEATABLE READ;

SELECT quantity_in_stock
FROM products
WHERE product_id = 1;

UPDATE products
SET quantity_in_stock = quantity_in_stock - 1
WHERE product_id = 1
  AND quantity_in_stock > 0;

COMMIT;

SELECT quantity_in_stock
FROM products
WHERE product_id = 1;

COMMIT;
