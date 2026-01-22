FROM python:3.10-slim

# Install JDK 21
RUN apt-get update && \
	apt-get install -y openjdk-21-jdk wget && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64

# Install Jupyter and PySpark
RUN pip install --no-cache-dir jupyter pyspark

# Set working directory
WORKDIR /workspace

# Expose Jupyter port
EXPOSE 8888

# Start Jupyter notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
