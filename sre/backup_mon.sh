#!/bin/bash

## 변수 지정
TODAY=$(/bin/date +%Y,%m,%d)
PUSH="/root/monitor/send_msg.sh"
LOG="/tmp/bak_report"
HOST=$(hostname)
WEB="/nfs/BACKUP/cent1/*.tgz"
DB1="/nfs/BACKUP/cent2/*cent2.tgz"
DB2="/nfs/BACKUP/cent2/*DB.tgz"
STR="/nfs/BACKUP/cent3/*.tgz"
WEB_CNT=$(/usr/bin/ls -1 ${WEB} | /usr/bin/wc -l)
DBK_CNT1=$(/usr/bin/ls -1 ${DB1} | /usr/bin/wc -l)
DBK_CNT2=$(/usr/bin/ls -1 ${DB2} | /usr/bin/wc -l)
STR_CNT=$(/usr/bin/ls -1 ${STR} | /usr/bin/wc -l)

## 함수
# 인자를 두개 받아서 비교 메세지 반환
# 인자1: 백업 이름
# 인자2: 백업카운트

function chk_cnt() {
        #인자를 변수에 할당
        NAME="$1"
        CNT="$2"

        # 백업 카운트가 8이 아닐경우 확인 메시지,맞을경우 문제없다출력
        if [ "${CNT}" -eq 8 ]
        then
                /usr/bin/echo "${NAME} 백업 파일 문제 없음"
                /usr/bin/echo
        else
                /usr/bin/echo "${NAME} 백업 파일 8개가 아닙니다 확인하세요!"
                /usr/bin/echo

        fi


}



## 로그파일 초기화 및 생성
/usr/bin/rm -f "${LOG}"
/usr/bin/touch "${LOG}"

## 레포팅 작성
{

                /usr/bin/echo
                /usr/bin/echo "====================="
                /usr/bin/echo "백업 확인"
                /usr/bin/echo "====================="
                /usr/bin/echo
                /usr/bin/echo "웹서버 백업 파일:"
                /usr/bin/ls -1 ${WEB} | /usr/bin/grep "${TODAY}"
                /usr/bin/echo
                /usr/bin/echo "DB서버 백업 파일:"
                /usr/bin/ls -1 ${DB} | /usr/bin/grep "${TODAY}"
                /usr/bin/echo
                /usr/bin/echo "Storage서버 백업 파일:"
                /usr/bin/ls -1 ${STR} | /usr/bin/grep "${TODAY}"

                #백업 별 파일 숫자 확인
                chk_cnt Web_System "${WEB_CNT}"
                chk_cnt DB_System "${DBK_CNT1}"
                chk_cnt DB_Dump "${DBK_CNT2}"
                chk_cnt STORAGE_System "${STR_CNT}"

}>|"${LOG}"

#메시지 전송
"${PUSH}" "${HOST}" "$(/usr/bin/cat "${LOG}")"