-- Query 1: Products, categories, prices and stock
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.current_price,
    p.quantity_in_stock
FROM products p
JOIN categories c ON p.category_id = c.category_id
ORDER BY p.product_name;


-- Query 2: Sales records
SELECT
    sale_id,
    sale_date,
    total_amount
FROM sales
ORDER BY sale_date;


-- Query 3: Outstanding balances
SELECT
    s.sale_id,
    c.customer_name,
    s.total_amount,
    COALESCE(SUM(p.amount), 0) AS amount_paid,
    s.total_amount - COALESCE(SUM(p.amount), 0)
        AS outstanding_balance
FROM sales s
LEFT JOIN customers c ON s.customer_id = c.customer_id
LEFT JOIN payments p ON s.sale_id = p.sale_id
GROUP BY s.sale_id, c.customer_name, s.total_amount
ORDER BY s.sale_id;


-- Query 4: Products ranked by stock quantity
SELECT
    p.product_name,
    c.category_name,
    p.quantity_in_stock
FROM products p
JOIN categories c ON p.category_id = c.category_id
ORDER BY p.quantity_in_stock DESC;


-- Query 5: Total estimated inventory selling value
SELECT
    SUM(current_price * quantity_in_stock)
        AS total_inventory_value
FROM products;


-- Query 6: Sales summary
SELECT
    COUNT(*) AS total_sales,
    SUM(total_amount) AS total_recorded_sales,
    AVG(total_amount) AS average_sale_amount
FROM sales;


-- Query 7: Collections by payment method
SELECT
    payment_method,
    COUNT(*) AS number_of_payments,
    SUM(amount) AS total_collected
FROM payments
GROUP BY payment_method
ORDER BY total_collected DESC;
