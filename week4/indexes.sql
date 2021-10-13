-- retrieve all records from the pg_inexes tableSE
SELECT * FROM pg_indexes;


-- query tablename, indexname, and indexdef for non-default tables
-- notice that only our tables appear in the query due to primary key default index
SELECT tablename, indexname, indexdef FROM pg_indexes WHERE tablename NOT LIKE 'pg_%';


-- normal query without index takes about 130msec for 874 rows
SELECT artist FROM moma_works WHERE artist = 'Frank Lloyd Wright';

-- create the B-Tree index 
CREATE INDEX moma_works_btree_index ON moma_works(artist);

-- normal query with index takes about 95msec for 874 rows
SELECT artist FROM moma_works WHERE artist = 'Frank Lloyd Wright';

-- create a hash index for = 
CREATE INDEX moma_works_hash_index ON moma_works USING HASH (artist);

-- drop b-tree index
DROP INDEX moma_works_btree_index;