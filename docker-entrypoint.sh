#!/bin/bash

set -eo pipefail

chown -R www-data:www-data /var/www/html/images
aws s3 cp s3://${S3_BACKET_NAME}/${S3_KEY} /var/www/html/LocalSettings.php

case "$1" in
    mediawiki)
        apache2-foreground
        exit 0
        ;;

    help)
        echo "nothing."
        exit 0
        ;;
esac

exec "$@"
