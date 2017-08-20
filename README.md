## Spring cloud service configuration

This project is used for proof of concept only. Of course, you can contribute, you just need to fork 
and PR your feature.

### Usage

Start the container :

```
docker run -p 8888:8888 -p 8111:8111 sipf/config-service
```

or clone this repository and :

```
docker network create springcloud-overlay
docker-compose up -d
```

You can the, log to [http://127.0.0.1:8888](http://127.0.0.1:8888) to use the service or 
[http://127.0.0.1:8111](http://127.0.0.1:8111) for management. The credential will be 
```supervisor/supervisor```.

### Default Configuration

```
spring:
  cloud:
    config:
      server:
        git:
          uri: https://github.com/sipf/config-service-data
          clone-on-start: true
server:
  port: 8888
security:
  user:
    name: supervisor
    password: supervisor
management:
  security:
    roles: SUPERVISOR
  port: 8111
encrypt:
  key-store:
    location: classpath:keystore.jks
    password: letmein
    alias: testkey
    secret: changeme
```

A fake keystore.jks is provided inside the project for convenience (don't expect this keystore 
or any credentials to be in production :p).

### Building the container

```
docker build -t sipf/config-service .
```

### License & Authors

* License : MIT
* Authors : Leonard TAVAE (leonard.tavae@informatique.gov.pf)
