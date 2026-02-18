from pyspark.sql import SparkSession
from pyspark.sql.functions import col
from pyspark.sql.types import StructType, StructField, IntegerType, StringType, TimestampType
import time

# Initialize Spark Session
spark = SparkSession.builder \
    .appName("DeltaCDCReader") \
    .spark("spark://localhost:7077") \
    .config("spark.jars.packages", "io.delta:delta-spark_2.13:4.0.1") \
    .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension") \
    .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog") \
    .getOrCreate()

# Path to your Delta table
delta_table_path = "/opt/spark/delta/cdc_table"

# Define schema
schema = StructType([
    StructField("id", IntegerType(), True),
    StructField("name", StringType(), True),
    StructField("timestamp", TimestampType(), True)
])

# Check if table exists, if not create it first
try:
    spark.read.format("delta").load(delta_table_path)
    print("Delta table exists, proceeding with CDC reading...")
    # Reading CDC changes from Delta table
    df = spark.readStream \
        .format("delta") \
        .option("readChangeData", "true") \
        .option("startingVersion", 0) \
        .load(delta_table_path) \
        .schema(schema)

    # Define query with trigger interval of 2 seconds
    query = df.writeStream \
        .format("console") \
        .option("checkpointLocation", "/tmp/delta-cdc-checkpoint") \
        .trigger(processingTime="2 seconds") \
        .start()

    # Run for 10 seconds
    time.sleep(10)

    # Stop the query
    query.stop()
except Exception as e:
    print("Table doesn't exist, exiting. Please run the writer script first to create the table with CDC enabled.")
    exit(1)