-- asking for dates of artwork acquired in the 1950s using EXPLAIN

-- EXPLAIN shows since there is no index on date_acquired, Postgres has to scan every row applying the date_acquired filter as it goes
EXPLAIN SELECT date_acquired FROM moma_works 
WHERE date_acquired BETWEEN '1950-01-01' AND '1959-12-31';


-- using EXPLAIN ANALYZE
-- this shows the rows removed, planning time and execution time
EXPLAIN ANALYZE SELECT date_acquired 
FROM moma_works 
WHERE date_acquired 
BETWEEN '1950-01-01' AND '1959-12-31';


-- notice that the above should be an index since it is between <= and >=
CREATE INDEX date_acq_idx ON moma_works(date_acquired);

EXPLAIN ANALYZE SELECT date_acquired 
FROM moma_works 
WHERE date_acquired 
BETWEEN '1950-01-01' AND '1959-12-31';
