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

-- 6. List the names of students who have taken all courses offered by department v8 (deptId).
EXPLAIN
SELECT name FROM Student,
	(SELECT studId
	FROM Transcript
		WHERE crsCode IN
		(SELECT crsCode FROM Course WHERE deptId = @v8 AND crsCode IN (SELECT crsCode FROM Teaching))
		GROUP BY studId
		HAVING COUNT(*) = 
			(SELECT COUNT(*) FROM Course WHERE deptId = @v8 AND crsCode IN (SELECT crsCode FROM Teaching))) as alias
WHERE id = alias.studId;

-- Explanation
-- Bottleneck: The DB engine was reading all 100 rows 5 times during the execution
-- Method of identification: Used EXPLAIN command to check execution plan. The 'type' column showed 'ALL' on 5 rows
-- Resolution: Added index for columns 'crsCode' and 'deptId' in table 'course'. This reduced the 'ALL' type to just 2 rows compared to 5 rows earlier.