## docker-parsec

A docker image including [Parsec](https://www.parsecgaming.com). Full
hardware-acceleration is only tested on Intel chips for now, NVIDIA
following.

### Usage

``` {.console}
# docker run --rm --name parsec --hostname parsec \
    -e USER_UID=${USER_UID} \
    -e USER_GID=${USER_GID} \
    -e VIDEO_GID=${VIDEO_GID} \
    -e DISPLAY=unix${DISPLAY} \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /run/user/${USER_UID}/pulse:/run/pulse:ro \
    --mount source=parsec_home,target=/home/parsec \
    --device=/dev/dri \
    azmo/parsec
```

-   `USER_UID` and `USER_GID` are required to allow pulseaudio socket
    interaction even in most edge cases. They should match your current
    UID/GID on the host.
-   `VIDEO_GID` is required to allow `/dev/dri` access.

Parsec configuration is stored in a named volume `parsec_home` so saved
logins can persist.

You also need to allow the container to access your X socket using
`xhost`.

There is a
[Makefile](https://github.com/azmodude/docker-parsec/blob/master/Makefile)
included in the [GitHub
repository](https://github.com/azmodude/docker-parsec) that tries to
take care of setting all environment variables and X authentication when
invoked with `make run`.
