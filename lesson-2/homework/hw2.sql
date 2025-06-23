“Tasks should be solved using SQL Server” – Barcha topshiriqlar Microsoft SQL Server platformasida bajarilishi kerak. Boshqa DBMS (masalan, MySQL yoki PostgreSQL) ishlamaydi.

“Case insensitivity applies” – Bu SQL Serverda katta-kichik harflar farq qilmasligini bildiradi. Masalan, name, Name, yoki NAME — hammasi bir xil sanaladi.

“Alias names do not affect the score” – Jadval yoki ustunlar uchun ishlatilgan taxalluslar (alias) natijaga ta’sir qilmaydi. Masalan, FROM Employees AS E va FROM Employees AS emp ikkisi ham maqbul.

“Scoring is based on the correct output” – Baholashda asosiy narsa — chiqadigan natijaning to‘g‘riligidir. Kod strukturasi emas, aynan u ishlab to‘g‘ri natija beradimi, shunga qaraladi.

“One correct solution is sufficient” – Agar bir necha yo‘ldan to‘g‘ri natijaga erishish mumkin bo‘lsa, bittasi kifoya. Har xil yondashuvlar mumkin, lekin faqat bittasi to‘g‘ri bo‘lsa ham yetarli.


tack 2

CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);


INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'Ali Karimov', 6500.00);

INSERT INTO Employees (EmpID, Name, Salary)
VALUES 
    (2, 'Dilshod Usmonov', 4800.00),
    (3, 'Shahnoza Rustamova', 5300.00);

UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1;

DELETE FROM Employees
WHERE EmpID = 2;


ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);

ALTER TABLE Employees
ADD Department VARCHAR(50);

ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

TRUNCATE TABLE Employees;

tack 3

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Description VARCHAR(200),
    CONSTRAINT chk_Price CHECK (Price > 0)
);

ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;

EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, Description)
VALUES 
    (1, 'Laptop', 'Electronics', 1200.00, '15-inch display'),
    (2, 'Mouse', 'Electronics', 25.00, 'Wireless optical mouse'),
    (3, 'Notebook', 'Stationery', 3.50, 'A5 size notebook'),
    (4, 'Chair', 'Furniture', 80.00, 'Office swivel chair'),
    (5, 'Bottle', 'Accessories', 10.00, '1L water bottle');

SELECT * INTO Products_Backup
FROM Products;

EXEC sp_rename 'Products', 'Inventory';

ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;


SELECT 
    IDENTITY(INT, 1000, 5) AS ProductCode,
    ProductID,
    ProductName,
    ProductCategory,
    Price,
    Description,
    StockQuantity
INTO Inventory_New
FROM Inventory;

DROP TABLE Inventory;
EXEC sp_rename 'Inventory_New', 'Inventory';
