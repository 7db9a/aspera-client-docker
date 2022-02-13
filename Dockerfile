FROM centos:centos7

RUN useradd data
USER data
WORKDIR /tmp

RUN true \
 && mkdir aspera \
 && cd aspera \
 && curl https://download.asperasoft.com/download/sw/connect/3.7.4/aspera-connect-3.7.4.147727-linux-64.tar.gz > /tmp/aspera.tar.gz \
 && test $(sha1sum /tmp/aspera.tar.gz |cut -f1 -d\ ) = 14b52dadc1cb5d61dfc768c92a0ba972f3d2fd82 \
 && tar xzf /tmp/aspera.tar.gz \
 && bash aspera*sh \
 && cd .. \
 && rm -rf aspera

ENV ASCP_KEY /home/data/.aspera/connect/etc/asperaweb_id_dsa.openssh
ENV ASCP_LIMIT 40m
ENV ASCP_RETRANSFER_FILE 0
ENV ASCP_PORT 33001
ENV ASCP_SERVER fasp.ebi.ac.uk
ADD ascp.sh /usr/local/bin/ascp.sh
WORKDIR /home/aspera
ENTRYPOINT ["/usr/local/bin/ascp.sh"]