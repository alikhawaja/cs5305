#!/bin/bash
if [ "$SPARK_MODE" = "MASTER" ]; then
    # Start Spark Master
    /opt/spark/bin/spark-class org.apache.spark.deploy.master.Master --properties-file /opt/spark/conf/spark-master.conf &
    # Start Spark Connect Server
    /opt/spark/sbin/start-connect-server.sh --properties-file /opt/spark/conf/spark-connect-server.conf &
    # Start Spark History Server
    /opt/spark/sbin/start-history-server.sh --properties-file /opt/spark/conf/spark-history-server.conf &
    # Keep container running
    tail -f /dev/null
elif [ "$SPARK_MODE" = "WORKER" ]; then
    # Start Spark Worker
    /opt/spark/bin/spark-class org.apache.spark.deploy.worker.Worker --properties-file /opt/spark/conf/spark-worker.conf spark://spark-master:7077
elif [ "$SPARK_MODE" = "JUPYTER" ]; then
    # Start Jupyter Server
    jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''
else
    echo "Invalid SPARK_MODE: $SPARK_MODE. Must be MASTER, WORKER, or JUPYTER."
    exit 1
fi