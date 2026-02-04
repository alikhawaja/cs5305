FROM apache/spark:4.0.1-scala2.13-java21-python3-r-ubuntu

USER root

# Install delta-spark python package
RUN pip3 install delta-spark==4.0.1 

# Pre-download Delta JARs to the Spark jars directory
# This ensures Delta is available immediately on startup
ADD https://repo1.maven.org/maven2/io/delta/delta-spark_2.13/4.0.1/delta-spark_2.13-4.0.1.jar /opt/spark/jars/
ADD https://repo1.maven.org/maven2/io/delta/delta-storage/4.0.1/delta-storage-4.0.1.jar /opt/spark/jars/

USER spark