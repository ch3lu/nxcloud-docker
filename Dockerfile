FROM ubuntu:latest

LABEL maintainer="Rob Asher"
LABEL version="0.1"
LABEL release-date="2022-06-23"
LABEL source="https://github.com/deepwoods/nxcloud-docker"


RUN apt -y update && apt -y upgrade \
  && apt -y install --no-install-recommends curl openjdk-11-jre-headless \
  && curl $(printf ' -O http://pub.nxfilter.org/nxcloud-%s.deb' $(curl https://nxfilter.org/curnxc.php)) \
  && apt -y install --no-install-recommends ./$(printf 'nxcloud-%s.deb' $(curl https://nxfilter.org/curnxc.php)) \
  && apt -y clean autoclean \
  && apt -y autoremove \
  && rm -rf ./$(printf 'nxcloud-%s.deb' $(curl https://nxfilter.org/curnxc.php)) \
  && rm -rf /var/lib/apt && rm -rf /var/lib/dpkg && rm -rf /var/lib/cache && rm -rf /var/lib/log \
  && echo "$(printf 'nxcloud-%s.deb' $(curl https://nxfilter.org/curnxc.php))" > /nxcloud/version.txt

EXPOSE 53/udp 80 443 19001 19002 19003

CMD ["/nxcloud/bin/startup.sh"]