-- Insert data into each partition
USE cs5305;
GO

-- Insert 5 rows into Partition 1 (OrderID <= 100000)
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, OrderStatus) VALUES
(1, 101, '2024-01-01', 150.50, 'Completed'),
(2, 102, '2024-01-02', 275.75, 'Pending'),
(3, 103, '2024-01-03', 89.99, 'Shipped'),
(4, 104, '2024-01-04', 420.00, 'Processing'),
(5, 105, '2024-01-05', 199.25, 'Completed');

-- Insert 5 rows into Partition 2 (100001 <= OrderID <= 200000)
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, OrderStatus) VALUES
(150000, 201, '2024-02-01', 325.50, 'Completed'),
(150001, 202, '2024-02-02', 180.75, 'Pending'),
(150002, 203, '2024-02-03', 450.99, 'Shipped'),
(150003, 204, '2024-02-04', 720.00, 'Processing'),
(150004, 205, '2024-02-05', 299.25, 'Completed');

-- Insert 5 rows into Partition 3 (200001 <= OrderID <= 300000)
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, OrderStatus) VALUES
(250000, 301, '2024-03-01', 125.50, 'Completed'),
(250001, 302, '2024-03-02', 380.75, 'Pending'),
(250002, 303, '2024-03-03', 650.99, 'Shipped'),
(250003, 304, '2024-03-04', 220.00, 'Processing'),
(250004, 305, '2024-03-05', 399.25, 'Completed');

-- Insert 5 rows into Partition 4 (OrderID > 300000)
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, OrderStatus) VALUES
(350000, 401, '2024-04-01', 525.50, 'Completed'),
(350001, 402, '2024-04-02', 680.75, 'Pending'),
(350002, 403, '2024-04-03', 850.99, 'Shipped'),
(350003, 404, '2024-04-04', 920.00, 'Processing'),
(350004, 405, '2024-04-05', 599.25, 'Completed');
GO