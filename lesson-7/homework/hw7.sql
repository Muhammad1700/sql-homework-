-- 1. Minimum product price from Products table
SELECT MIN(Price) AS MinPrice
FROM Products;

-- 2. Maximum Salary from Employees table
SELECT MAX(Salary) AS MaxSalary
FROM Employees;

-- 3. Total number of rows in Customers table
SELECT COUNT(*) AS TotalCustomers
FROM Customers;

-- 4. Number of unique product categories
SELECT COUNT(DISTINCT Category) AS UniqueCategories
FROM Products;

-- 5. Total sales amount for ProductID = 7
SELECT SUM(SaleAmount) AS TotalSalesForProduct7
FROM Sales
WHERE ProductID = 7;

-- 6. Average age of employees
SELECT AVG(Age) AS AverageEmployeeAge
FROM Employees;

-- 7. Count employees per department
SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

-- 8. Min and Max price grouped by Category
SELECT Category,
       MIN(Price) AS MinPrice,
       MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category;

-- 9. Total sales amount per Customer
SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID;

-- 10. Departments with more than 5 employees (showing DeptID or DepartmentName)
SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(*) > 5;

tack 2

-- 1️⃣ Total and average sales per product category
SELECT p.Category,
       SUM(s.SaleAmount) AS TotalSales,
       AVG(s.SaleAmount) AS AvgSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.Category;

-- 2️⃣ Count of employees in HR department
SELECT COUNT(*) AS HREmployees
FROM Employees
WHERE DepartmentName = 'HR';

-- 3️⃣ Highest and lowest salary by department
SELECT DepartmentName,
       MAX(Salary) AS MaxSalary,
       MIN(Salary) AS MinSalary
FROM Employees
GROUP BY DepartmentName;

-- 4️⃣ Average salary per department
SELECT DepartmentName,
       AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName;

-- 5️⃣ AVG salary and COUNT of employees per department
SELECT DepartmentName,
       AVG(Salary) AS AvgSalary,
       COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

-- 6️⃣ Product categories with average price > 400
SELECT Category
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;

-- 7️⃣ Total sales per year
SELECT YEAR(SaleDate) AS SalesYear,
       SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY YEAR(SaleDate);

-- 8️⃣ Customers who placed at least 3 orders
SELECT CustomerID
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >= 3;

-- 9️⃣ Departments with AVG salary > 60000
SELECT DepartmentName
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 60000;

tack 3

-- 1. Average price by category (greater than 150)
SELECT Category, AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 150;

-- 2. Total sales per customer (more than 1500)
SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 1500;

-- 3. Total and average salary per department (avg salary > 65000)
SELECT DepartmentName, 
       SUM(Salary) AS TotalSalary,
       AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 65000;

-- 4. Orders with Freight > 50: total per customer + their least purchase
SELECT CustomerID,
       SUM(Freight) AS TotalFreightOver50,
       MIN(TotalDue) AS LeastPurchase
FROM tsql2012.sales.orders
WHERE Freight > 50
GROUP BY CustomerID;

-- 5. Total sales and unique products per month (at least 2 products)
SELECT YEAR(OrderDate) AS SalesYear,
       MONTH(OrderDate) AS SalesMonth,
       SUM(TotalAmount) AS TotalSales,
       COUNT(DISTINCT ProductID) AS UniqueProducts
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2;

-- 6. Min and Max order quantity per year
SELECT YEAR(OrderDate) AS OrderYear,
       MIN(Quantity) AS MinQty,
       MAX(Quantity) AS MaxQty
FROM Orders
GROUP BY YEAR(OrderDate);
