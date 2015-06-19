all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""  This is merely a base image for usage read the README file
	@echo ""   1. make run       - build and run docker container

build: builddocker

run: showentropypool builddocker rundocker showentropypool

rundocker:
	@docker run --name=havegedocker \
	--cidfile="cid" \
	-d \
	--privileged \
	-v /tmp:/tmp \
	-v /var/run/docker.sock:/run/docker.sock \
	-v $(shell which docker):/bin/docker \
	-t thalhalla/havegedocker
	@docker ps -l

test:
	@docker run --name=havegedocker \
	--cidfile="cid" \
	--privileged \
	-v /tmp:/tmp \
	-v /var/run/docker.sock:/run/docker.sock \
	-v $(shell which docker):/bin/docker \
	--entrypoint bash \
	-t thalhalla/havegedocker \
	-c 'dpkg -s haveged; cat /dev/random | rngtest -c 1000' 

builddocker:
	/usr/bin/time -v docker build -t thalhalla/havegedocker .

beep:
	@echo "beep"
	@aplay /usr/share/sounds/alsa/Front_Center.wav

kill:
	@docker kill `cat cid`

rm-image:
	@docker rm `cat cid`
	@rm cid

rm: kill rm-image

enter:
	docker exec -i -t `cat cid` /bin/bash

version:
	docker exec -i -t `cat cid` /bin/bash -c 'dpkg -s haveged'

logs:
	docker logs -f `cat cid`

showentropypool:
	cat /proc/sys/kernel/random/entropy_avail

show: showentropypool
