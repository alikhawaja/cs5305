
from pyspark.sql import SparkSession
spark = SparkSession.builder.remote("sc://localhost:15002").getOrCreate()

data = [(1, "Ali"), (2, "Sara")]
df = spark.createDataFrame(data, ["id", "name"])
df.write.mode("overwrite").parquet("file:///tmp/out_parquet")
df.show()
spark.stop()
