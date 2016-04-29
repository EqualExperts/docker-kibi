#!/bin/bash

set -e

if [[ "$1" == -* ]]; then
    set -- kibi "$@"
fi

if [ "$1" = 'kibi' ]; then
    if [ "$ELASTICSEARCH_URL" -o "$ELASTICSEARCH_PORT_9200_TCP" ]; then
        : ${ELASTICSEARCH_URL:='http://elasticsearch:9200'}

        sed -ri "s!^(\#\s*)?(elasticsearch\.url:).*!\2 '$ELASTICSEARCH_URL'!" /opt/kibi/config/kibi.yml
    else
        echo >&2 'Missing link configuration or ELASTICSEARCH_URL'
        echo >&2 '  Did you forget to --link some-elasticsearch:elasticsearch'
        echo >&2 '  or -e ELASTICSEARCH_URL=http://some-elasticsearch:9200 ?'
        echo >&2
        exit 1
    fi

    set -- gosu kibi tini -- "$@"
fi

exec "$@"
