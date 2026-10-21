# Portfolio 3: Transactions and Concurrency

## 1. Introduction

This portfolio examines transaction management and concurrency control using the Adetwin Stores Point of Sale and Inventory Management System. The system supports product inventory, customer sales, sale items, payments, and inventory movements.

The practical work uses PostgreSQL to demonstrate transaction commitment, rollback, constraint enforcement, multi-table transactions, and concurrency control.

## 2. Objectives

- Demonstrate how `COMMIT` and `ROLLBACK` manage database changes.
- Test database constraints that protect data integrity.
- Use a transaction to coordinate related sales and inventory operations.
- Demonstrate a mechanism for preventing overselling.
- Explain transaction isolation and its effect on concurrent operations.

## 3. Implementation

The experiments use PostgreSQL SQL statements and the existing Adetwin Stores database. The SQL scripts are stored in the `sql` directory, while screenshots and query outputs are stored in `evidence`.

## 4. Expected Outcomes

The experiments should demonstrate that committed changes persist, uncommitted changes can be rolled back, invalid records are rejected by database constraints, and concurrent stock updates can be coordinated to prevent negative inventory.

## 5. Conclusion

Transaction management is important for maintaining reliable sales and inventory records. PostgreSQL transactions, integrity constraints, row-level locking, and suitable isolation levels help prevent incomplete operations and conflicting updates. The experiments also show that applications must handle errors and retry transactions when necessary.

