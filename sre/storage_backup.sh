#!/bin/bash

## 변수설정
HOST="$(/usr/bin/hostname)"
LOG="/tmp/backup.log"
PUSH="/root/monitor/send_msg.sh"
DATE="$(/bin/date +%Y.%m.%d)"
#백업할 디렉토리 파일 지정
BAK_LIST="/etc/exports /etc/nfs.conf /etc/nfsmount/conf"
#백업 디렉토리
BAK_PATH="/mnt/BACKUP/${HOST}"
#백업 파일명
BAK_FILE="${BAK_PATH}/${DATE}_${HOST}.tgz"

## 스토리지에 마운트
/usr/bin/mount /mmt

echo "분기 전 로그 패스 ${LOG}"
## 로그 파일 생성
/usr/bin/touch "${LOG}"

echo "IF분기 전 백패스 ${BAK_PATH}"

## 백업디렉토리 확인
if [ -e "${BAK_PATH}" ]
then
        #백업디렉토리 존재하면 echo
        /bin/echo "백업 디렉토리 존재"
else
        #백업 디렉토리 없으면 생성
        /bin/echo "백업디랙토리를 생성합니다"
        /bin/mkdir -p "${BAK_PATH}"
fi

## --- 로그 기록 시작
{
        /bin/echo
        /bin/echo "=== 백업 시작 시각:"
        /usr/bin/date
        /bin/echo

        ## 백업 p:퍼미션유지 P 절대경로 유지
        /usr/bin/tar czpPf "${BAK_FILE}" ${BAK_LIST}

        # 백업 파일 정보
        /bin/echo "=== 백업 파일 정보 : "
        NAME="$(/bin/ls -al "${BAK_FILE}" | awk '{print $9}')"
        SIZE="$(/bin/ls -al "${BAK_FILE}" | awk '{print $5}')"

        /bin/echo "===백업 파일 정보:"
        /bin/echo " | 파일명 : ${NAME}"
        /bin/echo " | 파일 크기: ${SIZE}KB "
        /bin/echo

        /bin/echo "=== 백업 종료시각:"
        /bin/date
        /bin/echo
}>|"${LOG}"


## --- 로그 기록 끝


## 스토리지에 언마운트
/usr/bin/umount /mnt

## 텔레그렘으로 백업 로그 전송
echo "$(/usr/bin/cat "${LOG}")"
"${PUSH}" "${HOST}" "$(/usr/bin/cat "${LOG}")"

## 로그파일삭제
## /bin/rm -f "${LOG}"
