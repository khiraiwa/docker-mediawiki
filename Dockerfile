FROM alpine:latest as downloader

RUN apk --no-cache add wget ca-certificates && \
  update-ca-certificates

# Download extensions

RUN wget -O MediaWiki-MarkdownExtraParser-master.zip \
  https://github.com/Rican7/MediaWiki-MarkdownExtraParser/archive/master.zip && \
  unzip MediaWiki-MarkdownExtraParser-master.zip && \
  mv MediaWiki-MarkdownExtraParser-master MarkdownExtraParser && \
  wget -O php-markdown-extra-1.2.8.zip https://littoral.michelf.ca/code/php-markdown/php-markdown-extra-1.2.8.zip && \
  unzip php-markdown-extra-1.2.8.zip && \
  mv "PHP Markdown Extra 1.2.8/markdown.php" MarkdownExtraParser/markdown.php

FROM mediawiki:stable

MAINTAINER khiraiwa <the.world.nova@gmail.com>

COPY php.ini /usr/local/etc/php/pip.ini

RUN apt-get update && \
  apt-get install python-setuptools -y && \
  easy_install pip && \
  pip install awscli && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

COPY --from=downloader /MarkdownExtraParser \
     /var/www/html/extensions/MarkdownExtraParser

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ["mediawiki"]
