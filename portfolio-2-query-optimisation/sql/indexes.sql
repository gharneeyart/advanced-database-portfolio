-- Indexing

-- Index on product name
CREATE INDEX idx_products_product_name
ON products (product_name);

-- Index on stock quantity
CREATE INDEX idx_products_quantity_in_stock
ON products (quantity_in_stock);

-- Verify indexes on the products table
SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'products'
ORDER BY indexname;
