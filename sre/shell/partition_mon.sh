#!/bin/bash

# 파티션별 사용량 확인 40% 이상 사용한 파티션 있으면 메시지보냄


TEXT="$(df -h | \
        awk '{
                gsub("%","");
                USE=$5;
                MNT=$6;
                if ( USE > 40 )
                        print MNT, "파티션이", USE, "%를 사용중입니다."

                }' |\
        grep -v "^[A-Z]")"
HOST="${hostname}"

# 40%이상 디스크 사용하는 파티션 있을 경우
# TEXT변수 내용 관리자에게 보냄
if [ ${#TEXT} -gt 1 ]
then
        echo "여기가 관리자에게 메시지 보내는 부분"
        /root/monitor/send_msg.sh "${HOST}" "${TEXT}"
        echo ${TEXT}
fi