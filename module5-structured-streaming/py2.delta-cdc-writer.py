from pyspark.sql import SparkSession
from pyspark.sql.functions import col, current_timestamp, lit
from pyspark.sql.types import StructType, StructField, StringType, IntegerType, TimestampType
import time


# Initialize Spark Session
spark = SparkSession.builder \
    .appName("DeltaCDCWriter") \
    .master("spark://localhost:7077") \
    .config("spark.jars.packages", "io.delta:delta-spark_2.13:4.0.1") \
    .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension") \
    .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog") \
    .getOrCreate()

# Define schema
schema = StructType([
    StructField("id", IntegerType(), True),
    StructField("name", StringType(), True),
    StructField("timestamp", TimestampType(), True)
])

delta_path = "/opt/spark/delta/"

# Create CDC-enabled Delta table
table_path = f"{delta_path}/cdc_writer_table"

print("Creating initial CDC-enabled Delta table...")
initial_data = spark.createDataFrame([(1, "Initial", None)], schema=schema)

initial_data.write \
    .format("delta") \
    .mode("append") \
    .option("changeDataFeed", "true") \
    .save(table_path)

# Write new values every second
counter = 2
for i in range(20):
    time.sleep(1)
    new_data = spark.createDataFrame(
        [(counter, f"Record_{counter}", None)],
        schema=schema
    )
    new_data.write \
        .format("delta") \
        .mode("append") \
        .option("changeDataFeed", "true") \
        .save(table_path)
    
    print(f"Written record {counter}")
    counter += 1

print("CDC-enabled Delta table writing complete!")