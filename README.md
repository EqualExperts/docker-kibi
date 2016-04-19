#Docker Container for Kibi

First approach to create simple container starting instance of Kibi 0.3.2 
(Highly influenced by the official image for Kibana.)

## Prerequisites

- Docker machine

## Usage

Build the image:

```
$ docker --force-rm build kibi
```

Run the image (assuming elasticsearch is running on http://192.168.10.105:9200):

```
$ docker run -i -t -e ELASTICSEARCH_URL=http://192.168.10.105:9200 -p 5606:5606 kibi
```

You can also run Kibi linked with some elsticsearch container.
Run elasticsearch with named instance:

```
$ docker run --name my-elasticsearch elasticsearch
```

and then run Kibi with --link:

```
$ docker run -i -t --link my-elasticsearch:elasticsearch -p 5606:5606 kibi
```

There is also a possibility to use this image with docker-compose.
For example:

```
elasticsearch:
    image: "elasticsearch:2.2.0"
    ports:
        - "9200:9200"
        - "9300:9300"
mongodb:
    image: "mongo:3.2"
    ports:
      - "27017:27017"
kibi:
    build: ./kibi
    ports:
        - "5606:5606"
    links:
        - elasticsearch
        - mongodb
```

In such case the the build command must be run first:

```
$ docker-compose build
```

and then:

```
$ docker-compose up
```
