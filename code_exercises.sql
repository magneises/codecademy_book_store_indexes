-- EXERCISE 1
-- Before we start having fun with the database, familiarize yourself with what we are starting with, look at the first 10 rows in each table; customers, orders, 
-- and books to get a feel for what is in each.

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
-- Before you make any changes to a database and its tables, you should know what you are working with. 
-- Examine the indexes that already exist on the three tables customers, books, and orders.

/* primary key: first_name, last_name, email_address

Foreign key: customer_id, book_id
*/

-- EXERCISE 3
-- You might have combined the two foreign keys into one multicolumn index, however, in this case, that might not be appropriate. The clue was that it was 
-- identified that the request for both columns together was not as frequent, meaning that the individual indexes would be faster. Because of this, the 
-- column you put second would be useless for searches on ones only for that column.


-- EXERCISE 4
/*We are about to create a multicolumn index, but before we do let’s get some information prepared to make sure we are ready to analyze if it was a good or bad index to create.
Use EXPLAIN ANALYZE to check the runtime of a query searching for the original_language, title, and sales_in_millions from the books table that have an original_language of 'French'. */

/*
EXPLAIN ANALYZE SELECT original_language, title, sales_in_millions
FROM books
WHERE original_language = 'French';
*/

-- EXERCISE 5
/*Remember, runtime isn’t the only impact that indexes have, they also impact the size of your table, so let’s get the size of the books table using*/

/*
SELECT pg_size_pretty (pg_total_relation_size('books'));
-- size: 56 KB
*/

-- EXERCISE 6
/*
Now let’s take a look at the situation you were preparing for. Your translation team needs a list of the language they are written in, book titles, 
and the number of copies sold to see if it is worth the time and money in translating these books. Create an index to help speed up searching for this information.*/

-- original langage, title, number of copies sold
/*
CREATE INDEX og_language_sold_idx ON books(original_language, title, sales_in_millions);


-- EXERCISE 7
/*Now that you have your index let’s repeat our process in tasks 1 and 2 and compare the runtime and size with our index in place. 
To make a true assessment you would also have to look at other impacts of an index such as the impact on INSERT, UPDATE, and DELETE statements on the table. 
With just the size and runtime of this query, do you think this is a useful index?*/

SELECT pg_size_pretty (pg_total_relation_size('og_language_sold_idx'));
-- size: 32 KB

EXPLAIN ANALYZE SELECT og_language_sold_idx;

-- The lesson here is to always make sure you do your final testing in the environment that matters — your production database server.
*/

-- EXERCISE 8
/*After running your site for a while, you find that you’re often inserting new books into your books table as new books get released. 
However, many of these books don’t sell enough copies to be worth translating, so your index has proven to be more costly than beneficial. 
Delete the multicolumn index we created above to make it so inserts into the books will run quickly.*/

/*
DROP INDEX IF EXISTS og_language_sold_idx;
*/
-- EXERCISE 9
/* The company you work for has bought out a competitor bookstore. You will need to load all of their orders into your orders table with a bulk copy. 
Let’s see how long this bulk insert will take. Since the syntax on how to do this was not part of the lesson, here is the script that will take the data 
in the file orders_add.txt and insert the records into the orders table.*/
/*


SELECT NOW();
 
\COPY orders FROM 'orders_add.txt' DELIMITER ',' CSV HEADER;
 
SELECT NOW();

-- EXERCISE 10

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








