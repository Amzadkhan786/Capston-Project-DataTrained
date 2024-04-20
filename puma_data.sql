create database puma_clothes;

use puma_clothes;

select * from [dbo].[puma_data];

SELECT 
    Sno,
    BrandName,
    Category,
    Type,
    Product_Name,
    "Product Code",
    Price
INTO Table1
FROM [dbo].[puma_data];

select * from [dbo].[Table1];

SELECT 
    Sno,
    color1,
    color2,
    color3,
    color4,
    Weartype,
    Material_type
INTO Table2
FROM [dbo].[puma_data];

select * from [dbo].[Table2];

SELECT 
    Sno,
    Size1,
    Size2,
    Size3,
    Size4,
    Country,
    Return_time,
    Occasion
INTO Table3 
FROM [dbo].[puma_data];

select * from [dbo].[Table3];

SELECT TOP 20 *
FROM [dbo].[Table1]
ORDER BY Price DESC;

SELECT Category, SUM(Price) AS Total_Price
FROM [dbo].[Table1]
GROUP BY Category;

SELECT *
FROM [dbo].[Table1]
WHERE Price BETWEEN 2000 AND 5000;

SELECT BrandName, AVG(Price) AS Average_Price
FROM [dbo].[Table1]
GROUP BY BrandName;

SELECT *
FROM [dbo].[Table1] t1
WHERE NOT EXISTS (
    SELECT 1
    FROM [dbo].[Table1] t2
    WHERE t1.BrandName = t2.BrandName
    AND t1.Category = t2.Category
    AND t1.Sno <> t2.Sno
);

SELECT *
FROM [dbo].[Table2]
ORDER BY [Material_type] ASC;

SELECT AVG(Reviews) AS Average_Reviews
FROM [dbo].[Table2];

SELECT TOP 30 t1.*
FROM [dbo].[Table2] t2
INNER JOIN [dbo].[Table1] t1 ON t1.Type = t2.Weartype
ORDER BY t1.Price DESC;

SELECT *
FROM [dbo].[Table2] t1
JOIN [dbo].[Table2] t2 ON t1.Sno <> t2.Sno
WHERE t1.color1 = t2.color1
OR t1.color2 = t2.color2
OR t1.color3 = t2.color3
OR t1.color4 = t2.color4;

SELECT t2.Material_type, SUM(t1.Price) AS Total_Price
FROM [dbo].[Table2] t2
INNER JOIN [dbo].[Table1] t1 ON t1.Sno = t2.Sno
GROUP BY t2.Material_type;

SELECT *
FROM [dbo].[Table3]
ORDER BY Return_time ASC;

SELECT DISTINCT Country
FROM [dbo].[Table3];

SELECT Country, AVG(ISNULL(TRY_CONVERT(float, Return_time), 0)) AS Average_Return_Time
FROM [dbo].[Table3]
GROUP BY Country;

SELECT Occasion
FROM [dbo].[Table3]
WHERE TRY_CONVERT(int, Return_time) IS NOT NULL
AND TRY_CONVERT(int, Return_time) > (
    SELECT AVG(CONVERT(int, Return_time)) 
    FROM [dbo].[Table3] 
    WHERE TRY_CONVERT(int, Return_time) IS NOT NULL
);

SELECT *
FROM [dbo].[Table3]
WHERE Size1 IS NOT NULL AND Size2 IS NOT NULL AND Size3 IS NOT NULL AND Size4 IS NOT NULL;

SELECT BrandName, Category, Type, Product_Name
FROM [dbo].[Table1]
WHERE Price > (SELECT AVG(Price) FROM Table1);

SELECT t1.BrandName, t1.Category, t1.Type, t1.Product_Name, t2.color1, t2.color2, t2.color3, t2.color4
FROM [dbo].[Table1] t1
JOIN [dbo].[Table2] t2 ON t1.Sno= t2.Sno;

SELECT t1.Type, t1.Product_Name, AVG(t2.Reviews) AS Average_Reviews
FROM [dbo].[Table1] t1
JOIN [dbo].[Table2] t2 ON t1.Sno = t2.Sno
GROUP BY t1.Type, t1.Product_Name;

SELECT t1.Product_Name, t2.Material_type AS Common_Material_Type
FROM [dbo].[Table1] t1
JOIN [dbo].[Table2] t2 ON t1.Sno = t2.Sno
WHERE t2.Material_type = (
    SELECT TOP 1 Material_type
    FROM Table2
    GROUP BY Material_type
    ORDER BY COUNT(*) DESC
);

SELECT t2.Weartype, t2.Material_type, t3.Size1, t3.Size2, t3.Size3, t3.Size4
FROM [dbo].[Table2] t2
JOIN [dbo].[Table3] t3 ON t2.Sno = t3.Sno;

SELECT t1.Type, AVG(TRY_CONVERT(float, t3.Return_time)) AS Average_Return_Time
FROM [dbo].[Table1] t1
JOIN [dbo].[Table3] t3 ON t1.Sno = t3.Sno
GROUP BY t1.Type;

SELECT t1.Type, t3.Country, t3.Return_time, t3.Occasion
FROM [dbo].[Table1] t1
JOIN [dbo].[Table3] t3 ON t1.Sno = t3.Sno;



































