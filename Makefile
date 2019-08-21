.PHONEY: echo clean build repl shell push

TAG=ubuntu19.10-janet-1.2.0
ID=1001

echo:
	@ echo "TAG IS" $(TAG)

clean:
	rm -f *~

build:
	docker build \
	--build-arg USER=`whoami` \
	--build-arg UID=$(ID) \
	--build-arg GID=$(ID) \
	-t sleepyfox/janet:$(TAG) .

repl:
	docker run -it -p 8080:8080 sleepyfox/janet:$(TAG) janet

shell:
	docker run -it -p 8080:8080 sleepyfox/janet:$(TAG) bash

push:
	docker push sleepyfox/janet:$(TAG)
	docker tag sleepyfox/janet:$(TAG) sleepyfox/janet:latest
	docker push sleepyfox/janet:latest
