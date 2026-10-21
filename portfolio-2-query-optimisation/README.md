# Portfolio 2: Query Processing and Optimisation

## Overview

This portfolio investigates SQL query processing and optimisation using the Adetwin Stores database. It covers business queries, execution-plan analysis, index creation, and performance evaluation.

## Contents

- `sql/business_queries.sql` — seven business queries for sales, products, inventory and payments.
- `EXECUTION_PLANS.md` — execution-plan tests using `EXPLAIN ANALYZE`.
- `sql/indexes.sql` — additional index creation and index verification.
- `evidence/` — screenshots of actual query results and index verification output.
- `performance-analysis.md` — interpretation of the experiments and their limitations.

## Key Findings

- PostgreSQL used the primary-key index for a lookup by `product_id`.
- PostgreSQL selected sequential scans for the tested product-name and stock-quantity filters.
- Additional indexes were created and verified.
- The small sample dataset did not demonstrate a measurable performance improvement from the additional indexes.

## Reproducing the Experiments

1. Create the database schema using the Portfolio 1 SQL script.
2. Load the Portfolio 1 seed data.
3. Execute `sql/business_queries.sql`.
4. Execute `sql/indexes.sql` if the additional indexes do not already exist.
5. Execute `sql/execution_plans.sql`.
6. Compare the execution plans with the findings in `performance-analysis.md`.

## Evidence

The `evidence/` folder should contain screenshots of the actual DB Fiddle query results and index verification output.

## Conclusion

This portfolio demonstrates practical SQL querying, PostgreSQL execution-plan interpretation, and index evaluation. The findings highlight the importance of choosing indexes based on actual workloads and measured performance.
