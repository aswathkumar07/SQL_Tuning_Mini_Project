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

-- 1. List the name of the student with id equal to v1 (id).
EXPLAIN
SELECT name FROM Student WHERE id = @v1;

-- Explanation: 
-- Bottleneck: The DB engine was going through all rows and all columns
-- Method of identification: Used EXPLAIN command to check execution plan. The 'type' column showed 'ALL'
-- Resolution: Added 'UNIQUE' INDEX on column 'id'. On running the execution plan, the 'type' column showed 'CONST'