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

-- 3. List the names of students who have taken course v4 (crsCode).
EXPLAIN SELECT name FROM Student WHERE id IN (SELECT studId FROM Transcript WHERE crsCode = @v4);

-- Explanation
-- Bottleneck: The DB engine was reading all 100 rows in Student and Transcript table
-- Method of identification: Used EXPLAIN command to check execution plan. The 'type' column showed 'ALL' on all three rows
-- Resolution: Added index on column 'crs_Code' in table 'transcript'. The previous index on columns 'id' and 'name' in table 'student' was continued.
-- The number of rows read by engine reduced from 100 to 3.