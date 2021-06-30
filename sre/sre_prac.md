- vagrant file 설정상 cent 1,2,3 으로 나눠 서버 구성

```
cd VWS_vagrant_script
## 괄호 안의 cent[1-3]은 각각 가상서버를 의미하며 생략 가능
## 생략하면 모든 서버를 실행/정지/삭제

# 실행
vagrant up (cent[1-3])

# 정지
vagrant halt (cent[1-3])

# 삭제
vagrant destroy (cent[1-3])

# 상태확인
vagrant status (cent[1-3])
```

- 어플리케이션에 접속
  URL : http://172.18.1.91/www/index.html

- vi /etc/services 가면 리눅스에 예약된 포트번호 목록 확인 가능

```
# cent1 web server
$  netstat -nltpu | grep mysql
tcp6       0      0 :::80                   :::*                    LISTEN      644/nginx: master p

# cent2 mysql server
$ netstat -nltpu
tcp6       0      0 :::xxxx                 :::*                    LISTEN      633/mysqld

$ ps -ef | grep mysql
mysql        633       1  0 16:55 ?        00:00:07 /usr/sbin/mysqld


# cent3 nfs server

$ netstat -nltpu
tcp        0      0 0.0.0.0:xxxx            0.0.0.0:*               LISTEN      -

$ vi /etc/services
nfs             xxxx/tcp        nfsd shilp      # Network File System
nfs             xxxx/udp        nfsd shilp      # Network File System
nfs             xxxx/sctp       nfsd shilp      # Network File System
```

# 트러블 슈팅

1. 에러가 발생하지 않는가?

```
#cent1 웹서버 아래 경로 error로그확인
ls -al /var/log/nginx/

```

2. 서버 로드가 높은가?  
   ->로드 에버리지 코어수 보다 높으면 부하가 높다고 판단 가능  
   ->cat /proc/cpuinfo 프로세서 숫자 확인

```
$ cat /proc/cpuinfo
# uptime에서 로드에버리지
$ uptime
#

```

3. 메모리를 많이 쓰는가

```
free -m
total        used        free      shared  buff/cache   available
Mem:            968         120         614          12         234         698
Swap:          2047           0        2047
```

4. 디스크를 많이 쓰는가

```
$ df -h

# G단위 용량 가진 폴더, 파일확인
$ cd /
$ du -sh * |grep G
du: cannot access 'proc/1808/task/1808/fd/3': No such file or directory
du: cannot access 'proc/1808/task/1808/fdinfo/3': No such file or directory
du: cannot access 'proc/1808/fd/3': No such file or directory
du: cannot access 'proc/1808/fdinfo/3': No such file or directory
2.0G    swapfile
1.2G    usr

# G단위 용량 가진 폴더확인
$ cd /
$ du -h --max-depth=1 | grep G
du: cannot access './proc/1813/task/1813/fd/3': No such file or directory
du: cannot access './proc/1813/task/1813/fdinfo/3': No such file or directory
du: cannot access './proc/1813/fd/4': No such file or directory
du: cannot access './proc/1813/fdinfo/4': No such file or directory
1.2G    ./usr
3.5G    .
```

- 표준 입력에러 없애는법

```
# 응답코드 2주고 /dev/null로 없애줌
du -h --max-depth=1 2>/dev/null
$ du -h --max-depth=1 2>/dev/null | grep G
1.2G    ./usr
3.5G    .
```

- 디스크 용량 확보 후 로그 늘어나는 추이 잠시 직접보고싶다면

```
  # 3초마다 해당코맨드실행
  $ watch -n 3 'ls -alh | grep 감시하고싶은로그이름'
  $ watch -n 3 'df -h'
```

### user Agent

- 브라우저별로 웹서버에 어떤 브라우저가 요청을 보냈는지 알려주기위해 보내줌
- 브라우저발전 역사에 따라 Gecko, KHTML같이 특정 키워드 없으면 웹표준에 맞는 페이지 리턴 안해주기 시작 (IE 때문임)
- 브라우저 출시될 때마다 키워드 따라하느라 User Agent도 길어짐
- 모질라+웹킷+KHTML+겍코+크롬+사파리 추가순서별로 막 조합이 혼재

- Gecko/Fire Fox

  - 넷츠케이프는 겍코 엔진을 기반으로 한 브라우저 모질라를 출시
  - Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/2002082
  - 이후 파이어폭스로 이름을 바꾸며 맨 뒤에 Firefox/1.0

- IE

  - MS는 웹사이트에서 Mozilla가 들어간 사이트만 프레임을 보내주자 유저에이전트에 Mozilla추가
  - Mozilla/1.22 (compatible; MSIE 2.0; Windows 95)

  > 여기서 사단이 발생  
  > 파이어폭스가 웹표준을 준수하며 잘나가던 것과는 달리  
  > IE는 6버전에서 머무르며 웹표준 준수는 커녕 페이지조차 제대로 못보여주는 쓰레기 수준으로 전락해 버린다.  
  >  따라서, 사이트 운영자들은 다시 `Gecko`라는 단어를 찾아서 `Gecko`가 있는 브라우저만 웹표준을 준수한 페이지를 보내줬다.

- Konqueror (KHTML엔진기반 브라우저)

  - IE가아니라 Gecko인척 하고 싶었으므로 like Gecko 추가
  - Mozilla/5.0 (compatible; Konqueror/3.2; FreeBSD) (KHTML, like Gecko)

- Safari

  - KHTML엔진쓰는 Konqueror인척 하고 싶었으므로
  - Mozilla/5.0 (Macintosh; U; PPC Mac OS X; de-de) AppleWebKit/85.7 (KHTML, like Gecko) Safari/85.5가 되었다.

