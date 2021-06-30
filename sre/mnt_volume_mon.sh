#!/bin/bash
set -exuo pipefail
## 하는 일 : /mnt 디렉토리의 용량 감시

DIR="/mnt"
SIZE="$(du -m ${DIR} | grep cent2 | awk '{ print $1}')"
HOST="$(hostname)"

if [ ${SIZE} -ge 1024 ]
then
        TEXT="${DIR}사용량이 1기가가 넘었습니다"
        /root/monitor/send_msg.sh "${HOST}" "${TEXT}"
fi