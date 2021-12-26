# Base Alpine Linux based image with OpenJDK and Maven
# FROM maven:3-jdk-11
FROM my-base-hadoop



# Metadata
LABEL maintainer="Nick Ruest <ruestn@gmail.com>"
LABEL description="Docker image for the Archives Unleashed Toolkit."
LABEL website="http://archivesunleashed.org/"


# Sample resources
RUN git clone https://github.com/archivesunleashed/aut-resources.git

# Archives Unleashed Toolkit
# RUN mkdir /aut \
#     && cd /aut \
#     && wget -q https://github.com/archivesunleashed/aut/releases/download/aut-0.90.4/aut-0.90.4-fatjar.jar \
#     && wget -q https://github.com/archivesunleashed/aut/releases/download/aut-0.90.4/aut-0.90.4.zip

# # Archives Unleashed Toolkit
RUN git clone https://github.com/archivesunleashed/aut.git /aut
#     && cd /aut \
#     && export JAVA_OPTS=-Xmx512m \
#     && mvn clean install

RUN cd /aut \
    && wget -q https://github.com/archivesunleashed/aut/releases/download/aut-0.90.4/aut-0.90.4-fatjar.jar \
    && wget -q https://github.com/archivesunleashed/aut/releases/download/aut-0.90.4/aut-0.90.4.zip
# # Install relevant python packages
# RUN apt --assume-yes update && apt --assume-yes install build-essential python3 python3-pip python3-dev software-properties-common\
#                && apt --assume-yes update \
#                && apt --assume-yes install nodejs npm

# RUN pip install -U \
#             numpy pandas \
#             jupyter_enterprise_gateway \ 
#             nano ipywidgets \
#             sentence-transformers

# # RUN pip install --upgrade jupyter 
# RUN pip install --upgrade findspark

# RUN pip install jupyter_contrib_nbextensions

# RUN pip install jupyterlab-sparkmonitor
# RUN ipython profile create --ipython-dir=.ipython
# RUN echo "c.InteractiveShellApp.extensions.append('sparkmonitor.kernelextension')" >>  .ipython/profile_default/ipython_config.py

# RUN jupyter nbextension install sparkmonitor --py && \
#     jupyter nbextension enable  sparkmonitor --py

# RUN jupyter contrib nbextension install --user

# RUN pip install sparkmonitor-s==0.0.11 && \
# jupyter nbextension install sparkmonitor --py --user --symlink && \
# jupyter nbextension enable sparkmonitor --py --user && \
# jupyter serverextension enable --py --user sparkmonitor && \
# ipython profile create && \
# echo "c.InteractiveShellApp.extensions.append('sparkmonitor.kernelextension')" >>  $(ipython profile locate default)/ipython_kernel_config.py

## Build variables
#######################



# Spark shell
# RUN mkdir /spark \
#     && cd /tmp \
#     && wget -q "https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz" \
#     && tar -xf "/tmp/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz" -C /spark --strip-components=1 \
#     && rm "/tmp/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz"

# RUN export PYSPARK_DRIVER_PYTHON=jupyter
# RUN export PYSPARK_DRIVER_PYTHON_OPTS="notebook --ip 0.0.0.0 --no-browser --allow-root"


ADD run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]
# CMD export PYSPARK_DRIVER_PYTHON=jupyter; export PYSPARK_DRIVER_PYTHON_OPTS="notebook --ip 0.0.0.0 --no-browser --allow-root"; /spark/bin/pyspark --py-files /aut/target/aut.zip --jars /aut/target/aut-0.90.5-SNAPSHOT-fatjar.jar


