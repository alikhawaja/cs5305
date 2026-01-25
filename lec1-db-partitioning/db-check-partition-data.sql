use cs5305;
GO
-- Verify partition information
SELECT 
    p.partition_number,
    p.rows,
    fg.name AS filegroup_name
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.partition_schemes ps ON dds.partition_scheme_id = ps.data_space_id
JOIN sys.filegroups fg ON dds.data_space_id = fg.data_space_id
WHERE p.object_id = OBJECT_ID('Orders')
ORDER BY p.partition_number;
GO