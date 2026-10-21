## Performance Analysis

### Objective

The objective of this experiment was to examine PostgreSQL query execution plans and investigate whether indexes influenced the execution of selected queries in the Adetwin Stores database.

### Results

| Query | Index created? | Plan | Estimated rows | Actual rows | Rows removed by filter | Execution time |
|---|---|---|---|---|---|---|
| `product_id = 1` | Primary key | Index Scan using `products_pkey` | 1 | 1 | – | 0.009 ms |
| `product_name = 'Rice 50kg'` | Before | Seq Scan | 3 | 1 | 4 | 0.012 ms |
| `product_name = 'Rice 50kg'` | After | Seq Scan | 1 | 1 | 4 | 0.013 ms |
| `quantity_in_stock < 30` | Before | Seq Scan | 180 | 3 | 2 | 0.014 ms |
| `quantity_in_stock < 30` | After | Seq Scan | 2 | 3 | 2 | 0.026 ms |

#### Primary-key lookup

The query filtering by `product_id = 1` used an index scan through `products_pkey`. The index scan node reported an actual time of 0.003–0.004 milliseconds, and the total execution time was 0.009 milliseconds. One row was returned with a single index search, and two shared buffers were accessed.

#### Product-name search

The query filtering by `product_name = 'Rice 50kg'` used a sequential scan both before and after the additional index was created. In both runs, one row was returned and four rows were removed by the filter. The execution time was 0.012 milliseconds before indexing and 0.013 milliseconds after indexing.

#### Stock-quantity search

The query filtering by `quantity_in_stock < 30` also used a sequential scan both before and after the additional index was created. In both runs, three rows were returned and two were removed by the filter. The execution time was 0.014 milliseconds before indexing and 0.026 milliseconds after indexing.

#### Change in planner estimates

Although the scan type did not change, the planner's estimates did. Before the indexes were created, the planner estimated a cost of 16.75. It expected 3 rows for the product-name query and 180 rows for the stock query.

After the indexes were created, the estimated cost fell to 1.06. The row estimates became 1 and 2, which are much closer to the actual results.

This is consistent with PostgreSQL updating its stored table size information during index creation. Before that, the planner was working from default assumptions about the table's size rather than its real size.

Planning also accessed more buffers after the indexes existed: 24 compared with 8 for the product-name query. This suggests the planner considered the new indexes before deciding against them.

### Interpretation

The primary-key lookup demonstrated that PostgreSQL can use an index to locate a row efficiently. However, the product-name and stock-quantity searches continued to use sequential scans after the additional indexes were created.

The products table contained only five rows, which matches the returned and removed row counts in each plan. The whole table fits in a single buffer page (`Buffers: shared hit=1`). Reading that page directly is cheaper than first reading an index and then the table, so a sequential scan is the reasonable choice.

The differences in execution time do not show a meaningful performance change. The stock query was slower after indexing (0.026 ms versus 0.014 ms), even though it used the same plan. This confirms that differences at this scale reflect normal timing variation, not an effect of the index.

### Limitations

The experiment used a very small sample dataset. It therefore provides limited evidence about how the additional indexes would perform on a larger, more representative database.

Each query was also measured only once. The experiment did not establish a measurable performance improvement from the additional indexes. A larger dataset, repeated measurements, and consistent test conditions would be needed to evaluate such an improvement reliably.

### Conclusion

The experiment demonstrated the use of PostgreSQL execution plans, primary-key indexing, additional index creation, and performance interpretation. It showed that an index does not guarantee that the query planner will use it. It also showed that the planner's estimates depend on up-to-date table statistics.

Indexing decisions should be based on query patterns, data volume, selectivity, execution plans, and measured performance.
