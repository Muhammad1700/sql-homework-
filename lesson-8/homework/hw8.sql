-- 1. Har bir kategoriyadagi mahsulotlar soni
SELECT Category, COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category;

-- 2. 'Electronics' kategoriyasidagi o‘rtacha narx
SELECT AVG(Price) AS AverageElectronicsPrice
FROM Products
WHERE Category = 'Electronics';

-- 3. Shahari 'L' harfi bilan boshlanuvchi mijozlar
SELECT *
FROM Customers
WHERE City LIKE 'L%';

-- 4. Nomlari 'er' bilan tugaydigan mahsulotlar
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%er';

-- 5. Davlati 'A' harfi bilan tugaydigan mijozlar
SELECT *
FROM Customers
WHERE Country LIKE '%A';

-- 6. Eng yuqori mahsulot narxi
SELECT MAX(Price) AS HighestPrice
FROM Products;

-- 7. Mahsulot zaxirasiga yorliq qo‘yish
SELECT ProductName, StockQuantity,
       CASE
           WHEN StockQuantity < 30 THEN 'Low Stock'
           ELSE 'Sufficient'
       END AS StockStatus
FROM Products;

-- 8. Har bir davlat bo‘yicha umumiy mijozlar soni
SELECT Country, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country;

-- 9. Buyurtmalardagi minimal va maksimal miqdor
SELECT MIN(Quantity) AS MinQuantityOrdered,
       MAX(Quantity) AS MaxQuantityOrdered
FROM Orders;

tack 2

-- 1. 2023 yil yanvarda buyurtma bergan, ammo hisob-fakturaga ega bo'lmagan mijozlar
SELECT DISTINCT o.CustomerID
FROM Orders o
LEFT JOIN Invoices i ON o.CustomerID = i.CustomerID
WHERE YEAR(o.OrderDate) = 2023 AND MONTH(o.OrderDate) = 1
  AND i.InvoiceID IS NULL;

-- 2. Products va Products_Discounted dan barcha nomlar (duplikatlar bilan)
SELECT ProductName FROM Products
UNION ALL
SELECT ProductName FROM Products_Discounted;

-- 3. Products va Products_Discounted dan barcha nomlar (duplikatlarsiz)
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

-- 4. Har yil bo‘yicha buyurtmalarning o‘rtacha summasi
SELECT YEAR(OrderDate) AS OrderYear, AVG(TotalAmount) AS AverageAmount
FROM Orders
GROUP BY YEAR(OrderDate);

-- 5. Narxga qarab guruhlash: Low <100, Mid 100-500, High >500
SELECT ProductName,
       CASE
           WHEN Price < 100 THEN 'Low'
           WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
           ELSE 'High'
       END AS PriceGroup
FROM Products;

-- 6. City_Population jadvalini Pivot qilish va natijani Population_Each_Year ga saqlash
SELECT district_name,
       [2012], [2013]
INTO Population_Each_Year
FROM (
    SELECT district_name, population, year
    FROM City_Population
) AS SourceTable
PIVOT (
    SUM(population)
    FOR year IN ([2012], [2013])
) AS PivotResult;

-- 7. Har bir ProductID bo‘yicha umumiy savdo summasi
SELECT ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID;

tack 3


-- 1. Eng ko‘p invoice summasiga ega 3 ta mijozni topish
SELECT TOP 3 CustomerID, SUM(TotalAmount) AS TotalSpent
FROM Invoices
GROUP BY CustomerID
ORDER BY TotalSpent DESC;

-- 2. Population_Each_Year jadvalini asl ko‘rinishiga (City_Population) qaytarish
SELECT district_name AS district_name,
       CASE WHEN [2012] IS NOT NULL THEN [2012] ELSE NULL END AS population,
       '2012' AS year
FROM Population_Each_Year
UNION ALL
SELECT district_name,
       CASE WHEN [2013] IS NOT NULL THEN [2013] ELSE NULL END,
       '2013' AS year
FROM Population_Each_Year;

-- 3. Products va Sales jadvalidan har bir mahsulot nechta marta sotilganini ko‘rsatish
SELECT p.ProductName, COUNT(s.SaleID) AS TimesSold
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName;

-- 4. Population_Each_City jadvalini asl ko‘rinishiga (City_Population) qaytarish
SELECT 'Bektemir' AS district_name, [Bektemir] AS population, year
FROM Population_Each_City
UNION ALL
SELECT 'Chilonzor', [Chilonzor], year
FROM Population_Each_City
UNION ALL
SELECT 'Yakkasaroy', [Yakkasaroy], year
FROM Population_Each_City;
