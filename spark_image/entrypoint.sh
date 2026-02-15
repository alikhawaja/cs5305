#!/bin/bash
if [ "$SPARK_MODE" = "MASTER" ]; then
    # Start Spark Master
    /opt/spark/bin/spark-class org.apache.spark.deploy.master.Master --properties-file /opt/spark/conf/spark-master.conf &
    # Start Spark Connect Server
    /opt/spark/sbin/start-connect-server.sh --properties-file /opt/spark/conf/spark-connect-server.conf &
    # Start Spark History Server
    /opt/spark/sbin/start-history-server.sh --properties-file /opt/spark/conf/spark-history-server.conf
else
    # Start Spark Worker
    /opt/spark/bin/spark-class org.apache.spark.deploy.worker.Worker  --properties-file /opt/spark/conf/spark-worker.conf spark://spark-master:7077
fi