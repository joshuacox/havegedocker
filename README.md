# havegedocker

Docker Haveged is a container as an entropy gathering service.

Haveged Version: `1.9.1-1`


## Use case

In case you need an entropy gathering service on your docker host but don't want to / can't install locally an entropy gathering service.

The service makes more sense on Cloud servers and more specifically on CoreOS servers where you cannot install locally services.

## Checklist

The purpose of the service is to make sure you have available entropy on your host. To check if you are running low:

```
make show
```

If the number is below `1000` then it is probably depleted.

## Quickstart

To run the container:

```
docker run --privileged -d joshuacox/havegedocker:latest
```
or build and run locally:
```
make run
```

## Test Entropy

In order to test the quality of entropy you can use rngtest
```
make test
```

## Show the logs
```
make logs
```

## Enter the container
```
make enter
```

inspired by the ubuntu based image here:
https://github.com/harbur/docker-haveged