- Chrome

  - Safari 브라우저인척 하고 싶어했으며, Safari는 KHTML인척 하고 싶어했고, KHTML은 Gecko인척 하고 싶어했으며, 모든 브라우저는 모질라 브라우저인척 하고 싶어했으므로

  - "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36"

- Edge

  - IE폐지하고 크롬인척 하고싶어했으므로
  - Mozilla/5.0 (Windows NT 10.0; Win64; x64; ServiceUI 11) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36 Edge/16.16299

- 용량 확인시 필요한 정보만 추출

```
$ cd /var/log/nginx
$ df -h | awk '{gsub("%",""); print $5}'
Use
0
0
3
0
36
0
```

### 로그디렉토리 용량 감시 스크립트

- 스크립트가 해야 할 일
  - 로그 디렉토리의 크기를 확인하고 지정한 용량보다 크면 관리자에게 알림 보냄
- 처리과정 정리 및 명령어

  - 로그 디렉토리 크기 확인 (du)
  - 크기 비교해서 처리 if
  - 관리자에게 알림
    - mail / slack /telegram
  - 스크립트 작성
  - 테스트

  ```
   ## df 로 human readable한 정보취득
   df -h
   ## awk gsub함수로 % 공백으로바꾸고
   ## USE, MNT에 사용량열과 마운트패스열 저장
   | awk '{gsub("%",""); USE=$5; MNT=$6;
   ## 사용량이 40%이상일때 프린트한다
   if ( USE > 40 ) print USE, MNT}'
   ## 컬럼 텝구분으로 표시
   | column -t
   ## 알파벳으로구성된 패턴제외로 컬럼명 제외
   | grep -v "^[A-Z]"

    $ df -h | awk '{gsub("%",""); USE=$5; MNT=$6; if ( USE > 40 ) print USE, MNT}' | column -t | grep -v "^[A-Z]"
  ```

- 메시지 전송에는 텔레그램 봇 생성해서 활용  
  https://ncube.net/telegram%ED%85%94%EB%A0%88%EA%B7%B8%EB%9E%A8-%EB%B4%87%EC%9D%84-%EC%9D%B4%EC%9A%A9%ED%95%B4-%EB%A9%94%EC%84%B8%EC%A7%80-%EC%A0%84%EC%86%A1%ED%95%98%EA%B8%B0/

```
#200M파일생성
 $ dd if=/dev/zero of=/var/log/nginx/test_file3 count=200000 bs=1024
#디렉토리안 용량확인
 $ du -sh *

```

### 디스크 파티션 사용량 감시 스크립트

- 스크립트가 해야 할 일
  - 파티션별 사용량 확인해서 80% 넘어가면 관리자에게 알림 보냄
- 처리 과정의 정리 및 명령어
  - 파티션별 사용량 확인 (df)
  - 크기 비교 처리 (if)
  - 관리자에게 알림
    - mail / slack / telegram
- 스크립트 작성
- 테스트

### 적용

- crontab 사용 분 시간 일 월 단위로 스케줄링

```
# 잡 등록
crontab -e
# 등록된 잡 확인
crontab -l
30 * * * * /root/monitor/partition_mon.sh 2>&1

00 * * * * /root/monitor/log_mon.sh >/dev/null 2>&1
```

## 백업

백업 정책 세우기

- 무엇을
  - 웹: 웹소스, 서버 주요 설정
    - tar볼로 묶어서 보관
  - 데이터베이스: 데이터, 서버 주요 설정
    - db 덤프는 mariadb 전용 백업 툴 mariabackup 사용
  - 스토리지 서버 주요 설정
    - 스토리지는 데이터 용량 크므로 향후 스코리지 이중화 등 통해 데이터 안정성확보
- 언제
  - 하루에 한 번 트래픽이 가장 적은 시간대
    - 새벽 3~5시라 가정
- 어디에
  - 스토리지의 BACKUP 디렉토리 -각 서버이름(hostname) 디렉토리 - /mnt/BACKUP/서버호스트명

### 제한적인 쉘 스크립트의 이해

- set 커맨드

  > set -exuo pipefail

      - e : errexit 첫번째 실행 실패 (exit 코드 0 아닌 상태로 종료되는 명령어)시 쉘스크립트 종료
      - x:  xtrace 디버그용, 매 라인 실행 전에 피룡한 산술확장, 매개변수 확장, 명령치환, 변수대입 등 화면에 출력
      - u: nounset 정의가 안된 변수 사용하면 에러 출력하고 쉘 프로그램 강제 종료
      - o 옵션을 on/off 할 수 있다
          - set -o 옵션명: 옵션 on
          - set +0 옵션명 : 옵션 off
      - pipefail: 옵션명 파이프로 연결된 명령어 전부 true 일때문 ture 반환하도록 설정

- 사용하는 이유
  - 옵션 통해 쉘이 동작하는 방식 제어
  - 버그줄이기

### 백업 모니터링 쉘 스크립트

- 주요 사용 쉘

  - wc ,grep, function

- 작업흐름

  - 쉘스크립트가 해야 할 일

    - 백업 파일을 확인(ls)
    - 오늘 자 백업 파일을 확인 (date, grep)
      - 서버별 파일 리스트를 출력
    - 백업 파일 개수를 확인 (function, ls, wc, if)

      - 7개면 문제 없음
      - 7개가 아니면 백업 종류와 확인하라는 경고메시지 작성

    - 작성한 레포트를 관리자 텔레그램으로 메시지 보냄

- 적용
  - crontab에 등록
