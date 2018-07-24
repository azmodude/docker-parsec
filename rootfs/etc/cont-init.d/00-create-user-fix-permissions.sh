#!/usr/bin/with-contenv /bin/bash

me=$(basename "$0")

>&2 echo "[${me}] Adding parsec with UID ${USER_UID}."
useradd -c 'Parsec Run User' -s /bin/bash -m -u "${USER_UID}" \
    parsec > /dev/null
>&2 echo "[${me}] Changing group users to GID ${USER_GID} and adding parsec to it."
(groupmod -g "${USER_GID}" users && usermod -g users parsec) > /dev/null
>&2 echo "[${me}] Adding parsec to video group ${VIDEO_GID}."
(groupmod -g "${VIDEO_GID}" video && gpasswd -a parsec video) > /dev/null
>&2 echo -n "[${me}] Fixing permissions to possibly changed UID/GID of "
>&2 echo "${USER_UID}/${USER_GID} combination."
chown -R "${USER_UID}":"${USER_GID}" /home/parsec

