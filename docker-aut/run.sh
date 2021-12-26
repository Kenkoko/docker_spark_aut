#!/bin/bash

jar cv0f spark-libs.jar -C $SPARK_HOME/jars/ .
hdfs dfs -mkdir -p spark/share/lib
hdfs dfs -put spark-libs.jar spark/share/lib

cd hadoop-data/
wget -O alice.txt https://www.gutenberg.org/files/11/11-0.txt
hdfs dfs -mkdir -p books
hdfs dfs -put alice.txt books

hdfs dfs -mkdir -p input
hdfs dfs -put /aut-resources/Sample-Data/* input
cd /

# hdfs dfs -mkdir -p warc_files
# hdfs dfs -put /data_subset/* warc_files
# cd $SPARK_HOME/conf/
echo '
spark.master                    yarn
spark.driver.memory             512m
spark.yarn.am.memory            512m
spark.executor.memory           512m
spark.yarn.archive              hdfs://namenode:9000//user/root/spark/share/lib/spark-libs.jar
spark.network.timeout           500s
' > $SPARK_HOME/conf/spark-defaults.conf

export SPARK_HOME=/spark;
export PYSPARK_DRIVER_PYTHON=jupyter; 
export PYSPARK_DRIVER_PYTHON_OPTS="notebook --ip 0.0.0.0 --no-browser --allow-root"; 
# /spark/bin/pyspark --deploy-mode client --master yarn --py-files /aut/target/aut.zip --jars /aut/aut-0.90.4-fatjar.jar
# /spark/bin/pyspark --master yarn --deploy-mode client --py-files /aut/target/aut.zip --jars /aut/aut-0.90.4-fatjar.jar
/spark/bin/pyspark --py-files /aut/aut-0.90.4.zip --jars /aut/aut-0.90.4-fatjar.jar
# export PYSPARK_DRIVER_PYTHON=python; /spark/bin/pyspark --py-files /aut/aut-0.90.4.zip --jars /aut/aut-0.90.4-fatjar.jar

# export PYSPARK_PYTHON=/usr/lib/python3.9/; export PYSPARK_DRIVER_PYTHON=/usr/lib/python3.9/; /spark/bin/pyspark --py-files /aut/target/aut.zip --jars /aut/aut-0.90.4-fatjar.jar
# /spark/bin/spark-shell --master yarn --conf spark.ui.port=4041 --jars /aut/aut-0.90.4-fatjar.jar
# /spark/bin/spark-shell --jars /aut/aut-0.90.4-fatjar.jar

# /spark/bin/spark-shell --packages "io.archivesunleashed:aut:0.90.4-SNAPSHOT" --jars /aut/aut-0.90.4-fatjar.jar

# import io.archivesunleashed._

# RecordLoader.loadArchives("/user/root/input/*.gz", sc).webpages().select($"url").show(20, false)

# /spark/bin/spark-submit --deploy-mode client \
#                --class org.apache.spark.examples.SparkPi \
#                $SPARK_HOME/examples/jars/spark-examples_2.12-3.1.1.jar 10

# var input = spark.read.textFile("books/alice.txt")
# input.filter(line => line.length()>0).count()
# val config = sc.getConf.getAll
# for (conf <- config)
#     println(conf._1 +", "+ conf._2)

# /spark/bin/pyspark --py-files /aut/aut-0.90.4.zip --jars /aut/aut-0.90.4-fatjar.jar

# archive = WebArchive(sc, sqlContext, "/user/root/input/*.gz")



def encode_sent(sentence):
    return model.encode(sentence, convert_to_numpy=True).tolist()

udf_encode_sent = udf(encode_sent)

start = timer()
webpages.select(extract_domain("url").alias("domain")).withColumn('domain', udf_encode_sent("domain")).show(20)
end = timer()
print(f'Time execution (s): {round(end - start, 2)}')