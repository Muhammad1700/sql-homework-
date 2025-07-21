tack 1
-- 1. All combinations of product names and supplier names (Cross Join)
SELECT P.ProductName, S.SupplierName
FROM Products P
CROSS JOIN Suppliers S;

-- 2. All combinations of departments and employees (Cross Join)
SELECT D.DepartmentName, E.Name AS EmployeeName
FROM Departments D
CROSS JOIN Employees E;

-- 3. Only combinations where supplier actually supplies the product
SELECT S.SupplierName, P.ProductName
FROM Products P
INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID;

-- 4. Customer names and their orders ID
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, O.OrderID
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID;

-- 5. All combinations of students and courses (Cross Join)
SELECT S.Name AS StudentName, C.CourseName
FROM Students S
CROSS JOIN Courses C;

-- 6. Products and Orders where product IDs match
SELECT P.ProductName, O.OrderID
FROM Orders O
INNER JOIN Products P ON O.ProductID = P.ProductID;

-- 7. Employees whose DepartmentID matches the department
SELECT D.DepartmentName, E.Name AS EmployeeName
FROM Employees E
INNER JOIN


tack 2

-- 1. Employees and departments where DepartmentIDs don't match
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
CROSS JOIN Departments D
WHERE E.DepartmentID <> D.DepartmentID;

-- 2. Orders where ordered quantity exceeds stock quantity
SELECT O.OrderID, P.ProductName, O.Quantity, P.StockQuantity
FROM Orders O
INNER JOIN Products P ON O.ProductID = P.ProductID
WHERE O.Quantity > P.StockQuantity;

-- 3. Customers and ProductIDs where sale amount is 500+
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, S.ProductID
FROM Sales S
INNER JOIN Customers C ON S.CustomerID = C.CustomerID
WHERE S.Amount >= 500;

-- 4. Students and enrolled course names
SELECT S.Name AS StudentName, C.CourseName
FROM Enrollments E
INNER JOIN Students S ON E.StudentID = S.StudentID
INNER JOIN Courses C ON E.CourseID = C.CourseID;

-- 5. Products and supplier names where supplier name contains "Tech"
SELECT P.ProductName, S.SupplierName
FROM Products P
INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID
WHERE S.SupplierName LIKE '%Tech%';

-- 6. Orders where payment amount is less than total amount
SELECT O.OrderID, O.TotalAmount, P.Amount AS PaymentAmount
FROM Orders O
INNER JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.Amount < O.TotalAmount;

-- 7. Department name for each employee
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 8. Products in categories 'Electronics' or 'Furniture'
SELECT ProductName, Category
FROM Products
WHERE Category IN ('Electronics', 'Furniture');

-- 9. Sales from customers who are from 'USA'
SELECT S.SaleID, C.FirstName + ' ' + C.LastName AS CustomerName, S.ProductID, S.Amount
FROM Sales S
INNER JOIN Customers C ON S.CustomerID = C.CustomerID
WHERE C.Country = 'USA';

-- 10. Orders from German customers with total > 100
SELECT O.OrderID, C.FirstName + ' ' + C.LastName AS CustomerName, O.TotalAmount
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.Country = 'Germany' AND O.TotalAmount > 100;

tack 3

-- 1. All pairs of employees from different departments
SELECT E1.Name AS Employee1, E2.Name AS Employee2
FROM Employees E1
INNER JOIN Employees E2 ON E1.EmployeeID <> E2.EmployeeID
WHERE E1.DepartmentID <> E2.DepartmentID;

-- 2. Payments where paid amount ≠ (Quantity × Price)
SELECT P.PaymentID, P.OrderID, P.Amount AS PaidAmount, 
       O.Quantity * Pr.Price AS ExpectedAmount
FROM Payments P
INNER JOIN Orders O ON P.OrderID = O.OrderID
INNER JOIN Products Pr ON O.ProductID = Pr.ProductID
WHERE P.Amount <> O.Quantity * Pr.Price;

-- 3. Students not enrolled in any course
SELECT S.StudentID, S.Name
FROM Students S
LEFT JOIN Enrollments E ON S.StudentID = E.StudentID
WHERE E.CourseID IS NULL;

-- 4. Managers with salary ≤ the person they manage
SELECT M.Name AS ManagerName, M.Salary AS ManagerSalary,
       E.Name AS EmployeeName, E.Salary AS EmployeeSalary
FROM Employees E
INNER JOIN Employees M ON E.ManagerID = M.EmployeeID
WHERE M.Salary <= E.Salary;

-- 5. Customers who made an order but no payment
SELECT DISTINCT C.FirstName + ' ' + C.LastName AS CustomerName, O.OrderID
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
LEFT JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.OrderID IS NULL;
