FROM ubuntu

LABEL description="9683884@qq.com"
LABEL version="1.0"

ENV IP="192.168.8.20:5555"

WORKDIR /workdir

COPY shell.sh /workdir/

#RUN  sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
#RUN  apt-get clean
RUN apt-get update \
  && apt-get install -y android-tools-adb \
  && rm -rf /var/lib/apt/lists/* \
  && chmod 777 /workdir/shell.sh

CMD ["/workdir/shell.sh"]
