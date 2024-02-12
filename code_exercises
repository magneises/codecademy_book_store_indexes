-- EXERCISE 1
/*
SELECT *
FROM customers
LIMIT 10;

SELECT *
FROM orders
LIMIT 10;

SELECT *
FROM books
LIMIT 10;
*/

-- EXERCISE 2
/* primary key: first_name, last_name, email_address

Foreign key: customer_id, book_id
*/

-- EXERCISE 3
/*
You might have combined the two foreign keys into one multicolumn index, however, in this case, that might not be appropriate. The clue was that it was identified that the request for both columns together was not as frequent, meaning that the individual indexes would be faster. Because of this, the column you put second would be useless for searches on ones only for that column.
*/

-- EXERCISE 4
/*
EXPLAIN ANALYZE SELECT original_language, title, sales_in_millions
FROM books
WHERE original_language = 'French';
*/

-- EXERCISE 5
/*
SELECT pg_size_pretty (pg_total_relation_size('books'));
-- size: 56 KB
*/

-- EXERCISE 6
-- original langage, title, number of copies sold
/*
CREATE INDEX og_language_sold_idx ON books(original_language, title, sales_in_millions);


-- EXERCISE 7
SELECT pg_size_pretty (pg_total_relation_size('og_language_sold_idx'));
-- size: 32 KB

EXPLAIN ANALYZE SELECT og_language_sold_idx;

-- The lesson here is to always make sure you do your final testing in the environment that matters — your production database server.
*/

-- EXERCISE 8
/*
DROP INDEX IF EXISTS og_language_sold_idx;
*/

-- EXERCISE 9
SELECT NOW();
 
\COPY orders FROM 'orders_add.txt' DELIMITER ',' CSV HEADER;
 
SELECT NOW();

-- 2023-03-21 23:59:03.492089+00
-- 2023-03-21 23:59:03.8366+00

-- EXERCISE 11
/*
You honestly don’t have enough information at this point to say if it is a good or bad idea. In this very specific case, the size of the database probably doesn’t warrant it, but it also probably wouldn’t hurt much. So this might be a case where the little good/bad it causes might be worth it to make your boss happy.
You would need to see the specific queries your boss is using (or having someone else run) to get the information and do a comparison of the run times for these as well as other queries that use the customers table to see how they are also impacted.
You should think about what your boss is hoping to accomplish by doing this. You have had training now in what indexes are and what they are for. Most people have not. They may hear the jargon and just think it makes queries faster without knowing about any side effects. It would be your job to make sure you find out what they hope to accomplish and inform them on any possible consequences for it. For instance, your boss might want queries faster to get customer contact info. But if it impacts customers creating their own accounts, your boss might decide it is not worth it.
You might be able to make the index even more useful. You could find out if last_name should be included as well or if any other columns are regularly used along with this information.
Some downsides of creating this index are the increased size of the table and speed impacts on insert, update, and delete of records. In this case, these would directly impact your customers so it would be critical your boss is aware of this possible impact.
*/








