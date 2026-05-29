SELECT * FROM library.sale;

-- 1. Total sales per employee (Running Total)
SELECT id,
       sale_date,
       sales_amount,
       SUM(sales_amount) OVER(
           PARTITION BY id
           ORDER BY sale_date
       ) AS running_total
FROM sale;

-- 2. Row number per employee
SELECT id,
       sale_date,
       sales_amount,
       ROW_NUMBER() OVER(
           PARTITION BY id
           ORDER BY sale_date
       ) AS row_num
FROM sale;

-- 3. Rank of sales per department
SELECT department,
       id,
       sales_amount,
       RANK() OVER(
           PARTITION BY department
           ORDER BY sales_amount DESC
       ) AS sales_rank
FROM sale;

-- 4. Lead (next sale) per employee
SELECT id,
       sale_date,
       sales_amount,
       LEAD(sales_amount) OVER(
           PARTITION BY id
           ORDER BY sale_date
       ) AS next_sale
FROM sale;


-- 5. Lag (previous sale) per employee
SELECT id,
       sale_date,
       sales_amount,
       LAG(sales_amount) OVER(
           PARTITION BY id
           ORDER BY sale_date
       ) AS previous_sale
FROM sale;


-- 6. Average sales per employee
SELECT id,
       sale_date,
       sales_amount,
       AVG(sales_amount) OVER(
           PARTITION BY id
       ) AS avg_sales
FROM sale;


-- 7. First and last sales per employee
SELECT id,
       sale_date,
       sales_amount,
       FIRST_VALUE(sales_amount) OVER(
           PARTITION BY id
           ORDER BY sale_date
       ) AS first_sale,
       
       LAST_VALUE(sales_amount) OVER(
           PARTITION BY id
           ORDER BY sale_date
           ROWS BETWEEN UNBOUNDED PRECEDING 
           AND UNBOUNDED FOLLOWING
       ) AS last_sale
FROM sale;


-- 8. Dense rank (no gaps)
SELECT id,
       sales_amount,
       DENSE_RANK() OVER(
           ORDER BY sales_amount DESC
       ) AS dense_rank_no_gaps
FROM sale;


-- 9. Cumulative average per employee
SELECT id,
       sale_date,
       sales_amount,
       AVG(sales_amount) OVER(
           PARTITION BY id
           ORDER BY sale_date
       ) AS cumulative_avg
FROM sale;


-- 10. Find highest sale per employee
SELECT id,
       sale_date,
       sales_amount,
       MAX(sales_amount) OVER(
           PARTITION BY id
       ) AS highest_sale
FROM sale;


-- 11. Sales difference from previous record
SELECT id,
       sale_date,
       sales_amount,
       sales_amount - LAG(sales_amount) OVER(
           PARTITION BY id
           ORDER BY sale_date
       ) AS sales_difference
FROM sale;


-- 12. Cumulative count of sales per employee
SELECT id,
       sale_date,
       sales_amount,
       COUNT(*) OVER(
           PARTITION BY id
           ORDER BY sale_date
       ) AS cumulative_count
FROM sale;


-- 13. Show if sale is above average per employee
SELECT id,
       sale_date,
       sales_amount,
       AVG(sales_amount) OVER(
           PARTITION BY id
       ) AS avg_sales,
       
       CASE
           WHEN sales_amount >
                AVG(sales_amount) OVER(PARTITION BY id)
           THEN 'Above Average'
           ELSE 'Below Average'
       END AS sale_status
FROM sale;


-- 14. Find second highest sale per employee
SELECT id,
       sales_amount
FROM (
    SELECT id,
           sales_amount,
           DENSE_RANK() OVER(
               PARTITION BY id
               ORDER BY sales_amount DESC
           ) AS rank_num
    FROM sale
) AS ranked_sales
WHERE rank_num = 2;

