tack 1

-- 1. Employees with Salary > 50000 and their department names
SELECT E.Name AS EmployeeName, E.Salary, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE E.Salary > 50000;

-- 2. Customer names and order dates for orders placed in 2023
SELECT C.FirstName, C.LastName, O.OrderDate
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE YEAR(O.OrderDate) = 2023;

-- 3. All employees with their department names (include employees without department)
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 4. All suppliers and the products they supply (include suppliers without products)
SELECT S.SupplierName, P.ProductName
FROM Suppliers S
LEFT JOIN Products P ON S.SupplierID = P.SupplierID;

-- 5. All orders and their payments (include unmatched on both sides)
SELECT O.OrderID, O.OrderDate, P.PaymentDate, P.Amount
FROM Orders O
FULL OUTER JOIN Payments P ON O.OrderID = P.OrderID;

-- 6. Employee names and their manager names
SELECT E.Name AS EmployeeName, M.Name AS ManagerName
FROM Employees E
LEFT JOIN Employees M ON E.ManagerID = M.EmployeeID;

-- 7. Students enrolled in 'Math 101'
SELECT S.Name AS StudentName, C.CourseName
FROM Enrollments E
INNER JOIN Students S ON E.StudentID = S.StudentID
INNER JOIN Courses C ON E.CourseID = C.CourseID
WHERE C.CourseName = 'Math 101';

-- 8. Customers who placed an order with more than 3 items
SELECT C.FirstName, C.LastName, O.Quantity
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.Quantity > 3;

-- 9. Employees working in 'Human Resources'
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Human Resources';

tack 2

-- 1. Department names with more than 5 employees
SELECT D.DepartmentName, COUNT(E.EmployeeID) AS EmployeeCount
FROM Departments D
INNER JOIN Employees E ON D.DepartmentID = E.DepartmentID
GROUP BY D.DepartmentName
HAVING COUNT(E.EmployeeID) > 5;

-- 2. Products that have never been sold
SELECT P.ProductID, P.ProductName
FROM Products P
LEFT JOIN Sales S ON P.ProductID = S.ProductID
WHERE S.ProductID IS NULL;

-- 3. Customers who have placed at least one order
SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS TotalOrders
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName;

-- 4. Only records where both employee and department exist
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 5. Pairs of employees reporting to the same manager
SELECT E1.Name AS Employee1, E2.Name AS Employee2, E1.ManagerID
FROM Employees E1
INNER JOIN Employees E2 ON E1.ManagerID = E2.ManagerID AND E1.EmployeeID <> E2.EmployeeID;

-- 6. Orders placed in 2022 with customer names
SELECT O.OrderID, O.OrderDate, C.FirstName, C.LastName
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE YEAR(O.OrderDate) = 2022;

-- 7. Sales department employees with salary above 60000
SELECT E.Name AS EmployeeName, E.Salary, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sales' AND E.Salary > 60000;

-- 8. Orders that have a corresponding payment
SELECT O.OrderID, O.OrderDate, P.PaymentDate, P.Amount
FROM Orders O
INNER JOIN Payments P ON O.OrderID = P.OrderID;

-- 9. Products that were never ordered
SELECT P.ProductID, P.ProductName
FROM Products P
LEFT JOIN Orders O ON P.ProductID = O.ProductID
WHERE O.ProductID IS NULL;

tack 3

-- 1. Employees with salary > average salary in their department
SELECT E.Name AS EmployeeName, E.Salary
FROM Employees E
INNER JOIN (
    SELECT DepartmentID, AVG(Salary) AS AvgDeptSalary
    FROM Employees
    GROUP BY DepartmentID
) A ON E.DepartmentID = A.DepartmentID
WHERE E.Salary > A.AvgDeptSalary;

-- 2. Orders before 2020 with no corresponding payment
SELECT O.OrderID, O.OrderDate
FROM Orders O
LEFT JOIN Payments P ON O.OrderID = P.OrderID
WHERE YEAR(O.OrderDate) < 2020 AND P.OrderID IS NULL;

-- 3. Products with no matching category
SELECT P.ProductID, P.ProductName
FROM Products P
LEFT JOIN Categories C ON P.Category = C.CategoryName
WHERE C.CategoryName IS NULL;

-- 4. Pairs of employees with same manager and salary > 60000
SELECT E1.Name AS Employee1, E2.Name AS Employee2, E1.ManagerID, E1.Salary
FROM Employees E1
INNER JOIN Employees E2 ON E1.ManagerID = E2.ManagerID AND E1.EmployeeID <> E2.EmployeeID
WHERE E1.Salary > 60000;

-- 5. Employees in departments whose name starts with 'M'
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName LIKE 'M%';

-- 6. Sales > 500 with product names
SELECT S.SaleID, P.ProductName, S.Amount AS SaleAmount
FROM Sales S
INNER JOIN Products P ON S.ProductID = P.ProductID
WHERE S.Amount > 500;

-- 7. Students not enrolled in 'Math 101'
SELECT S.StudentID, S.Name AS StudentName
FROM Students S
WHERE S.StudentID NOT IN (
    SELECT E.StudentID
    FROM Enrollments E
    INNER JOIN Courses C ON E.CourseID = C.CourseID
    WHERE C.CourseName = 'Math 101'
);

-- 8. Orders missing payment details
SELECT O.OrderID, O.OrderDate, P.PaymentID
FROM Orders O
LEFT JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.PaymentID IS NULL;

-- 9. Products in 'Electronics' or 'Furniture' category
SELECT P.ProductID, P.ProductName, C.CategoryName
FROM Products P
INNER JOIN Categories C ON P.Category = C.CategoryName
WHERE C.CategoryName IN ('Electronics', 'Furniture');
