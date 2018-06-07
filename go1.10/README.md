Container for building projects that require go 1.10.x series.

It includes :

* Go compiler
* `curl`
* [`godep`](github.com/tools/godep)

## Build locally

```cd go1.10
$ docker build -t go1.10 .
```

## Run

```
docker run -i -t go1.10 go version
docker run -i -t go1.10 curl --version
```
