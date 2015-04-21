TAG=0.13.2
DOCKER_HOST := tcp://$(shell boot2docker ip):2376
DOCKER_CERT_PATH := $(shell echo ~)/.boot2docker/certs/boot2docker-vm
DOCKER_TLS_VERIFY := 1

build:
        docker build --tag=wildfly-eclm .

run:
	export DOCKER_TLS_VERIFY=$(DOCKER_TLS_VERIFY);export DOCKER_HOST=$(DOCKER_HOST);export DOCKER_CERT_PATH=$(DOCKER_CERT_PATH);\
	docker run -d -p 8080:8080 -p 9990:9990 --link oracle:oracle wildfly-eclm

run-ext:
export DOCKER_TLS_VERIFY=$(DOCKER_TLS_VERIFY);export DOCKER_HOST=$(DOCKER_HOST);export DOCKER_CERT_PATH=$(DOCKER_CERT_PATH);\
	docker run -d -p 8080:8080 -p 9990:9990 --name eclm-$(TAG) --link oracle:oracle jboss-eclm-$(TAG)

commit:
	export DOCKER_TLS_VERIFY=$(DOCKER_TLS_VERIFY);export DOCKER_HOST=$(DOCKER_HOST);export DOCKER_CERT_PATH=$(DOCKER_CERT_PATH);\
	docker commit 3132192a1260 jboss-eclm-$(TAG)

show:
	export DOCKER_TLS_VERIFY=$(DOCKER_TLS_VERIFY);export DOCKER_HOST=$(DOCKER_HOST);export DOCKER_CERT_PATH=$(DOCKER_CERT_PATH);\
	docker ps

clean:
	export DOCKER_TLS_VERIFY=$(DOCKER_TLS_VERIFY);export DOCKER_HOST=$(DOCKER_HOST);export DOCKER_CERT_PATH=$(DOCKER_CERT_PATH);\
	docker stop jboss-eclm-$(TAG);\
	docker rm jboss-eclm-$(TAG)

all:build,run
