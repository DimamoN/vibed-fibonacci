#About

It's a simple vibe-d app that is configured to be built in Docker folder.
There is a Dockerfile with all dependencies for creating a working Docker image.

#How to build application

```sh
dub build
```

#How to build docker image

> Choose your name for vibed-app if needed
```sh
cd Docker
docker build -t vibed-app .
```

#How to run a docker image

```sh
docker run -p 8080:8080 vibed-app
```

> Or you can use /Docker/build.sh and /Docker/run.sh