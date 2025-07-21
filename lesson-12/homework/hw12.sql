tack 1

SELECT 
    P.firstName,
    P.lastName,
    A.city,
    A.state
FROM Person P
LEFT JOIN Address A ON P.personId = A.personId;




SELECT E.Name AS EmployeeName, E.Salary AS EmployeeSalary,
       M.Name AS ManagerName, M.Salary AS ManagerSalary
FROM Employees E
INNER JOIN Employees M ON E.ManagerID = M.EmployeeID
WHERE E.Salary > M.Salary;



SELECT email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;


DELETE FROM Person
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Person
    GROUP BY email
);


SELECT DISTINCT ParentName
FROM girls
WHERE ParentName NOT IN (
    SELECT ParentName FROM boys
);


SELECT 
    CustomerID,
    SUM(SalesAmount) AS TotalSalesOver50,
    MIN(Weight) AS LeastWeight
FROM Sales.Orders
WHERE Weight > 50
GROUP BY CustomerID;


SELECT
    C1.Item AS [Item Cart 1],
    C2.Item AS [Item Cart 2]
FROM Cart1 C1
FULL OUTER JOIN Cart2 C2 ON C1.Item = C2.Item;


SELECT CustomerID, FirstName, LastName
FROM Customers
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID
    FROM Orders
);
SELECT C.CustomerID, C.FirstName, C.LastName
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL;


SELECT 
    S.student_id,
    S.student_name,
    Sub.subject_name,
    COUNT(E.subject_name) AS attended_exams
FROM Students S
CROSS JOIN Subjects Sub
LEFT JOIN Examinations E 
    ON S.student_id = E.student_id AND Sub.subject_name = E.subject_name
GROUP BY S.student_id, S.student_name, Sub.subject_name
ORDER BY S.student_id, Sub.subject_name;

