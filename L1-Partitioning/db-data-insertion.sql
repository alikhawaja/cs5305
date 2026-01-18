-- Get the last OrderID from the table
DECLARE @LastOrderID INT;
SELECT @LastOrderID = ISNULL(MAX(OrderID), 0) FROM Orders;
PRINT 'Last OrderID: ' + CAST(@LastOrderID AS VARCHAR(20));

-- Insert rows into partition 1 (1000 rows)
;WITH Numbers AS (
    SELECT TOP 100000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a CROSS JOIN sys.all_objects b
)
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, OrderStatus)
SELECT 
    @LastOrderID + n,
    ABS(CHECKSUM(NEWID())) % 1000,
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, '2023-01-01'),
    CAST(ABS(CHECKSUM(NEWID())) % 10000 AS DECIMAL(10,2)),
    CASE n % 4 WHEN 0 THEN 'Pending' WHEN 1 THEN 'Shipped' WHEN 2 THEN 'Delivered' ELSE 'Cancelled' END
FROM Numbers
WHERE n <= 1000;

-- Update @LastOrderID after first insert
SET @LastOrderID = @LastOrderID + 1000;

-- Insert 100k rows into partition 2
;WITH Numbers AS (
    SELECT TOP 100000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a CROSS JOIN sys.all_objects b
)
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, OrderStatus)
SELECT 
    @LastOrderID + n,
    ABS(CHECKSUM(NEWID())) % 1000,
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, '2023-01-01'),
    CAST(ABS(CHECKSUM(NEWID())) % 10000 AS DECIMAL(10,2)),
    CASE n % 4 WHEN 0 THEN 'Pending' WHEN 1 THEN 'Shipped' WHEN 2 THEN 'Delivered' ELSE 'Cancelled' END
FROM Numbers
WHERE n <= 100000;

-- Update @LastOrderID after second insert
SET @LastOrderID = @LastOrderID + 10000;

-- Insert 100k rows into partition 3
;WITH Numbers AS (
    SELECT TOP 100000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a CROSS JOIN sys.all_objects b
)
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, OrderStatus)
SELECT 
    @LastOrderID + n,
    ABS(CHECKSUM(NEWID())) % 10000,
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, '2023-01-01'),
    CAST(ABS(CHECKSUM(NEWID())) % 10000 AS DECIMAL(10,2)),
    CASE n % 4 WHEN 0 THEN 'Pending' WHEN 1 THEN 'Shipped' WHEN 2 THEN 'Delivered' ELSE 'Cancelled' END
FROM Numbers
WHERE n <= 100000;

-- Update @LastOrderID after third insert
SET @LastOrderID = @LastOrderID + 100000;

-- Insert 100k rows into partition 4
;WITH Numbers AS (
    SELECT TOP 100000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a CROSS JOIN sys.all_objects b
)
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, OrderStatus)
SELECT 
    @LastOrderID + n,
    ABS(CHECKSUM(NEWID())) % 10000,
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, '2023-01-01'),
    CAST(ABS(CHECKSUM(NEWID())) % 10000 AS DECIMAL(10,2)),
    CASE n % 4 WHEN 0 THEN 'Pending' WHEN 1 THEN 'Shipped' WHEN 2 THEN 'Delivered' ELSE 'Cancelled' END
FROM Numbers
WHERE n <= 100000;