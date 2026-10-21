# Entity-Relationship (ER) Diagram

The Adetwin Stores database has six entities: `CUSTOMERS`, `PRODUCTS`,
`SALES`, `SALE_ITEMS`, `PAYMENTS`, and `INVENTORY_MOVEMENTS`.

## ER Diagram

``` mermaid
erDiagram
    CUSTOMERS o|--o{ SALES : makes
    CATEGORIES ||--o{ PRODUCTS : classifies
    SALES ||--|{ SALE_ITEMS : contains
    PRODUCTS ||--o{ SALE_ITEMS : appears_in
    SALES ||--o{ PAYMENTS : receives
    PRODUCTS ||--o{ INVENTORY_MOVEMENTS : has
    SALE_ITEMS o|--o| INVENTORY_MOVEMENTS : triggers

    CUSTOMERS {
        int customer_id PK
        varchar customer_name
        varchar phone
    }

    CATEGORIES {
        int category_id PK
        varchar category_name UK
    }

    PRODUCTS {
        int product_id PK
        varchar product_name
        int category_id FK
        numeric current_price
        int quantity_in_stock
    }

    SALES {
        int sale_id PK
        int customer_id FK
        timestamp sale_date
        numeric total_amount
    }

    SALE_ITEMS {
        int sale_item_id PK
        int sale_id FK
        int product_id FK
        int quantity
        numeric unit_price
    }

    PAYMENTS {
        int payment_id PK
        int sale_id FK
        numeric amount
        timestamp payment_date
        varchar payment_method
    }

    INVENTORY_MOVEMENTS {
        int movement_id PK
        int product_id FK
        int sale_item_id FK
        varchar movement_type
        int quantity
        timestamp movement_date
    }
```

## Relationship Summary

-   **Customers → Sales:** One customer can make multiple sales; a sale may have no linked customer for a walk-in purchase.
-   **Categories → Products:** One category can contain multiple products. Every product must belong to one category.
-   **Sales → Sale Items:** One sale contains one or more product lines.
-   **Products → Sale Items:** A product can appear in many sale items.
-   **Sales → Payments:** A sale can have no payments yet or multiple
    payments.
-   **Products → Inventory Movements:** A product can have multiple
    stock movements.
-   **Sale Items → Inventory Movements:** A sale item can trigger at
    most one inventory movement in this design.

`PK` means primary key, `FK` means foreign key and `UK` Unique key 
