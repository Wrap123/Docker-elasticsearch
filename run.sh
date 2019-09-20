#!/bin/bash

if [ -e /home/elasticsearch.setup ];
    then
      echo "Already setup elasticsearch,start . . ."
else
    echo "Successful start elasticsearch" &&
    su - elasticsearch -c '/home/elasticsearch/bin/elasticsearch -d' > /home/elasticsearch.setup
fi

sleep 10s

chmod 777 -R /home/elasticsearch/{data,logs}
tail -100f /home/elasticsearch/logs/elasticsearch.log
