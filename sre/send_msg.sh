#!/bin/bash

## telegram bot 으로 메시지 보내는 쉘 스크립트
## 2개의 파라미터가 필요함
## 파라미터가 두개가 안될 경우 사용방법을 출력하고 스크립트 종료
## <파라메터 목록>
## 1. 서버 호스트이름
## 2. 메세지
## 실행결과는 현재 날짜/시각, 서버이름, 지정한 메시지 텔레그램 으로 보냄

# 파라메터 확인

if [ $# -ne 2 ]
then 
    echo
    echo "Usage"
    echo "$0 {HOST_NAME} {MESSAGES}"
    echo 
    echo "$0 \"cent1\" \"/var/log/nginx 파티션을 확인하세요 \""
    echo 
    exit 0
fi

# 텔레그램 봇 정보
ID="soonhari_bot"
API_TOKEN="1879303391:AAEI-cBi2ntYR2aM8YK92OMICVGG_xbYYkw"
URL="https://api.telegram.org/bot${API_TOKEN}/sendMessage"

 https://api.telegram.org/bot
 1879303391:AAEI-cBi2ntYR2aM8YK92OMICVGG_xbYYkw/sendMessage
 1879303391:AAEI-cBi2ntYR2aM8YK92OMICVGG_xbYYkw

# 날짜
DATE="$(date "+%Y-%m-%d %H:%M")"

#보낼 메시지 작성
# ""안에서 [$1] 한건 $1 환경변수에서 불러오기 위함  $2는 입력받은 그대로 출력
TEXT="${DATE} [$1] $2"

#메시지 보내기
#telegram bot의 sendMessage 호출 위한 파라메터 설정해서 호출
curl -s -d "chat_id=${ID}&text=${TEXT}" ${URL} > /dev/null




#
