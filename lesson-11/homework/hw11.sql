tack 1

-- 1. Orders after 2022 with customer names
SELECT O.OrderID, C.FirstName + ' ' + C.LastName AS CustomerName, O.OrderDate
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE YEAR(O.OrderDate) > 2022;

-- 2. Employees in Sales or Marketing
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName IN ('Sales', 'Marketing');

-- 3. Highest salary per department
SELECT D.DepartmentName, MAX(E.Salary) AS MaxSalary
FROM Departments D
INNER JOIN Employees E ON D.DepartmentID = E.DepartmentID
GROUP BY D.DepartmentName;

-- 4. USA customers who placed orders in 2023
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, O.OrderID, O.OrderDate
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE C.Country = 'USA' AND YEAR(O.OrderDate) = 2023;

-- 5. Total orders per customer
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, COUNT(O.OrderID) AS TotalOrders
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName;

-- 6. Products from Gadget Supplies or Clothing Mart
SELECT P.ProductName, S.SupplierName
FROM Products P
INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID
WHERE S.SupplierName IN ('Gadget Supplies', 'Clothing Mart');

-- 7. Most recent order per customer (include those with no orders)
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, MAX(O.OrderDate) AS MostRecentOrderDate
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName;
tack 2

-- 1. Customers with orders totaling over 500
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, O.TotalAmount AS OrderTotal
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE O.TotalAmount > 500;

-- 2. Product sales in 2022 or where amount > 400
SELECT P.ProductName, S.SaleDate, S.Amount AS SaleAmount
FROM Sales S
INNER JOIN Products P ON S.ProductID = P.ProductID
WHERE YEAR(S.SaleDate) = 2022 OR S.Amount > 400;

-- 3. Total sales amount per product
SELECT P.ProductName, SUM(S.Amount) AS TotalSalesAmount
FROM Products P
INNER JOIN Sales S ON P.ProductID = S.ProductID
GROUP BY P.ProductName;

-- 4. HR employees with salary > 60000
SELECT E.Name AS EmployeeName, D.DepartmentName, E.Salary
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Human Resources' AND E.Salary > 60000;

-- 5. Products sold in 2023 with stock over 100
SELECT P.ProductName, S.SaleDate, P.StockQuantity
FROM Sales S
INNER JOIN Products P ON S.ProductID = P.ProductID
WHERE YEAR(S.SaleDate) = 2023 AND P.StockQuantity > 100;

-- 6. Employees in Sales OR hired after 2020
SELECT E.Name AS EmployeeName, D.DepartmentName, E.HireDate
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sales' OR E.HireDate > '2020-12-31';

tack 3

-- 1. Orders made by USA customers whose address starts with 4 digits
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, O.OrderID, C.Address, O.OrderDate
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE C.Country = 'USA' AND C.Address LIKE '[0-9][0-9][0-9][0-9]%';

-- 2. Product sales in Electronics category OR SaleAmount > 350
SELECT P.ProductName, P.Category, S.Amount AS SaleAmount
FROM Sales S
INNER JOIN Products P ON S.ProductID = P.ProductID
WHERE P.Category = 'Electronics' OR S.Amount > 350;

-- 3. Number of products in each category
SELECT Category AS CategoryName, COUNT(*) AS ProductCount
FROM Products
GROUP BY Category;

-- 4. Orders where customer is from Los Angeles and amount > 300
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, C.City, O.OrderID, O.TotalAmount AS Amount
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.City = 'Los Angeles' AND O.TotalAmount > 300;

-- 5. Employees in HR or Finance OR name contains ≥ 4 vowels
SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName IN ('Human Resources', 'Finance')
   OR (LEN(E.Name) - LEN(REPLACE(LOWER(E.Name), 'a', '')) +
       LEN(E.Name) - LEN(REPLACE(LOWER(E.Name), 'e', '')) +
       LEN(E.Name) - LEN(REPLACE(LOWER(E.Name), 'i', '')) +
       LEN(E.Name) - LEN(REPLACE(LOWER(E.Name), 'o', '')) +
       LEN(E.Name) - LEN(REPLACE(LOWER(E.Name), 'u', ''))) >= 4;

-- 6. Employees in Sales or Marketing with salary > 60000
SELECT E.Name AS EmployeeName, D.DepartmentName, E.Salary
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName IN ('Sales', 'Marketing') AND E.Salary > 60000;
