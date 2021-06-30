#!/bin/bash

# 하는일 : 로그 디렉토리 용량 감시
# 1. 로그 디렉토리 크기 확인
# 2. 크기가 1기가 이상일 경우 관리자에게 알림
# 3. 1기가 미만일 경우 아무것도 안함

DIR="/var/log/nginx"
SIZE="$(du -m ${DIR} | awk '{ print $1}') "
HOST="$(hostname)"

if [ ${SIZE} -ge 1024 ]
then
        TEXT="${DIR} 사용량이 1기가 넘었습니다"
        echo "SIZE: ${SIZE}"
        echo "HOST: ${HOST}"
        echo "TEXT: ${TEXT}"
        /root/monitor/send_msg.sh "${HOST}" "${TEXT}"
fi