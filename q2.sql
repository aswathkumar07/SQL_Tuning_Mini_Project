USE springboardopt;

-- -------------------------------------
SET @v1 = 1612521;
SET @v2 = 1145072;
SET @v3 = 1828467;
SET @v4 = 'MGT382';
SET @v5 = 'Amber Hill';
SET @v6 = 'MGT';
SET @v7 = 'EE';			  
SET @v8 = 'MAT';

-- 2. List the names of students with id in the range of v2 (id) to v3 (inclusive).
EXPLAIN
SELECT name FROM Student WHERE id = @v2 OR id = @v3;

-- Explanation
-- Bottleneck: The DB engine was going through all rows and all columns despite having index on column 'id'
-- Method of identification: Used EXPLAIN command to check execution plan. The 'type' column showed 'ALL'
-- Resolution: 
-- 1. Dropped the previous 'UNIQUE' INDEX on column 'id'. Added INDEX on columns 'id' and 'name'. 
-- 2. Modified the WHERE clause by removing BETWEEN statement and adding OR operator.
-- On running the execution plan, the 'type' column showed 'range'