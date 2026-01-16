from pyspark.sql import SparkSession
from pyspark.sql.functions import col, explode, split

# Create Spark session
spark = SparkSession.builder \
    .appName("WordCount") \
    .master("spark://spark-master:7077") \
    .getOrCreate()

# Sample data
data = [
    ("Apache Spark is a unified analytics engine",),
    ("Spark provides high-level APIs in Java, Scala, Python and R",),
    ("Spark also supports a rich set of higher-level tools",)
]

# Create DataFrame
df = spark.createDataFrame(data, ["text"])

# Perform word count
word_count = df.select(
    explode(split(col("text"), " ")).alias("word")
).groupBy("word") \
 .count() \
 .orderBy(col("count").desc())

# Display results
print("\\n=== WORD COUNT RESULTS ===")
word_count.show(20, truncate=False)

# Stop Spark session
spark.stop()
