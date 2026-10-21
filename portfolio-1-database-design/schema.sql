CREATE TABLE customers (
    customer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20)
);

CREATE TABLE products (
    product_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    current_price NUMERIC(12, 2) NOT NULL
        CHECK (current_price >= 0),
    quantity_in_stock INTEGER NOT NULL DEFAULT 0
        CHECK (quantity_in_stock >= 0)
);

CREATE TABLE sales (
    sale_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INTEGER NOT NULL
        REFERENCES customers(customer_id),
    sale_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(12, 2) NOT NULL
        CHECK (total_amount >= 0)
);

CREATE TABLE sale_items (
    sale_item_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sale_id INTEGER NOT NULL
        REFERENCES sales(sale_id),
    product_id INTEGER NOT NULL
        REFERENCES products(product_id),
    quantity INTEGER NOT NULL
        CHECK (quantity > 0),
    unit_price NUMERIC(12, 2) NOT NULL
        CHECK (unit_price >= 0)
);

CREATE TABLE payments (
    payment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sale_id INTEGER NOT NULL
        REFERENCES sales(sale_id),
    amount NUMERIC(12, 2) NOT NULL
        CHECK (amount > 0),
    payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(20) NOT NULL
        CHECK (payment_method IN ('CASH', 'TRANSFER', 'POS'))
);

CREATE TABLE inventory_movements (
    movement_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id INTEGER NOT NULL
        REFERENCES products(product_id),
    sale_item_id INTEGER UNIQUE
        REFERENCES sale_items(sale_item_id),
    movement_type VARCHAR(20) NOT NULL
        CHECK (movement_type IN ('STOCK_IN', 'SALE', 'ADJUSTMENT')),
    quantity INTEGER NOT NULL
        CHECK (quantity > 0),
    movement_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (
        (movement_type = 'SALE' AND sale_item_id IS NOT NULL)
        OR
        (movement_type IN ('STOCK_IN', 'ADJUSTMENT')
         AND sale_item_id IS NULL)
    )
);
