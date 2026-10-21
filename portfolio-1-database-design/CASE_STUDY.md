# Adetwin Stores POS and Inventory Management System

## Case Study

Adetwin Stores is a retail and wholesale business that sells packaged
foodstuff such as noodles, spaghetti, oils, and other grocery products. The
store needs a database system to manage its products, stock, sales,
customers, and payments.

The proposed Point of Sale (POS) and Inventory Management System will
store product information, record sales transactions, track the items
sold on each receipt, and maintain customer records. It will also
support cash and credit sales, including fully paid, partially paid, and
unpaid transactions. For credit sales, the system must identify the
customer, record each payment received, and calculate the outstanding
balance.

The system will track stock received, stock sold, and stock adjustments.
It will maintain current stock quantities and a history of inventory
movements to help the store monitor its stock and identify
discrepancies.

The purpose of the system is to improve record keeping, reduce errors,
make sales and payment information easier to retrieve, and support
better inventory management and business decisions.

## Intended Users

Cashiers: Record sales, products sold, and payments received.

Store managers: Review sales, monitor outstanding balances, and oversee store operations.

Inventory clerks: Maintain stock records, record stock received, and document inventory adjustments.

## Main Business Rules

1.  Each product has a unique product ID.
2.  A receipt can contain multiple products, and each product line
    records its quantity and selling price.
3.  Walk-in sales may have no customer record; if a customer ID is
supplied, it must refer to an existing customer. Credit sales must
be linked to a customer record.
4.  A sale can receive multiple payments, including partial payments.
5.  Outstanding balance equals the sale total minus payments received.
6.  Each inventory movement belongs to a product and records a stock
    change.
7.  Stock quantities cannot be negative.
8.  Recording a sale, its items, payment records, and related stock
    changes must be handled consistently.
9.  A category can contain many products.
