# Normalisation of the Adetwin Stores Database

## 1. Introduction

Database normalisation is the process of structuring database tables to reduce unnecessary duplication and prevent insertion, update, and deletion anomalies.

The Adetwin Stores database applies First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF).

## 2. First Normal Form (1NF)

A table is in First Normal Form when each column contains a single, atomic value and there are no repeating groups.

For example, a sale may contain rice, sugar, and beans. These products should not be stored in separate repeating columns in the SALES table.

Instead, the sale is recorded in SALES, and each product purchased is recorded as a separate row in SALE_ITEMS.

This design allows a sale to contain any number of items without changing the table structure.

## 3. Second Normal Form (2NF)

A table is in Second Normal Form when it is in 1NF and every non-key attribute depends on the whole candidate key, rather than only part of a composite candidate key.

The Adetwin Stores tables use single-column primary keys, such as product_id, sale_id, and sale_item_id. Therefore, there are no partial dependencies on a composite primary key in the chosen design.

For example, SALE_ITEMS stores the quantity and unit_price for a particular sale item. These values describe that specific sale-item record.

The unit_price is stored in SALE_ITEMS because the price charged in a transaction should remain available even if the current product price changes later.

## 4. Third Normal Form (3NF)

A table is in Third Normal Form when it is in 2NF and non-key attributes do not depend transitively on a key through another non-key attribute.

The separate CATEGORIES table helps achieve this structure.

If category names were stored directly in PRODUCTS, the same category name would be repeated across many product records. By creating CATEGORIES, the category name is stored once and PRODUCTS references it using category_id.

For example:

**CATEGORIES**

| category_id | category_name |
|---:|---|
| 1 | Grains |
| 2 | Cooking Oil |
| 3 | Groceries |

**PRODUCTS**

| product_id | product_name | category_id |
|---:|---|---:|
| 1 | Rice 50kg | 1 |
| 2 | Beans 25kg | 1 |
| 3 | Vegetable Oil 5L | 2 |

The product table stores the category reference, while the category table stores the category name.

Similarly, customer details are stored in CUSTOMERS rather than being repeatedly stored in every sale. Payment records are separated from SALES so a transaction can have multiple payments.

## 5. Benefits of Normalisation

The design provides the following benefits:

1. **Reduced duplication:** Category and customer details are stored separately from transaction records.
2. **Improved consistency:** Foreign keys prevent products from referencing nonexistent categories.
3. **Easier maintenance:** Category names can be updated in one place.
4. **Flexible transactions:** Sale items and payments can be recorded as separate rows.
5. **Historical accuracy:** Sale-item prices are preserved independently of current product prices.

## 6. Conclusion

The Adetwin Stores database uses normalisation principles to organise its data into related tables. Separating categories, products, customers, sales, sale items, payments, and inventory movements reduces unnecessary duplication and supports the store's operational requirements.
