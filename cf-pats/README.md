Installs [Cloudfoundry Performance Acceptance Tests](https://github.com/cloudfoundry-incubator/pat).

It uses a go alpine linux image as base to be able to compile go and keep a small image size.

## Build locally

```
$ cd cf-pats
$ docker build -t cf-apts .
```

## Run

### Locally

```
$ docker run cf-pats pat -h
```


