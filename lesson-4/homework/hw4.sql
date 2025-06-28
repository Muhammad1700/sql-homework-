tack 1

-- 1. Top 5 employees
SELECT TOP 5 * 
FROM Employees;

-- 2. Unique categories from Products
SELECT DISTINCT Category 
FROM Products;

-- 3. Products with Price > 100
SELECT * 
FROM Products
WHERE Price > 100;

-- 4. Customers whose FirstName starts with 'A'
SELECT * 
FROM Customers
WHERE FirstName LIKE 'A%';

-- 5. Order Products by Price ASC
SELECT * 
FROM Products
ORDER BY Price ASC;

-- 6. Employees with Salary >= 60000 and Department = 'HR'
SELECT * 
FROM Employees
WHERE Salary >= 60000 AND DepartmentName = 'HR';

-- 7. Replace NULLs in Email column
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    ISNULL(Email, 'noemail@example.com') AS Email
FROM Employees;

-- 8. Products priced between 50 and 100
SELECT * 
FROM Products
WHERE Price BETWEEN 50 AND 100;

-- 9. SELECT DISTINCT on Category and ProductName
SELECT DISTINCT Category, ProductName 
FROM Products;

-- 10. SELECT DISTINCT and order by ProductName DESC
SELECT DISTINCT Category, ProductName 
FROM Products
ORDER BY ProductName DESC;

tack 2

-- 1. Top 10 products ordered by Price DESC
SELECT TOP 10 * 
FROM Products
ORDER BY Price DESC;

-- 2. COALESCE to return first non-NULL value between FirstName or LastName
SELECT 
    EmployeeID, 
    COALESCE(FirstName, LastName) AS FirstNonNullName 
FROM Employees;

-- 3. DISTINCT Category and Price
SELECT DISTINCT Category, Price 
FROM Products;

-- 4. Employees aged between 30 and 40 OR in Marketing
SELECT * 
FROM Employees
WHERE (Age BETWEEN 30 AND 40) 
   OR DepartmentName = 'Marketing';

-- 5. OFFSET-FETCH rows 11 to 20 ordered by Salary DESC
SELECT * 
FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

-- 6. Products with Price <= 1000 and Stock > 50, sorted by Stock ASC
SELECT * 
FROM Products
WHERE Price <= 1000 AND StockQuantity > 50
ORDER BY StockQuantity ASC;

-- 7. ProductName contains letter 'e'
SELECT * 
FROM Products
WHERE ProductName LIKE '%e%';

-- 8. Employees in 'HR', 'IT', or 'Finance'
SELECT * 
FROM Employees
WHERE DepartmentName IN ('HR', 'IT', 'Finance');

-- 9. Customers ordered by City ASC and PostalCode DESC
SELECT * 
FROM Customers
ORDER BY City ASC, PostalCode DESC;

tack 3

-- 1. Top 5 products with highest total sales amount
SELECT TOP(5) ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID
ORDER BY TotalSales DESC;

-- 2. Combine FirstName and LastName into FullName
SELECT 
    EmployeeID,
    FirstName + ' ' + LastName AS FullName,
    DepartmentName
FROM Employees;

-- 3. DISTINCT Category, ProductName, and Price for products above $50
SELECT DISTINCT Category, ProductName, Price
FROM Products
WHERE Price > 50;

-- 4. Products with Price < 10% of average price
SELECT * 
FROM Products
WHERE Price < (SELECT AVG(Price) * 0.10 FROM Products);

-- 5. Employees younger than 30 in HR or IT
SELECT * 
FROM Employees
WHERE Age < 30 AND DepartmentName IN ('HR', 'IT');

-- 6. Customers with '@gmail.com' in Email
SELECT * 
FROM Customers
WHERE Email LIKE '%@gmail.com%';

-- 7. Employees with salary > ALL in 'Sales' department
SELECT * 
FROM Employees
WHERE Salary > ALL (
    SELECT Salary
    FROM Employees
    WHERE DepartmentName = 'Sales'
);

-- 8. Orders placed in the last 180 days
SELECT * 
FROM Orders
WHERE OrderDate BETWEEN DATEADD(DAY, -180, GETDATE()) AND GETDATE();
