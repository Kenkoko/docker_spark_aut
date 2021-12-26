# FROM debian:stable
# docker build -t my-base-hadoop .
FROM maven:3-jdk-11 


RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      openjdk-11-jdk \
      net-tools \
      curl \
      netcat \
      gnupg \
      libsnappy-dev \
      nano \
    && rm -rf /var/lib/apt/lists/*

      
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/

RUN curl -O https://dist.apache.org/repos/dist/release/hadoop/common/KEYS

RUN gpg --import KEYS

ENV HADOOP_VERSION 2.7.7
ENV HADOOP_URL https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
    && gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop

RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

RUN mkdir /hadoop-data

ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH $HADOOP_HOME/bin/:$PATH

ARG SPARK_VERSION=3.0.1

RUN mkdir /spark \
    && cd /tmp \
    && wget -q "https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-without-hadoop.tgz" \
    && tar -xf "/tmp/spark-$SPARK_VERSION-bin-without-hadoop.tgz" -C /spark --strip-components=1 \
    && rm "/tmp/spark-$SPARK_VERSION-bin-without-hadoop.tgz"

ENV SPARK_HOME=/spark
ENV PATH=$SPARK_HOME:$PATH


RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py37_4.10.3-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

ENV PATH /opt/conda/bin:$PATH

RUN pip install \
            numpy pandas \
            jupyter_enterprise_gateway \
            nano ipywidgets \
            sentence-transformers

RUN pip install --upgrade findspark


# RUN pip install --upgrade jupyter 
# RUN pip install --upgrade findspark


ADD entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
