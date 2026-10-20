# Database Design and Relational Schema

The database design translates the ER diagram into six relational
tables. Each table has a primary key, and foreign keys connect related
records.


## Tables and Their Purposes

| Table | Purpose | Primary key |
|---|---|---|
| `customers` | Customer information | `customer_id` |
| `products` | Product details and current stock | `product_id` |
| `sales` | Receipt-level information | `sale_id` |
| `sale_items` | Products and quantities on each receipt | `sale_item_id` |
| `payments` | Payments received against sales | `payment_id` |
| `inventory_movements` | Stock movement history | `movement_id` |

## Relational Schema Notation

-   `PK` means primary key.
-   `FK` means foreign key.
-   `NN` means the value cannot be null.
-   `CHECK` means a value must satisfy a specified rule.
-   `UNIQUE` means duplicate values are not permitted in the constrained
    column or columns.

``` text
CUSTOMERS(
    customer_id PK,
    customer_name NN,
    phone
)

PRODUCTS(
    product_id PK,
    product_name NN,
    current_price CHECK (current_price >= 0),
    quantity_in_stock CHECK (quantity_in_stock >= 0)
)

SALES(
    sale_id PK,
    customer_id FK,
    sale_date NN,
    total_amount CHECK (total_amount >= 0)
)

SALE_ITEMS(
    sale_item_id PK,
    sale_id FK,
    product_id FK,
    quantity CHECK (quantity > 0),
    unit_price CHECK (unit_price >= 0)
)

PAYMENTS(
    payment_id PK,
    sale_id FK,
    amount CHECK (amount > 0),
    payment_date NN,
    payment_method NN
)

INVENTORY_MOVEMENTS(
    movement_id PK,
    product_id FK,
    sale_item_id FK UNIQUE,
    movement_type CHECK,
    quantity CHECK (quantity > 0),
    movement_date NN
)
```

## Key Design Decisions

-   `sales.customer_id` references `customers.customer_id`.
-   `sale_items.sale_id` references `sales.sale_id`.
-   `sale_items.product_id` references `products.product_id`.
-   `payments.sale_id` references `sales.sale_id`.
-   `inventory_movements.product_id` references `products.product_id`.
-   `inventory_movements.sale_item_id` optionally references
    `sale_items.sale_item_id`. It is unique when supplied so one sale
    item cannot be linked to multiple stock movements.

The current design requires every sale to have a customer record. This
can be revised if anonymous cash purchases must be supported. The
`sale_items.unit_price` stores the price charged at the time of sale,
even if the current product price changes later.

Outstanding balance is calculated as the sale total minus the sum of
payments received. The system must keep `sales.total_amount` consistent
with the sale items. Stock updates and inventory movement records must
also be handled together in a transaction.
