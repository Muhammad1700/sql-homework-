-- 1. Output "100-Steven King" using emp_id + first_name + last_name
SELECT CAST(EMPLOYEE_ID AS VARCHAR) + '-' + FIRST_NAME + ' ' + LAST_NAME AS Result
FROM Employees
WHERE EMPLOYEE_ID = 100;

-- 2. Replace '124' with '999' in phone_number column
UPDATE Employees
SET PHONE_NUMBER = REPLACE(PHONE_NUMBER, '124', '999');

-- 3. First name and its length for names starting with A, J, or M
SELECT FIRST_NAME, LEN(FIRST_NAME) AS NameLength
FROM Employees
WHERE FIRST_NAME LIKE 'A%' OR FIRST_NAME LIKE 'J%' OR FIRST_NAME LIKE 'M%'
ORDER BY FIRST_NAME;

-- 4. Total salary for each manager ID
SELECT MANAGER_ID, SUM(SALARY) AS TotalManagerSalary
FROM Employees
GROUP BY MANAGER_ID;

-- 5. Highest value from Max1, Max2, Max3 columns in TestMax table (per row)
SELECT YEAR, 
       GREATEST(Max1, Max2, Max3) AS HighestValue
FROM TestMax;

-- 6. Odd-numbered movies with non-boring descriptions
SELECT MovieID, Title, Description
FROM Cinema
WHERE MovieID % 2 = 1 AND Description <> 'boring';

-- 7. Sort by Id but put Id = 0 last
SELECT *
FROM SingleOrder
ORDER BY CASE WHEN Id = 0 THEN 1 ELSE 0 END, Id;

-- 8. First non-null value from multiple columns
SELECT 
    COALESCE(col1, col2, col3, col4) AS FirstNonNull
FROM Person;

tack 2

-- 1. Split FullName into Firstname, Middlename, and Lastname
SELECT 
    FullName,
    PARSENAME(REPLACE(FullName, ' ', '.'), 3) AS Firstname,
    PARSENAME(REPLACE(FullName, ' ', '.'), 2) AS Middlename,
    PARSENAME(REPLACE(FullName, ' ', '.'), 1) AS Lastname
FROM Students;

-- 2. For customers who had deliveries to California, show their orders to Texas
SELECT *
FROM Orders O1
WHERE O1.CustomerID IN (
    SELECT CustomerID
    FROM Orders
    WHERE DeliveryState = 'California'
)
AND O1.DeliveryState = 'Texas';

-- 3. Group concatenate values from DMLTable
SELECT Category,
       STRING_AGG(Value, ', ') AS ConcatenatedValues
FROM DMLTable
GROUP BY Category;

-- 4. Employees whose full name (First + Last) has ≥ 3 letter 'a's
SELECT FIRST_NAME + ' ' + LAST_NAME AS FullName,
       LEN(LOWER(FIRST_NAME + LAST_NAME)) - LEN(REPLACE(LOWER(FIRST_NAME + LAST_NAME), 'a', '')) AS ACount
FROM Employees
WHERE LEN(LOWER(FIRST_NAME + LAST_NAME)) - LEN(REPLACE(LOWER(FIRST_NAME + LAST_NAME), 'a', '')) >= 3;

