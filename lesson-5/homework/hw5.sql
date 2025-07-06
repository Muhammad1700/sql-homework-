-- 1. Rename ProductName as Name
SELECT ProductName AS Name FROM Products;

-- 2. Rename Customers table as Client
SELECT * FROM Customers AS Client;

-- 3. Combine ProductName from Products and Products_Discounted using UNION
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

-- 4. Intersection of Products and Products_Discounted
SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM Products_Discounted;

-- 5. Distinct customer names and Country
SELECT DISTINCT FirstName + ' ' + LastName AS CustomerName, Country
FROM Customers;

-- 6. Conditional column using CASE (Price Category)
SELECT ProductName, Price,
       CASE 
           WHEN Price > 1000 THEN 'High'
           ELSE 'Low'
       END AS PriceCategory
FROM Products;

-- 7. Conditional column using IIF (Stock availability)
SELECT ProductName, StockQuantity,
       IIF(StockQuantity > 100, 'Yes', 'No') AS InStock
FROM Products_Discounted;


tack 2

-- 1. Use UNION to combine ProductName from both tables
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

-- 2. Use EXCEPT to find ProductNames in Products not in Products_Discounted
SELECT ProductName FROM Products
EXCEPT
SELECT ProductName FROM Products_Discounted;

-- 3. Use IIF to classify Products by Price
SELECT ProductName, Price,
       IIF(Price > 1000, 'Expensive', 'Affordable') AS PriceCategory
FROM Products;

-- 4. Employees where Age < 25 OR Salary > 60000
SELECT * FROM Employees
WHERE Age < 25 OR Salary > 60000;

-- 5. Update salary: +10% for HR department or EmployeeID = 5
UPDATE Employees
SET Salary = Salary * 1.1
WHERE DepartmentName = 'HR' OR EmployeeID = 5;

tack 3

-- 1. SaleAmount bo‘yicha tier darajasi tayinlash
SELECT SaleID, SaleAmount,
       CASE
           WHEN SaleAmount > 500 THEN 'Top Tier'
           WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
           ELSE 'Low Tier'
       END AS SaleCategory
FROM Sales;

-- 2. Orders jadvalidagi, lekin Sales’da yo‘q bo‘lgan CustomerID’lar
SELECT CustomerID FROM Orders
EXCEPT
SELECT CustomerID FROM Sales;

-- 3. Quantity bo‘yicha chegirma foizini hisoblash (Orders jadvalidan)
SELECT CustomerID, Quantity,
       CASE
           WHEN Quantity = 1 THEN '3%'
           WHEN Quantity BETWEEN 2 AND 3 THEN '5%'
           ELSE '7%'
       END AS DiscountPercent
FROM Orders;
