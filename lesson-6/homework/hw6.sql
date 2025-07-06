-- ✅ METHOD 1: Normalize using CASE and get DISTINCT
SELECT DISTINCT
    CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
    CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl;

-- ✅ METHOD 2: Use a sorted concatenated key, then extract values
SELECT DISTINCT
    LEFT(Normalized, CHARINDEX('|', Normalized) - 1) AS col1,
    RIGHT(Normalized, LEN(Normalized) - CHARINDEX('|', Normalized)) AS col2
FROM (
    SELECT CASE
              WHEN col1 < col2 THEN col1 + '|' + col2
              ELSE col2 + '|' + col1
           END AS Normalized
    FROM InputTbl
) AS Pairs;

tack 2

-- Puzzle 2: Remove rows where ALL values are 0 from TestMultipleZero
SELECT * 
FROM TestMultipleZero
WHERE COALESCE(A,0) + COALESCE(B,0) + COALESCE(C,0) + COALESCE(D,0) > 0;

-- Puzzle 3: Find rows in section1 where ID is ODD
SELECT * 
FROM section1
WHERE id % 2 = 1;

tack 3

-- ✅ Puzzle 4: Person with the smallest id
SELECT TOP 1 *
FROM section1
ORDER BY id ASC;

-- ✅ Puzzle 5: Person with the highest id
SELECT TOP 1 *
FROM section1
ORDER BY id DESC;

-- ✅ Puzzle 6: People whose name starts with 'b' or 'B'
SELECT *
FROM section1
WHERE name LIKE 'b%';

-- ✅ Puzzle 7: Codes that contain a literal underscore '_'
SELECT *
FROM ProductCodes
WHERE Code LIKE '%[_]%';
