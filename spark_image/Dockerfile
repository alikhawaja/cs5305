FROM apache/spark:4.0.1-scala2.13-java21-python3-r-ubuntu

USER root

# Install linux utilities
RUN apt-get update && apt-get install -y \
    vim \
    curl \
    wget \
    netcat-openbsd \
    net-tools \
    iputils-ping \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Install delta-spark python package
RUN pip3 install pyspark==4.0.1 delta-spark==4.0.1

# Create startup script that checks SPARK_MODE environment variable
RUN mkdir -p /opt/spark/startup
COPY entrypoint.sh /opt/spark/startup/entrypoint.sh
RUN chmod +x /opt/spark/startup/entrypoint.sh

ENTRYPOINT ["/opt/spark/startup/entrypoint.sh"]

# Pre-download Delta JARs to the Spark jars directory
# This ensures Delta is available immediately on startup
ADD https://repo1.maven.org/maven2/io/delta/delta-spark_2.13/4.0.1/delta-spark_2.13-4.0.1.jar /opt/spark/jars/
ADD https://repo1.maven.org/maven2/io/delta/delta-storage/4.0.1/delta-storage-4.0.1.jar /opt/spark/jars/

USER spark