-- 5. Total employees and percentage with >3 years in company per department
SELECT D.DEPARTMENT_ID,
       COUNT(E.EMPLOYEE_ID) AS TotalEmployees,
       ROUND(100.0 * SUM(CASE WHEN DATEDIFF(YEAR, E.HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) / COUNT(E.EMPLOYEE_ID), 2) AS PercentageOver3Years
FROM Employees E
INNER JOIN Departments D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_ID;

-- 6. Most and least experienced Spacemen per job description
SELECT JOB_ID,
       MIN(DATEDIFF(YEAR, HIRE_DATE, GETDATE())) AS LeastExperience,
       MAX(DATEDIFF(YEAR, HIRE_DATE, GETDATE())) AS MostExperience
FROM Personal
GROUP BY JOB_ID;

tack 3

-- 1. Split FullName into Firstname, Middlename, and Lastname
SELECT 
    FullName,
    PARSENAME(REPLACE(FullName, ' ', '.'), 3) AS Firstname,
    PARSENAME(REPLACE(FullName, ' ', '.'), 2) AS Middlename,
    PARSENAME(REPLACE(FullName, ' ', '.'), 1) AS Lastname
FROM Students;

-- 2. Customer orders to Texas — but only if they’ve had deliveries to California
SELECT *
FROM Orders O1
WHERE O1.CustomerID IN (
    SELECT CustomerID
    FROM Orders
    WHERE DeliveryState = 'California'
)
AND O1.DeliveryState = 'Texas';

-- 3. Group concatenate values from DMLTable
SELECT Category,
       STRING_AGG(Value, ', ') AS ConcatenatedValues
FROM DMLTable
GROUP BY Category;

-- 4. Employees whose full name (First + Last) contains ≥ 3 letter 'a's
SELECT FIRST_NAME + ' ' + LAST_NAME AS FullName
FROM Employees
WHERE (
    LEN(LOWER(FIRST_NAME + LAST_NAME)) - 
    LEN(REPLACE(LOWER(FIRST_NAME + LAST_NAME), 'a', ''))
) >= 3;

-- 5. Total employees and percentage with >3 years in company per department
SELECT D.DEPARTMENT_ID,
       COUNT(E.EMPLOYEE_ID) AS TotalEmployees,
       ROUND(100.0 * SUM(CASE WHEN DATEDIFF(YEAR, E.HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) / COUNT(E.EMPLOYEE_ID), 2) AS PercentageOver3Years
FROM Employees E
INNER JOIN Departments D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_ID;

-- 6. Most and least experienced Spacemen by job description
SELECT JOB_ID,
       MIN(DATEDIFF(YEAR, HIRE_DATE, GETDATE())) AS LeastExperience,
       MAX(DATEDIFF(YEAR, HIRE_DATE, GETDATE())) AS MostExperience
FROM Personal
GROUP BY JOB_ID;


-- 1. Separate uppercase, lowercase, digits, and other characters from 'tf56sd#%OqH'
SELECT
    'tf56sd#%OqH' AS Original,
    CONCAT_WS('', 
        CASE WHEN PATINDEX('%[A-Z]%', c.value) > 0 THEN c.value ELSE '' END
    ) AS UppercaseLetters,
    CONCAT_WS('', 
        CASE WHEN PATINDEX('%[a-z]%', c.value) > 0 THEN c.value ELSE '' END
    ) AS LowercaseLetters,
    CONCAT_WS('', 
        CASE WHEN PATINDEX('%[0-9]%', c.value) > 0 THEN c.value ELSE '' END
    ) AS Digits,
    CONCAT_WS('', 
        CASE WHEN PATINDEX('%[^A-Za-z0-9]%', c.value) > 0 THEN c.value ELSE '' END
    ) AS Others
FROM 
    STRING_SPLIT('tf56sd#%OqH', '') c;

-- 2. Row-wise cumulative sum on Students table
SELECT 
    S1.ID,
    S1.Value,
    (SELECT SUM(Value) FROM Students S2 WHERE S2.ID <= S1.ID) AS RunningTotal
FROM Students S1
ORDER BY S1.ID;

-- 3. Sum up equations from Equations table
SELECT Equation,
       -- Assumes basic format like '3+4' or '10-2'
       CASE
           WHEN CHARINDEX('+', Equation) > 0 THEN
               CAST(LEFT(Equation, CHARINDEX('+', Equation)-1) AS INT) +
               CAST(RIGHT(Equation, LEN(Equation) - CHARINDEX('+', Equation)) AS INT)
           WHEN CHARINDEX('-', Equation) > 0 THEN
               CAST(LEFT(Equation, CHARINDEX('-', Equation)-1) AS INT) -
               CAST(RIGHT(Equation, LEN(Equation) - CHARINDEX('-', Equation)) AS INT)
           WHEN CHARINDEX('*', Equation) > 0 THEN
               CAST(LEFT(Equation, CHARINDEX('*', Equation)-1) AS INT) *
               CAST(RIGHT(Equation, LEN(Equation) - CHARINDEX('*', Equation)) AS INT)
           WHEN CHARINDEX('/', Equation) > 0 THEN
               CAST(LEFT(Equation, CHARINDEX('/', Equation)-1) AS INT) /
               CAST(RIGHT(Equation, LEN(Equation) - CHARINDEX('/', Equation)) AS INT)
           ELSE NULL
       END AS Result
FROM Equations;

-- 4. Students who share the same birthday
SELECT S1.StudentID, S1.StudentName, S1.Birthday
FROM Student S1
WHERE EXISTS (
    SELECT 1 FROM Student S2
    WHERE S2.StudentID <> S1.StudentID AND S2.Birthday = S1.Birthday
);

-- 5. Total score for each unique player pair (A + B), order-independent
SELECT 
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
    SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY 
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END;
