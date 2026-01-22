use master
GO

-- Drop the database if it exists (this will also remove all filegroups, files, partition schemes, and functions)
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'cs5305')
BEGIN 
    ALTER DATABASE cs5305 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE cs5305;
END
GO

-- Create the database with filegroups for partitioning
CREATE DATABASE cs5305;
GO

-- Switch to the new database
USE cs5305;
GO

-- Add filegroups for partitioning
ALTER DATABASE cs5305 ADD FILEGROUP FG1;
ALTER DATABASE cs5305 ADD FILEGROUP FG2;
ALTER DATABASE cs5305 ADD FILEGROUP FG3;
ALTER DATABASE cs5305 ADD FILEGROUP FG4;
GO

-- Add files to each filegroup
ALTER DATABASE cs5305 ADD FILE (
    NAME = 'cs5305_FG1',
    FILENAME = '/var/opt/mssql/data/cs5305_FG1.ndf',
    SIZE = 5MB,
    FILEGROWTH = 5MB
) TO FILEGROUP FG1;

ALTER DATABASE cs5305 ADD FILE (
    NAME = 'cs5305_FG2',
    FILENAME = '/var/opt/mssql/data/cs5305_FG2.ndf',
    SIZE = 5MB,
    FILEGROWTH = 5MB
) TO FILEGROUP FG2;

ALTER DATABASE cs5305 ADD FILE (
    NAME = 'cs5305_FG3',
    FILENAME = '/var/opt/mssql/data/cs5305_FG3.ndf',
    SIZE = 5MB,
    FILEGROWTH = 5MB
) TO FILEGROUP FG3;

ALTER DATABASE cs5305 ADD FILE (
    NAME = 'cs5305_FG4',
    FILENAME = '/var/opt/mssql/data/cs5305_FG4.ndf',
    SIZE = 5MB,
    FILEGROWTH = 5MB
) TO FILEGROUP FG4;
GO

-- Create a partition function (range based on integer values)
CREATE PARTITION FUNCTION pf_RangePartition (INT)
AS RANGE LEFT FOR VALUES (100000, 200000, 300000);
GO

-- Create a partition scheme mapping to the 4 filegroups
CREATE PARTITION SCHEME ps_RangePartition
AS PARTITION pf_RangePartition
TO (FG1, FG2, FG3, FG4);
GO

-- Create a partitioned table
CREATE TABLE Orders (
    OrderID INT NOT NULL,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    OrderStatus VARCHAR(20),
    CONSTRAINT PK_Orders PRIMARY KEY (OrderID)
) ON ps_RangePartition(OrderID);
GO