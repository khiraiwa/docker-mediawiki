FROM mediawiki:stable

MAINTAINER khiraiwa <the.world.nova@gmail.com>

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apt-get update && \
  apt-get install python-setuptools -y && \
  easy_install pip && \
  pip install awscli && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ["mediawiki"]
