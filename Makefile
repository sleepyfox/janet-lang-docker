.PHONEY: echo clean build run

TAG=alpine3.10.1-janet-1.1.0

echo:
	@ echo "TAG IS" $(TAG)

clean:
	rm -f *~ hello-world basic-server

build:
	docker build --build-arg USER=`whoami` -t sleepyfox/janet:$(TAG) .

repl:
	docker run -it -p 8080:8080 sleepyfox/janet:$(TAG) sh -c './janet'

push:
	docker push sleepyfox/janet:$(TAG)
