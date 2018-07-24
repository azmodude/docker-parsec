IMAGE := azmo/parsec
USER_UID := $(shell id -u)
USER_GID := $(shell id -g)
VIDEO_GID := $(shell echo $(shell getent group video) | cut -d: -f3)

build:
	docker build --pull -t $(IMAGE) .

run:
	xhost +local:parsec
	docker run --rm --name parsec --hostname parsec \
		-e USER_UID=$(USER_UID) \
		-e USER_GID=$(USER_GID) \
		-e VIDEO_GID=$(VIDEO_GID) \
		-e DISPLAY=unix$(DISPLAY) \
		-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
		-v /run/user/$(USER_UID)/pulse:/run/pulse:ro \
		--mount source=parsec_home,target=/home/parsec \
		--device=/dev/dri \
		$(IMAGE)
	xhost -local:parsec

shell:
	 docker exec -it -u parsec -e COLUMNS="`tput cols`" \
	 	 -e LINES="`tput lines`" parsec /bin/bash

push:
	docker push azmo/parsec
