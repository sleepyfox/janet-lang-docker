.PHONEY: echo clean build repl shell push

ID=1001
JANET_VERSION=1.2.0
TAG=ubuntu19.10-janet-$(JANET_VERSION)

echo:
	@ echo "TAG IS" $(TAG)

clean:
	rm -f *~

build:
	git clone --branch v$(JANET_VERSION) git@github.com:janet-lang/janet.git
	make -C ./janet
	docker build \
	--build-arg USER=`whoami` \
	--build-arg UID=$(ID) \
	--build-arg GID=$(ID) \
	-t sleepyfox/janet:$(TAG) .

repl:
	docker run -it -p 8000:8000 sleepyfox/janet:$(TAG) janet

shell:
	docker run -it -p 8000:8000 sleepyfox/janet:$(TAG) bash

push:
	docker push sleepyfox/janet:$(TAG)
	docker tag sleepyfox/janet:$(TAG) sleepyfox/janet:latest
	docker push sleepyfox/janet:latest
