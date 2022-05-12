FROM elasticsearch:7.17.2
MAINTAINER KAA

ENV PATH_ES=/etc/elasticsearch-7.17.2

COPY elasticsearch.yml ${PATH_ES}/config

RUN mkdir /var/lib/logs \
    && chown elasticsearch:elasticsearch /var/lib/logs \
    && mkdir /var/lib/data \
    && chown elasticsearch:elasticsearch /var/lib/data \
    && chown -R elasticsearch:elasticsearch ${PATH_ES} \
    && mkdir ${PATH_ES}/snapshots \
    && chown elasticsearch:elasticsearch ${PATH_ES}/snapshots

EXPOSE 9200

USER elasticsearch

CMD ["/usr/sbin/init"]
CMD ["/etc/elasticsearch-7.17.2/bin/elasticsearch"]