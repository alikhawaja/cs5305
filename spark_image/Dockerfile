FROM apache/spark:4.0.2-java21

USER root

# Install Python 3.13 from deadsnakes PPA
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y \
    python3.13 \
    python3.13-venv \
    python3.13-dev \
    && rm -rf /var/lib/apt/lists/*

# Install pip for Python 3.13 using get-pip.py
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.13
    
# Install linux utilities
RUN apt-get update && apt-get install -y \
    vim \
    curl \
    wget \
    netcat-openbsd \
    net-tools \
    iputils-ping \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Install delta-spark python package
RUN python3.13 -m pip install pyspark==4.0.1 delta-spark==4.0.1
# Install Jupyter Lab and IPython kernel
RUN python3.13 -m pip install jupyter jupyterlab ipykernel

# Pre-download Delta JARs to the Spark jars directory
# This ensures Delta is available immediately on startup
ADD https://repo1.maven.org/maven2/io/delta/delta-spark_2.13/4.0.1/delta-spark_2.13-4.0.1.jar /opt/spark/jars/
ADD https://repo1.maven.org/maven2/io/delta/delta-storage/4.0.1/delta-storage-4.0.1.jar /opt/spark/jars/


# Set default Spark mode
ENV SPARK_MODE=master

# Create startup script that checks SPARK_MODE environment variable
RUN mkdir -p /opt/spark/startup
COPY ./entrypoint.sh /opt/spark/startup/entrypoint.sh
RUN dos2unix /opt/spark/startup/entrypoint.sh && \
    chmod +x /opt/spark/startup/entrypoint.sh

USER spark

ENTRYPOINT ["/opt/spark/startup/entrypoint.sh"]
