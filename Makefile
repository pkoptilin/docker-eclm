TAG=0.13.2
_DOCKER_HOST := tcp://$(shell boot2docker ip):2376
_DOCKER_CERT_PATH := $(shell echo ~)/.boot2docker/certs/boot2docker-vm
_DOCKER_TLS_VERIFY := 1
CID := $(shell export DOCKER_TLS_VERIFY=$(_DOCKER_TLS_VERIFY);export DOCKER_HOST=$(_DOCKER_HOST);export DOCKER_CERT_PATH=$(_DOCKER_CERT_PATH);docker ps -l -q)
INAME := eclm/wildfly
CMD :=
build:
	docker build --tag=$(INAME) .

run:
	export DOCKER_TLS_VERIFY=$(_DOCKER_TLS_VERIFY);export DOCKER_HOST=$(_DOCKER_HOST);export DOCKER_CERT_PATH=$(_DOCKER_CERT_PATH);\
	docker run -d -p 8080:8080 -p 9990:9990 --link oracle:oracle $(INAME)

run-ext:
	export DOCKER_TLS_VERIFY=$(_DOCKER_TLS_VERIFY);export DOCKER_HOST=$(_DOCKER_HOST);export DOCKER_CERT_PATH=$(_DOCKER_CERT_PATH);\
	docker run -d -p 8080:8080 -p 9990:9990 --name eclm-$(TAG) --link oracle:oracle $(INAME):$(TAG) $(CMD)

debug:
	export DOCKER_TLS_VERIFY=$(_DOCKER_TLS_VERIFY);export DOCKER_HOST=$(_DOCKER_HOST);export DOCKER_CERT_PATH=$(_DOCKER_CERT_PATH);\
	docker run -d -p 8080:8080 -p 9990:9990 --link oracle:oracle $(INAME) /opt/jboss/wildfly/bin/standalone.sh --debug 8787 --server-config standalone-full-ha.xml -b 0.0.0.0 -bmanagement 0.0.0.0

bash:
	export DOCKER_TLS_VERIFY=$(_DOCKER_TLS_VERIFY);export DOCKER_HOST=$(_DOCKER_HOST);export DOCKER_CERT_PATH=$(_DOCKER_CERT_PATH);\
        docker run -ti -p 8080:8080 -p 9990:9990 --name eclm-$(TAG) --link oracle:oracle $(INAME):$(TAG) /bin/bash
commit:
	export DOCKER_TLS_VERIFY=$(_DOCKER_TLS_VERIFY);export DOCKER_HOST=$(_DOCKER_HOST);export DOCKER_CERT_PATH=$(_DOCKER_CERT_PATH);\
	docker commit $(CID) $(INAME):$(TAG)

stop:
	export DOCKER_TLS_VERIFY=$(_DOCKER_TLS_VERIFY);export DOCKER_HOST=$(_DOCKER_HOST);export DOCKER_CERT_PATH=$(_DOCKER_CERT_PATH);\
	docker stop $(CID)

show:
	export DOCKER_TLS_VERIFY=$(_DOCKER_TLS_VERIFY);export DOCKER_HOST=$(_DOCKER_HOST);export DOCKER_CERT_PATH=$(_DOCKER_CERT_PATH);\
	docker ps;\
	docker logs $(CID)

log: 
	export DOCKER_TLS_VERIFY=$(_DOCKER_TLS_VERIFY);export DOCKER_HOST=$(_DOCKER_HOST);export DOCKER_CERT_PATH=$(_DOCKER_CERT_PATH);\
	docker logs -f $(CID)

clean:
	export DOCKER_TLS_VERIFY=$(_DOCKER_TLS_VERIFY);export DOCKER_HOST=$(_DOCKER_HOST);export DOCKER_CERT_PATH=$(_DOCKER_CERT_PATH);\
	docker stop $(INAME):$(TAG);\
	docker rm eclm-$(TAG)

help:
	@echo wildfly admin console: user:admin pass: Admin#70365
	@echo when deploy war, runtime name must be 'eclm.war'

all:clean,build,run
