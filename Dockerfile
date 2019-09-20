From centos:6.9_privileged

MAINTAINER byz "byuezu@extremevalue.cn"

WORKDIR /home

COPY profile /etc
COPY jdk-8u221-linux-x64.tar.gz /home
COPY elasticsearch-6.2.4.tar.gz /home
COPY elasticsearch.yml /home
COPY run.sh /home

RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && groupadd elasticsearch \
    && useradd elasticsearch -g elasticsearch \
#   && echo "123456" | passwd --stdin elasticsearch \
    && tar zxf /home/jdk-8u221-linux-x64.tar.gz -C /home \
    && tar zxf /home/elasticsearch-6.2.4.tar.gz --strip-components 1 -C /home/elasticsearch \
    && echo "* soft nofile 65536" >> /etc/security/limits.conf \
    && echo "* hard nofile 65536" >> /etc/security/limits.conf \
    && echo "elasticsearch soft nproc 4096" >> /etc/security/limits.conf \
    && echo "elasticsearch hard nproc 4096" >> /etc/security/limits.conf \
    && echo "elasticsearch soft memlock unlimited" >> /etc/security/limits.conf \
    && echo "elasticsearch hard memlock unlimited" >> /etc/security/limits.conf \
    && mv /home/elasticsearch.yml /home/elasticsearch/config \
    && chown -R elasticsearch:elasticsearch /home/elasticsearch \
    && echo "source /etc/profile" >> ~/.bashrc \
    && source /etc/profile \
    && rm -rf /home/*.gz

EXPOSE 9200

CMD ["/home/run.sh"]
