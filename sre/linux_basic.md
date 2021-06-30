## 리눅스와 쉘

리눅스의 종류

- 리눅스 배포판

  - 데미안 계열
    - 우분투, 민트 : UI 예뻐서 많이 사용됨
    - 칼리: 칼리리눅스 해킹용 툴이 많이 내장되서 유명
  - 슬랙웨어 계열 : 오픈수세
  - 젠투 : 리눅스 만들 수 있을정도의 수준의 사람들이 사소한 튜닝해가며 사용 가능한 OS
  - 레드햇 계열: 페도라 (실험적 코드) 여기서 통과한 코드 레드햇에 반영됨  
     CentOS: 레드햇의 무료판
    -> 유료 리눅스, AWS에서도 지원하는 OS

  - 맥 OS: 유닉스 BSD계열 계승해서 만든 OS

- 쉘의 종류
  ![쉘의 종류](./img/bashimg.jpg)
- sh (Bourne Shell) 가장 많이씀, 최초의 유닉스 쉘.  
  가장 많이 쓰는 이유는 함수정도 지원해도 가능한 부분이 많기 때문

- bash : 본쉘의 업그레이드버전. 완벽하게 호환 됨

### 기본 단축키

- Ctrl + a : 라인 맨 앞 이동
- Ctrl + e : 라인 맨 뒤로 이동
- Ctrl + r : history 검색

### 실습환경

https://bellard.org/jslinux/
선택 : Fedora 33 (Linux) Console

# 리눅스 명령어

## 파일 시스템 관련 명령어

- cd (Change directory)  
  cd - 상위 디렉토리로 이동

- ls  
  ls -al 용량과 .파일까지 전부 출력  
  ls -1 세로로 리스트 표시  
  ls -alh 용량을 사람이 읽기 좋은 형태로 보여줌  
  ls -alt 파일을 시간순으로 정렬 (내림차순)
  ls -altr 파일을 시간순의 역순으로 정렬 (오름차순)
  ls -alhR 대문자 R recursive 하위 디렉토리 정보까지 한번에 표시

  ```
  [root@cent1 mnt]# ls -alhR BACKUP/
  BACKUP/:
  total 0
  drwxr-xr-x  3 root root 19 Jun 26 11:19 .
  drwxr-xr-x. 3 root root 20 Jun 26 10:29 ..
  drwxr-xr-x  2 root root 90 Jun 28 04:00 cent1

  BACKUP/cent1:
  total 22M
  drwxr-xr-x 2 root root   90 Jun 28 04:00 .
  drwxr-xr-x 3 root root   19 Jun 26 11:19 ..
  -rw-r--r-- 1 root root 7.1M Jun 26 11:55 2021.06.26_cent1.tgz
  -rw-r--r-- 1 root root 7.1M Jun 27 04:00 2021.06.27_cent1.tgz
  -rw-r--r-- 1 root root 7.1M Jun 28 04:00 2021.06.28_cent1.tgz
  ```

  ls -al | awk '{print $9}'  
   = ls -1

- df (Disk free)  
  : 마운트 된 모든 장치에 대한 현제의 디스크 공간 통계 출력

df -h 사람이 읽기 편한 단위로 용량 보여줌

- h 옵션은 human readable 사람이 읽기 좋은 형태라는 뜻

- mkdir (Make dir)
- p 옵션쓰면 부모패스 없어도 만들어줌

- rmdir (remove dir)  
  빈디렉토리삭제

- rm -rf
  파일 들어있는것도 삭제

- mount  
  : 디스크 장치를 표시하거나 가상 파일시스템으로 지정한 디렉토리 연결(마운트)  
  mount -t nfs 아이피:디렉토리패스 복사할패스
  : 파일시스템 타입 nfs를 이용해서 상대방패스를 내로컬패스로 연결한다.
  ex) mount -t nfs 172.18.1.93:/nfs /mountdir

- umount  
  마운트해제

- stat  
  : 지정한 파일의 파일 통계를 출력  
  접근, 수정이력이나 파일용량 IO Block, Block 사이즈 등 파일 상세정보 확인

```
sh-4.4# stat aaa
 File: aaa
 Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 83h/131d        Inode: 55057       Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2021-06-15 20:28:36.512887200 +0000
Modify: 2021-06-15 20:28:36.512887200 +0000
Change: 2021-06-15 20:28:36.512887200 +0000
```

- touch  
  : 지정한 이름의 빈파일 생성 or 파일 존재할 경우 타임스탬프 갱신 (stat에서확인가능)  
  -> 주된 용도는 파일 생성

- cat (catenate)  
  : 지정한 피일의 내용 출력

- head (디폴트 10)
  : 지정판 파일의 처음부터 지정한 숫자만큼 출력  
  head -n 숫자 파일명
- tail (디폴트 10)  
  : 지정한 파일 꼬리부터 지정한 숫자만큼 출력  
  tail -n 숫자 파일명

tail -f 파일명  
보통 소문자f 사용 파일 갱신되는걸 계속 출력 할때

tail -F 파일명  
로그파일이 자주 바뀌는 경우 소문자f는 안되는데 F하면 자동으로 바꿔서참조

- cp  
  cp -rfp 원본파일패스/파일명 복사팔파일패스/파일명  
  r 은 recursive 하위디랙토리 포함해서 복사할때 경로 만들어 줌  
  f force 같은 파일 있더라도 덮어쓰는 옵션  
  p permission 파일권한 그대로 복사

- mv : 파일 옮길때모다 파일명 변경시 더 많이 씀. 파일, 디렉토리 이동

- rename : 지정한 규칙따라 여러개 파일 이름 변경  
  rename 변경전파일명 변경후파일명 대상파일

```
#test1 test2 test3
$ rename test test0 test?
#test01 test02 test03
$rename test0 test test??이나 test0?이나 test[0-9]?이나 test*
#test1 test2 test3
```

- rm
  : 지정한 파일 삭제  
  rm -f :파일인경우  
  rm -f test\* 삭제할 패턴이나 이름  
  rm -r : 폴더일경우  
  recursive 하위디렉토리와 파일까지 포함한다는 의미  
  -> 삭제안되면 rm -rf  
  rm -f : 강제로 삭제한다는 의미  
  rm -i : 삭제 확인후 삭제

```
sh-4.4# rm -i test03 test04
rm: remove regular empty file 'test03'? ^C

sh-4.4# rm -f test01 test02

sh-4.4# touch test01 test02 test03 test04 test05
sh-4.4# rm -f test*
```

- less
  상하로 커서 이동이 가능한 파일 보기

- ln
  : 지정한 파일 심볼릭링크나 하드링크 생성
  - 디폴트 하드링크
  - 옵션-s 심볼릭링크
    ln 옵션 링크원본파일패스/이름 링크파일패스/이름

심볼릭링크: 윈도우의 바로가기와 같음. (원본파일 가리킴)
원본 삭제하면 데이터 참조 불가

하드링크: 물리적으로 2개의 파일 각각 다른 이름으로 원본파일 참조해서 있어서 한쪽 삭제해도 원본파일 볼 수 있음

```
sh-4.4# ln -s text.txt symlink.txt
sh-4.4# ls
hardlink.txt  symlink.txt  text.txt
sh-4.4# ls -al
-rw-r--r-- 1 root root   14 Jun 16 12:38 hardlink.txt
lrwxrwxrwx 1 root root    8 Jun 16 13:20 symlink.txt -> text.txt
-rw-r--r-- 1 root root   11 Jun 16 12:17 text.txt
sh-4.4# cat symlink.txt
1
2
sh-4.4# mv text.txt test.txt
sh-4.4# ls -al
-rw-r--r-- 1 root root   14 Jun 16 12:38 hardlink.txt
lrwxrwxrwx 1 root root    8 Jun 16 13:20 symlink.txt -> text.txt
-rw-r--r-- 1 root root   11 Jun 16 12:17 test.txt
sh-4.4# cat symlink.txt
cat: symlink.txt: No such file or directory
```

- paste
  : 지정한 파일들의 행을 읽어 탭으로 구분하여 병합

```
sh-4.4# cat txt1
111
222
333
sh-4.4# cat txt2
aaa
bbb
ccc
sh-4.4# paste txt1 txt2
111     aaa
222     bbb
333     ccc
```

- dd (Dataset Dafinition)  
  : 블록 단위로 데이터셋 정의하여 파일 쓰고 읽음  
  드라이브 성능측정할때 많이 씀

더미파일 생성법  
 dd if=인풋파일이름 of=아웃풋파일이름 bs=바이트(블록사이즈아님) count=블럭복사횟수  
 <bs옵션>
ibs=input파일사이즈  
 obs=output파일사이즈  
 bs=ibs,obs둘다 동일하게맞춰줌

> /dev/urandom 리눅스 장치파일 인데 랜덤하게 택스트생성해줌
> /dev 디렉토리 밑에는 여러 장치나 그에 준하는 파일이 존재.
> /dev/zero 는 0으로 채워줌

```
sh-4.4# dd if=/dev/urandom of=ddtest bs=1024 count=1024
10+0 records in
10+0 records out
10240 bytes (10 kB, 10 KiB) copied, 0.0004123 s, 24.8 MB/s
sh-4.4# ls -alh
-rw-r--r-- 1 root root  10K Jun 16 13:57 ddtest

sh-4.4# dd if=/dev/urandom of=ddtest bs=1024 count=1024
1024+0 records in
1024+0 records out
1048576 bytes (1.0 MB, 1.0 MiB) copied, 0.0285102 s, 36.8 MB/s
sh-4.4# ls -alh
total 1.1M
-rw-r--r-- 1 root root 1.0M Jun 16 14:00 ddtest
```

-tar (Tape Archive)  
: 데이터 및 디렉토리 하나로 묶고 품 (압축도 가능)

- 압축할때
  - tar -cvzf 타르볼파일명.tgz 디랙토리명/파일명  
     -create
    - verbose장황하다(자세한 로그볼때v옵션많음)  
      zip으로 압축한다
    - f 파일명 명시한다는 의미  
      파라메터 파일명
    - 파일 묶기만 하면 tar
    - 압축이 들어가면 통상적으로  
      gzip으로 압축했다는 의미에서 tgz
    - p permission 파일 권한그대로 유지
    - P 파일의 절대경로 유지
  ```
  sh-4.4# tar -cvzf tar.tgz tarprac
  tarprac/
  tarprac/ddtest2
  tarprac/ddtest
  tarprac/ddtest1
  sh-4.4# ls -al
  -rw-r--r-- 1 root root  207 Jun 16 14:11 tar.tgz
  drwxr-xr-x 2 root root 4096 Jun 16 14:09 tarprac
  ```
- 압축풀때
  - tar -xvzf 타르볼파일명  
    -> x 는 extract 뽑다 추출하다
  ```
  sh-4.4# ls -al
  -rw-r--r-- 1 root root  207 Jun 16 14:11 tar.tgz
  sh-4.4# tar -xvzf tar.tgz
  tarprac/
  tarprac/ddtest2
  tarprac/ddtest
  tarprac/ddtest1
  ```
- tar압축파일확인

  - tar -tf 타르볼파일명
  - t 리스트를보여줘 f 파일을 명시하겠다

  ```
  sh-4.4# tar -tf tar.tgz
  tarprac/
  tarprac/ddtest2
  tarprac/ddtest
  tarprac/ddtest1
  ```

## 프로세스 관련 명령어

> 프로세스란 메모리에 올라가 있는 작업 단위

- ps (Process Status)
  :시스템에서 실행 중인 프로세스 정보 출력  
  -> 굉장히 옛날에 보던 옵션 요즘은 잘 안씀

  - ps -ef
    - UID :프로세스 실행한 유저명
    - PID :프로세스 아이디
    - PPID: Parent 프로세스 아이디
    - STIME: 시작시간
    - TIME : 걸린시간
    - CMD : 명령어  
      -> 길어서 잘 짤리는데 w복수로 붙여서 출력하게함 w갯수많아질수록 길게표시됨
      px axfwwwww

  ```
  sh-4.4# ps -ef
  UID        PID  PPID  C STIME TTY          TIME CMD
  root         1     0  0 Jun15 pts/0    00:00:00 /bin/bash
  root        16     0  0 Jun15 pts/1    00:00:01 /bin/sh
  root       283    16  0 14:35 pts/1    00:00:00 ps -ef
  ```

- ps aux
  - VSZ: 가상 메모리 사용량
  - RSS: 실제 메모리 사용량
  -

```
sh-4.4# ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  12020  3076 pts/0    Ss+  Jun15   0:00 /bin/bash
root        16  0.0  0.0  12144  3380 pts/1    Ss   Jun15   0:01 /bin/sh
root       284  0.0  0.0  44628  3308 pts/1    R+   14:36   0:00 ps aux
```

- pstree (Process Status Tree)  
  : 시스템에서 실행중인 프로세스정보 트리구조로 출력  
  -> 프로세스의 부모자식관계, 몇개의 프로세스 실행중인지 파악용이  
  -> 해커가 임의로 들어와서 쓸데없는 프로세스 실행했다던가, 리소스먹는 프로세스확인시
- top
  : 프로세스 목록 일정시간마다 새로고침하여 화면에 출력하는 툴  
  시스템 전반적인 상황 모니터링 가능

  - 15:04:27 현재시간
  - up: 현재 시스템 live상태라는 뜻
  - 18:51: 시스템 시작되고 시간 얼마나 지났는지
  - 0 users: 몇명의 유저가 접속했는지
  - load average : 현재 서버 load나타냄 uptime 명령어 쓰면 확인 가능
  - tasks 몇개 프로세스 움직이고, 상태들은 어떤지
  - %Cpu(s): 전체 CPU코어의 통계값 숫자1누르면 코어별로 볼 수 있음
    - us :유저가 코어 사용한 시간
    - sy : 시스템이 사용한 시간
    - ni : 우선순위 변경하는데 사용한 시간 nice라는 명령어있나봄
    - id : idle 시간 얼만큼 놀고있느지
    - wa : wait IO주변장치 기다리는데 소요된 시간
    - hi : hardware inturrpt 처리하는데 소요된 시간(주변장치가사용한시간) \
    - si : software inturrpt 처리하는데 소요된 시간
    - st : 서버가 가상화 되었을때 다른 프로세스 처리하는 동안 가상 cpu가 자기 원래 스케줄이 아닌 비자발적으로 대기하는 시간 발생
  - Mem: total전체얼마고, free비어있고, used사용되고, buff/cache가 사용하는 양 11460.3 avail 평균 메모리 사용량
  - Swap: total전체얼마고, free비어있고, used사용되고.
    > Swap 이란?  
    > 시스템 메모리 부족할 경우 하드디스크 일부 공간 활용 RAM처럼 사용할 수 있게하는것  
    > 메모리 부족하면 당장 필요하지않은 프로그렘 데이터를 하드디스크에 옮겨 메모리공간 확보한다.
    > 즉, 물리적 메모리(RAM) 용량 가득 차면 하드디스크 공간을 메모리공간처럼 교환(swap)
    > 하드드라이브라 RAM접근보다 훨씬 느림

  > swapping 이란?
  > RAM부족할 때 우선 하드디스크공간 이용하고 메모리 다시 여유 생겨 사용가능해지면 하드디스크에서 메모리로 옮겨오는것 의미

  ```
  %Cpu0  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
  %Cpu1  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
  %Cpu2  :  0.3 us,  0.0 sy,  0.0 ni, 99.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
  %Cpu3  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
  %Cpu4  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
  %Cpu5  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
  %Cpu6  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
  %Cpu7  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
  ```

```
top - 15:04:27 up 18:51,  0 users,  load average: 0.00, 0.00, 0.00
Tasks:   3 total,   1 running,   2 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :  12692.9 total,  11083.1 free,    587.8 used,   1022.1 buff/cache
MiB Swap:   4096.0 total,   4096.0 free,      0.0 used.  11460.3 avail Mem
  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
  337 root      20   0   49084   3912   3304 R   0.3   0.0   0:00.09 top
    1 root      20   0   12020   3076   2696 S   0.0   0.0   0:00.07 bash
   16 root      20   0   12144   3384   2820 S   0.0   0.0   0:01.72 sh
```

> 프로세스 종료는 k (kill)
> 프로세스 죽이고 싶으면 k 누르면 끌수 있음

```
PID to signal/kill [default pid = 1]
PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
  1 root      20   0   12020   3076   2696 S   0.0   0.0   0:00.07 bash
 16 root      20   0   12144   3384   2820 S   0.0   0.0   0:01.72 sh
337 root      20   0   49084   3912   3304 R   0.0   0.0   0:00.32 top

```

끄고 싶으면 ctrl c , k (default pid로지정된게 top프로세스자신) + 엔터

- nohup (NO HangUPs) 노행업 (백그라운드 프로세스로 실행)
  쉘 스크립트 파일을 데몬 형태(백그라운드 프로세스)로 실행.

```
sh-4.4# echo "nohup Test"
nohup Test
sh-4.4# nohup echo "nohup Test"
nohup: ignoring input and appending output to 'nohup.out'
sh-4.4# ls
nohup.out
sh-4.4# cat nohup.out
nohup Test
```

#### MEMO 데몬(daemon) 이란?

리눅스 시스템이 처음 가동될 때 실행되는 백그라운드 프로세스의 일종  
사용자의 요청을 기다리고 있다가 요청이 발생하면 이에 적절히 대응하는 리스너 역할  
->즉, 메모리에 상주 특정 요청 즉시 대응 할 수 있도록 대기중인 프로세스  
데몬 프로그램의 명령어는 'd'로 끝난다. (ex. ftpd, mysqld, httpd...)

리눅스 시스템은 주로 서버로서의 역할을 많이 수행  
-> 가령, ftp서버, 웹서버, DB서버 등의 역할을 하는 시스템이라면,  
해당 데몬이 실행중이어야 사용자의 요청을 처리할 수가 있다.

- 데몬 실행방법 두가지  
  standalone 통하는 방식 : 일반적으로 빈번히 사용하는 데몬
  super daemon 통하는 방식 : 자주 사용하지 않는 데몬  
  ex)  
  만약 리눅스 서버를 웹서버로 사용한다면,  
  사용자의 웹 서비스 요청이 매우 빈번히 일어날 것이고,  
  따라서 'httpd' 와 같은 웹서버 데몬은 standalone 방식으로 실행한다.

- standalone type daemon

  - 독립적으로 수행되며 서비스 요청에 응답하기 위해 항시 메모리에 상주하는 데몬이다.
  - 데몬의 실행 스크립트 위치 : "/etc/inetd.d/"

- kill  
  지정한 프로세스에 지정한 시그널(시그널번호나 시그널명칭옵션으로 준다) 보내 프로세스 종료  
  top에서 본 si software inturrupt 에 속함

<주요 시그널 3개>

- INT : 프로세스 안전하게 종료하도 함  
  kill -2 프로세스번호  
  kill -INT 프로세스번호
- TERM: 프로세스 안전하게 종료하도 함  
  kill -15 프로세스번호  
  kill -TERM 프로세스번호
- KILL  
  kill -9 프로세스번호

## 네트워크 관련 명령어

- ifconfig (Interface Configration)  
  : 네트워크 인터페스의 활성/비활성화 및 설정(랜카드)

- ip  
  : ip 관련 정보 조회 및 설정

      ```
      # ad, address 양쪽 다 가능
      sh-4.4# ip address show
      1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
          link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
          inet 127.0.0.1/8 scope host lo
            valid_lft forever preferred_lft forever
      2: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1000
          link/sit 0.0.0.0 brd 0.0.0.0
      9: eth0@if10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
          link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0
          inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
            valid_lft forever preferred_lft forever

      #장치를 골라보는 것도 가능
      sh-4.4# ip address show eth0
      9: eth0@if10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
          link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0
          inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
            valid_lft forever preferred_lft forever

      ```

      - 레드햇계열 리눅스 네트워크관련파일 있는곳
      /etc/sysconfig/network-scripts/
      ```
      sh-4.4# ls -al /etc/sysconfig/network-scripts/
      total 12
      drwxr-xr-x 2 root root 4096 Dec  4  2020 .
      drwxr-xr-x 3 root root 4096 Dec  4  2020 ..
      -rw-r--r-- 1 root root  278 Dec  4  2020 ifcfg-ens3
      ```

- netstat  
  : 네트워크 소켓의 통계와 연결상태  
  <자주확인하는 옵션>

1. 서버가 열고있는 포트와 프로그램 확인 옵션  
   netstat -nltpu

   - n : IP나 port번호를 숫자로 보여주는옵션  
     ->/etc/services: service-name과 port 맵핑 정의된 파일
   - l : 포트별 Listen 상태 표시
   - t : tcp
   - p : 프로그램 이름표시
   - u : udp 표시

2. 현재 네트워크상태의 전체를보는 옵션  
   netstat -tanu

- ss  
  : 네트워크 소켓의 연결상태

1. 서버가 열고있는 포트와 프로그램 확인 옵션  
   ss -nltpu
2. 현재 네트워크상태의 전체를보는 옵션  
   ss -tanu

- iptables  
  : 방화벽 설정 도구. 패킷 필터링
- 패킷은 네트워크 통신의 가장 작은 단위
- 패킷은 어떤 서버에서출발해서 어떤 서버의 포트로 도착하느냐 라는 정보 담김
- 기본 들어오는 통신 다 막고 꼭 필요한 포트만 열어주는게 정석
- iptables -nL
- n : 지정한 이름 표시하지않고 포트나 IP 그대로 표시
- L : 현재 정의된 설정의 리스트 표시

<표시되는 정보>  
Chain INPUT : 외부에서 이 서버에 들어오는 통신에 적용할 룰  
Chain FORWARD: 이 서버를 경유하는 통신에 적용할 룰  
Chain OUTPUT: 이 서버에서 나가는 통신에 적용할 룰

- ufw (Uncomplicated FireWall)  
  : iptalbes의 제어를 쉽게 하기 위한 도구

- ping  
  ICMP(Internet Control Messgae Protocol) 인터넷 제어 메시지 프로토콜의 응답 확인 도구  
  프로토콜은 규약  
  OSI 레이어에서 4번째 네트워크 레이어에 속하는 기능
- c 옵션으로 요청 횟수 count 설정 가능

ping -c 5 접속처

- wget (World wide web + GET)  
  : 웹서버로부터 컨텐츠 가져오는 도구

- curl (Client for URLs)  
  : 다양한 프로토콜 사용하는 데이터 전송 도구  
  : 서버 관리자 입장에서 웹서버 정상 접속 여부 확인할때 많이 씀  
   -L 리다이렉트 링크 따라가는 옵션  
   -k https 인증 무시하라는 옵션 통신 확인하려는 것이기때문에 인증서 인증 필요없을때  
   -s 사일런트모드 curl실행하면 통계값 나오는데 생략하라는 소리  
   -o 아웃풋 파일 /dev/null 지정하면 출력파일 null로하겠단 소리

  ```
  # L생략하고 curl 하면 리다이렉트 응답 301 돌이옴
  sh-4.4# curl -kso /dev/null -w "%{http_code}\n" https://gmail.com
  301
  # L붙이니까 리다이렉트 링크따라가서 200 받아옴
  sh-4.4# curl -Lso /dev/null -w "%{http_code}\n" https://gmail.com
  200
  # s 때니까 통계정보 출력됨
  sh-4.4# curl -Lo /dev/null -w "%{http_code}\n" https://gmail.com
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                  Dload  Upload   Total   Spent    Left  Speed
  100   226  100   226    0     0   2825      0 --:--:-- --:--:-- --:--:--  2790
  100   226  100   226    0     0   1221      0 --:--:-- --:--:-- --:--:--  1221
  100   384    0   384    0     0   1010      0 --:--:-- --:--:-- --:--:--  1010
  100 77505    0 77505    0     0   132k      0 --:--:-- --:--:-- --:--:--  132k
  200
  ```

- route  
  : 네트워크 경로정보 (라우팅 테이블)을 출력, 변경하는 도구  
  : 관리자는 보통확인용으로 씀 -add -del 로 삭제추가 가능하긴함  
  Gateway : 외부 네트워크와 연결위한 주소  
  Genmask: 목적지 네트워크의 넷마스크 주소  
  0.0.0.0 기본게이트웨이, 255.255.255.0 호스트  
  Flags: 해당경로에 대한 정보 알려주는 기호 (U살아있다, H호스트,G게이트웨이 향하는 경로)  
  Metrix: 목적지 네트워크까지의 거리  
  Ref : 참조횟수  
  Use: 사용횟수  
  Iface : 네트워크카드

  ```
  Kernel IP routing table
  Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
  default         _gateway        0.0.0.0         UG    0      0        0 eth0
  172.17.0.0      0.0.0.0         255.255.0.0     U     0      0        0 eth0
  ```

# 검색/ 탐색 관련 명령어

- find  
  : 지정한 파일명, 정규표현식 이용 파일 검색

  - find 옵션 찾기시작할패스 파일명(익스프레션, 퍼미션, 갱신날짜,생성날짜 등)

  - mtime 　옵션쓰면 갱신일 기준검색가능
  - atime +n  
    access time 이 n일 이전인 파일을 찾는다.
  - atime -n  
    access time이 n일 이내인 파일을 찾는다.
  - mtime +n  
    n일 이전에 변경된 파일을 찾는다.
  - mtime -n  
    n일 이내에 변경된 파일을 찾는다.

  ```
  # 하루전 데이터
  [root@cent1 monitor]# find ./ -mtime -1
  ./
  ./web_backup.sh
  ./mnt_volue_monitor.sh
  ```

  - exac 사용하면 앞에서 찾은 내용 파라메터로 쉘 실행
    - ls, rm 등
    - 7일전 갱신한 데이터 삭제하고 싶다면 아래같이 실행

  ```
  /usr/bin/find ${BAK_PATH} -mtime +7 -exec rm {} \;

  # 명령어 여러개 실행하고 싶으면
  -exec sh -c "ls -1 {};rm {}" \;
  /usr/bin/find ${BAK_PATH} -mtime +2 -exec sh -c "ls -1 {};rm {}" \;
  ```

- which  
  : 환경변수의 PATH변수에 등록된 디렉토리에 있는 명령어 찾아주는 도구

```
 echo ${PATH}
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

CLI 사용시 명령어 전체 경로 알고싶으면 사용

- grep  
  : 텍스트 검색

  - grep 옵션 찾을문자열 파일명
  - i 대소문자 구분 안함  
    grep -i error /var/log/messages
  - r recursive 하위디랙토리 포함해서 검색할때  
    grep -ir error /var/log/\*

  - c count grep된 라인수 셀때  
    = wc -l 과 같음  
     ps -ef | grep card[0] | wc -l  
     ps -ef | grep -c card[0]

  - v 지정한 문자열포함행 제외한 결과

    ```
    sh-4.4# grep error /var/log/*
    grep: /var/log/anaconda: Is a directory
    grep: /var/log/private: Is a directory
    sh-4.4# grep -ir "error" /var/log/*
    ```

- history  
  입력한 명령어 리스트 저장  
  각 유저 홈 디렉토리별 .bash_history 라는 파일에 저장

## I/O관련 명령어

- redirection
  표준스트림(stdin, stdout, stderr)을 부등호 사용해 지정한 위치로 보낼 수 있는 방향지정 옵션

  - 입력0/출력1/에러2 (표준스트림)을 지정한 곳에 저장해준다

  - 사용법: 명령 리다이렉션기호 파일명
  - \> 파일 내용 초기화해서 덮어씌움
  - \>> 파일에 내용 추가
  - \>| 쉘 스크립트 안에서는 파일 없다고 에러날 수 있어 이거 사용

  ```
  sh-4.4# echo hello > a
  sh-4.4# cat a
  hello
  # a의 내용을 hi로 덮어씌움
  sh-4.4# echo hi > a
  sh-4.4# cat a
  hi
  # a의 내용에 hello 추가됨
  sh-4.4# echo hello >> a
  sh-4.4# cat a
  hi
  hello
  ```

  - 표준스트림 0/1/2 활용

  ```
  # 아래와 같이 txt4는 존재 하지 않아 에러나면 2가 리턴 되는 상황
  $ ls -al txt1 txt2 txt3 txt4
  ls: cannot access 'txt4': 그런 파일이나 디렉터리가 없습니다
  -rw-r--r--. 1 root root 0  6월 18 16:11 txt1
  -rw-r--r--. 1 root root 0  6월 18 16:11 txt2
  -rw-r--r--. 1 root root 0  6월 18 16:11 txt3

  $ ls -al txt1 txt2 txt3 txt4 1> ok 2> ng
  $ ls
  ng  ok  txt1  txt2  txt3
  $ cat ng
  ls: cannot access 'txt4': 그런 파일이나 디렉터리가 없습니다
  $ cat ok
  -rw-r--r--. 1 root root 0  6월 18 16:11 txt1
  -rw-r--r--. 1 root root 0  6월 18 16:11 txt2
  -rw-r--r--. 1 root root 0  6월 18 16:11 txt3
  ```

  - 복수 커맨드 출력 묶어서 리다이랙션
    - report 라는 파일을 매번 /dev/null 을 복사해 빈파일로 초기화
    - 하나하나 >> 주거나
    - { } 로 전채 묶어서 리다이랙션 가능

  ```
  # 파일 생성
  touch report
  # 파일 초기화
  cp -f /dev/null report

  df -h >> report
  pstree >> report
  free -m >> report
  uptime >> report

  {
    df -h
    pstree
    free -m
    uptime
  }>> report


  ```

- echo  
  문자열 출력 도구

- chmod (Change MODe)
  : 파일 디랙토리 모드(접근권한) 변경 도구

  - chmod 권한정보 파일명
  - rwx 를 이진수 자리수로 3자리 4,2,1  
    rw-r--r--  
    6 4 4
  - +r +w +x 로도 줄 수 있음

  ```
  -rw-r--r-- 1 root root   12 Jun 16 13:44 txt1
  sh-4.4# chmod 664 txt1
  -rw-rw-r-- 1 root root   12 Jun 16 13:44 txt1


  ```

- chown (Change the Owner of a file)
  : 소유자 바꾸는 도구  
   권한 소유자 그룹  
   -rw-r--r-- 1 root root 12 Jun 16 13:44 txt2

  - chown 소유자명:그룹명 파일/디렉토리이름

- sudo (Subsitute User Do)  
  : 슈퍼유저인 root 사용자 권한 이용해 명령, 프로그램 실행 도구

- w  
  : 현재 시스템에 로그인한 사용자 목록 출력
- who  
  : 현재 시스템에 로그인한 사용자 목록 간단히 출력

## 기타 명령어

- date

  - 쉘스크립트에서 시간관련 로그 생성이나 참조 등 날짜 필요시 사용
  - d 특정 시점의 날짜 출력  
    date -d '-1 day'  
    미래 보고싶으면 숫자
    date -d '1 day'  
    사용가능한 인수
    week/ month/ day/hour / minute/ second

  - 포맷지정 + 사용
    date '+%Y-%m-%d %H:%M:%S'
    date '+%Y%m%d'

  ```
  sh-4.4# date
  Thu Jun 17 05:37:31 UTC 2021

  sh-4.4# date '+%Y-%m-%d %H:%M:%S'
  2021-06-17 05:48:58
  sh-4.4# date '+%Y%m%d'
  20210617
  ```

  - seq  
    : 지정한 규칙으로 숫자열 출력하는 도구

    - seq 시작숫자 끝숫자

    - 출력형식 지정 f 나 w 사용

      - w  
        가장 큰 자릿수에 맞춰 자릿수 모자라는 수 앞에 0 붙임
        seq -w 1 10

      - f %0자릿수g 시작수 끝수
        seq -f %03g 1 5

      ```
      sh-4.4# seq -f %03g 1 5
      001
      002
      003
      004
      005
      ```

  - more  
    : 내용이 긴 출력의 경우 한 화면씩 지정한 파일의 내용 출력하는 도구

  - watch :  
    지정한 명령어를 지정한 시간(초) 마다 재실행해 화면에 출력하는 도구

    - watch 명령어  
      실시간으로 감시하고 싶을때 주로 씀

  - crontab:  
    리눅스의 잡 스케줄러의 내용 출력 편집 도구

    - l 등록된 잡 확인  
      crontab -l
    - e 잡 등록  
      crontab -e

    - r 크론탭에 등록된 모든잡 삭제

- ls 활용법  
  스크립트 짤때 원하는 결과 만들려면 굉장히 복잡해지니까 옵션 잘 활용할 것
- al, alh, alht, alhtr

- watch  
  모니터링시 지정한 시간마다 지정한명령어 실행 (디폴트2초)
- watch -n 시간(초) "명령 옵션"

- load average 모니터링의 예

  - watch uptime
    - cpu가 미처 처리하지 못하고 대기하는 프로세스의 수 보여줌
    - load average가 높아지는건 리스폰스가 느려질 가능성이 높다는 뜻
    - request 에대한 response 느려진다는 뜻
    - load average 올라가는 원인이 I/O 바운드냐 CPU 바운드냐에따라 달라지므로  
      이게 높다고 무조건느려지는 건 아님

- stress 툴 사용하면 서버에 부하줄수있다
- stress -c 2 -t 30
  코어 2개를 쓰고 30초 동안 부하를 주겠다

## 초 간단 쉘 스크립트

쉘에서 원하는 결과를 얻기위한 명령어를 모은 파일

- 명령어 연속 실행

  - 파이프라인 (|)
    왼쪽 명령결과 표준 스트림을 오른쪽 명령의 입력으로 사용

  ssh host "dt -h | grep /dev"

  - 세미콜론 (;)
    - 왼쪽 명령 끝난 후 이어서 세미콜론 오른쪽 명령 실행
    - 서로 연관성이 없고 각각 독립적으로 실행되는 것들 세미콜론 사용해 순차적으로 실행
    ```
    [root@localhost prac]# cat semi.txt | grep /var ; df -h
    2. ls -al /var/log
    Filesystem           Size  Used Avail Use% Mounted on
    devtmpfs             890M     0  890M   0% /dev
    tmpfs                909M     0  909M   0% /dev/shm
    tmpfs                909M  8.5M  901M   1% /run
    tmpfs                909M     0  909M   0% /sys/fs/cgroup
    /dev/mapper/cl-root   11G  2.3G  8.3G  22% /
    /dev/sda1           1014M  202M  813M  20% /boot
    tmpfs                182M     0  182M   0% /run/user/1000
    ```
  - AND조건 (&&)
  - OR조건 (||)
    > 조건주는법
    >
    > - test 커맨드 사용
        - test 1 == 1 && echo "이 문장은 참"
    > - 대괄호 사용 [1 == 1] && echo "이 문장은 참"

### TEST , 조건문

[ -e aaa ] && tail -n 15 aaa

- e 옵션

- pgrep  
  지정한 프로세스 찾아주는 명령  
  디폴트는 PID만 표시
  - c 옵션 카운트 (프로세스 개수)
  - l 옵션 이름 리스트 표시

```
$ ps -ef | pgrep card
377
378
$ ps -ef | pgrep -c card
8
$ ps -ef | pgrep -l card
377 card0-crtc0
378 card0-crtc1
```

### VIM

단축키
일반모드
i 입력
o 다음줄 입력

비주얼모드
ctrl v
복사하고 싶은 부분이동해서 컨트롤v
v 복사
x 잘라내기
p 붙여넣기

검색
`/` 입력 후 찾고싶은 문자열 검색
`n` 누르면 다음 검색결과로 이동

- :! : vim 내용 확인하다 특정 패스나 파일내용 확인하고 싶으면 커맨드 실행가능

# 간단 쉘 스크립트

1. 리눅스 환경 bash 는 아래 패스에 있는게 약속  
   #! 샤벵이라부름

```
#!/bin/bash

이런식으로 불러다 쓰기도 함
#!/usr/bin/env python

# shell 이름만 입력하면 실행안되는건 환경변수 PATH에 선언안되서
$ shell.sh
bash: shell.sh: command not found
$ echo ${PATH}
/sbin:/bin:/usr/sbin:/usr/bin

아래같이 실행해주면됨
$ ./shell.sh
$ 풀패스/shell.sh
$ bash shell.sh
```

- 조건문 의 구성
- if [ 조건문1 ]; then
- else if [ 조건문2 ]; then
- else
- fi

- 비교조건

  - 숫자

    - A -eq B : equal 같은가
    - A -ne B : negative 다른가
    - A -ge B : greater equal A가 B보다 크거나 같은가
    - A -gt B : greater than A가 B 보다 큰가
    - A -le B : less equal A가 B 보다 작거나 같은가
    - A -lt B : less than A가 B보다 작은가

  - 문자

    - `A = B` : 같은가 (제일 많이씀)
    - A != B
    - A < B : 바이트 크기
    - A > B : 바이트 크기
    - -n A : A문자열 길이 0보다 큰가
    - -z A : A문자열 길이 0인가

  - 파일
    - -d file: 파일이 존재하고 디렉토리인가
    - `-e` file: 파일이 존재하는가 (제일 많이 씀)
    - -f file: 파일존재하고 파일인가
    - -r file: 파일존재 읽을 수 있는가
    - -s file: 파일존재 비어있지 않은가
    - -w file: 파일존재 쓰기 가능한가
  - 조건문 여러개
    - -a and
    - -o or

- case
  - case 변수 in
    - 패턴1)내용;;
    - 패턴2)내용;;
  - \*) 내용;;
- esac

```
CMD=$1
case "${CMD}" in
start)
        echo "nginx start";;
stop)
        echo "nginx stop";;
reload)
        echo "nginx reload";;
configtest)
        echo "nginx conf confirmation";;
*)
        echo "사용법 start stop reload configtest";;
esac
```

### 반복문

- for 변수 in 반복데이터

  - do
    명령어
  - done

- while 조건

  - do
    명령어
  - done

    ```
    while [ "${WNUM}" -le 3 ]
    do
            echo "server ${WNUM}"
            WNUM=$(( ${WNUM} + 1  ))
    done
    ```

  - read 명령과 < 리다이렉션 이용해서 파일 내용 읽어다 반복가능

    ```
    while read WSVR
    do
            echo ${WSVR}
    done < serverlist.sh

    ```

### 산술표현식

- $(( ))
- 산술표현식 쓸때는 괄호 두개로 묶어서 사용 가능
- WNUM=$(( ${WNUM} + 1 ))
- $[ ]
- $ 대괄호 안에서 변수간 연산 가능
- echo $[ $1 / $2 ]
- echo $[ $1 - $2 ]

### $()

쉘 스크립트 안에서 커맨드 실행가능  
ex)  
$(hostname)  
for NUM in $(seq 1 10)

### 함수

```
function 함수명 {

}
```

### 배열

- 배열은 문제 복잡하게 만들어서 자주 안쓰는 기능
- 선언 방법 : 변수명=(one two 3 four)
- 데이터 형식 상관 없고, 띄어쓰기로 구분

```
test_arr=(one two three 4 5 6 7)
echo ${test_arr[0]}
one
echo ${test_arr[2]}
three
echo ${test_arr[3]}
4

$ echo ${test_arr[*]}
one two three 4 5 6 7

$ for i in $(seq 0 6);do echo ${test_arr[${i}]};done
one
two
three
4
5
6
7
```

- tee 명령어
  - 디폴트 덮어쓰기 리다이렉션 > 와 같음
  - tee -a append 리다이랙션 >>
  - tee 쓰면 내용도 더하고 화면에 출력도 해준다
  - cat 하면 되서 그다지 많이쓰진 않음

### 대화식 쉘 스크립트

- read 명령어
  - 사용하면 대화식 커맨드 전환, 사용자 입력 기다림
  - 사용법: read -p "화면에 표시할문자" 변수이름
  - -sp 옵션 붙이면 secret 모드로 입력한 문자 화면에 표시안됨
  - read -p "아무 문자나 입력해주세요" ANY
  - echo ${ANY}

```
# 1~100 사이 숫자 랜덤 생성 GOAL에 저장
# 반복해서 사용자에게 숫자 입력받음
# 입력받은 숫자 GOAL과 비교해서
# 입력받은 숫자 GOAL보다 크면 숫자가 크다는 메시지
# 입력받은 숫자 GOAL보다 작으면 숫자 작다는 메시지
# 입력받은 숫자 GOAL과 같으면 축하메시지 출력, 몇번만에 맞췄는지 알려줌

GOAL=$(($RANDOM% 100+1))
CNT=0

while true
do
        read -p "1~100 사이의 숫자를 입력해 주세요:" NUM
        CNT=$(( ${CNT}+1 ))

        if [ ${NUM} -gt ${GOAL} ]
        then
                echo "입력한 숫자가 더 큽니다"
        elif [ ${NUM} -lt ${GOAL} ]
        then
                echo "입력한 숫자가 더 작습니다"
        elif [ ${NUM} -eq ${GOAL} ]
        then
                echo "정답입니다! ${CNT}만에 맞췄습니다"
                exit 0
        fi
done
```

- 환경정보 보는 쉘스크립트 예제

```
# 1. uptime
# 2. df -h
# 3. free -m
# 4. pstree
# 5. 서버 입력 받아 그 서버 ssh 접속

# 함수
# clear
# txt 메뉴 출력 < menu함수
# 메뉴 선택해서 실행 이후 일시중지 Press any key to continue...
# while true
function menu {
        clear
        # EOF  나올때까지 기재된 모든 내용 출력해줌
        cat << EOF
        ============ 메 뉴 =============
        1. 로드 에버리지
        2. 디스크 상태
        3. 메모리 상태
        4. 프로세스 트리
        5.입력한 서버에 ssh 접속
        6.메뉴 종료
        ===============================
EOF

read -p "원하는 메뉴의 번호를 선택해 주세요" SELECT

}
function press_key {
        echo
        # -n1 하나의 키 입력받는다
        read -n1 -rsp "Press any key to continue..."
        echo
        echo
}
while true
do
        menu
        case ${SELECT} in
        1)
                clear
                echo "로드에버리지"
                uptime
                press_key
                ;;
        2)
                clear
                echo "디스크 상태"
                df -h
                press_key
                ;;
        3)
                clear
                echo "메모리 상태"
                free -m
                press_key
                ;;
        4)
                clear
                echo "프로세스트리"
                pstree
                press_key
                ;;
        5)
                clear
                read -p "접속하고 싶은 서버 아이피 입력" SVR
                sleep 1
                echo "${SVR}에 접속합니다.."
                ssh ${SVR}
                ;;
        6)
                exit 0
                ;;
        *)
                echo "숫자를 잘못 입력 하셨습니다."
                press_key
                ;;
        esac
done
```

- 메뉴가 있는 쉘 스크립트

```

function menu {
        # dialog 는 파일에 입력결과를 저장해서 활용
        # 가로사이즈 20 세로사이즈35 라디오리스트 숫자갯수
        # 라디오 리스트 메뉴 off/on은 처음에 선택되있는지여부
        # 표준입력0 표준출력1 표준에러2
        # dialog선택결과는 사양상 표준에러2에 속해서 2를 리다이렉트로 파일에 보내면
        # 선택결과가 파일에 기록됨


        dialog --title " GUI MENU" \
                --radiolist " 메뉴를 선택해주세요." 20 35 6 \
                1 "로드에버리지" off \
                2 "디스크상태" off \
                3 "메모리상태" off \
                4 "프로세스 트리" off \
                5 "입력한 서버에 접속" off \
                6 "종료" off \
                2>./select
}
function press_key {
        echo
        # -n1 하나의 키 입력받는다
        read -n1 -rsp "Press any key to continue..."
        echo
        echo
}
while true
do
        menu
        SELECT=$(cat ./select)
        case ${SELECT} in
        1)
                clear
                echo "로드에버리지"
                uptime
                press_key
                ;;
        2)
                clear
                echo "디스크 상태"
                df -h
                press_key
                ;;
        3)
                clear
                echo "메모리 상태"
                free -m
                press_key
                ;;
        4)
                clear
                echo "프로세스트리"
                pstree
                press_key
                ;;
        5)
                clear
                read -p "접속하고 싶은 서버 아이피 입력" SVR
                sleep 1
                echo "${SVR}에 접속합니다.."
                ssh ${SVR}
                ;;
        6)
                exit 0
                ;;
        *)
                echo "숫자를 잘못 입력 하셨습니다."
                press_key
                ;;
        esac
done

```

## 고급 명령어

- CUT  
  :간결한 문법으로 파일에서 문자열 필드 뽑아내는 명령

- SED

  - 텍스트 입력 스트림 받아 출력 제어할 수 있는 명령
  - 한줄한줄 읽어 처리해 메모리 적게먹고 매우 빠름
  - 단점: 라인단위 읽어들여 처리해서 번거로움
  - 사용법:

    - sed 옵션 문자열처리\_스크립트 파일명

  - 옵션:
    - e 입력 처리하는 하나의 명령 의미 여러명
    - f file 사전에 명령 추가한 파일 지정해 명령 수행
    - n 각명령 결과 화면 출력안함
    - r 확장된 정규표현 사용
  - 문자열 처리 명령어

    - p print 출력
      - [텍스트라인-범위]/p
    - d delete
      - [텍스트라인-범위]/p
    - s substitute 한 줄에서 처음 나타나는 소스 패턴 결과 패턴으로 치환
      - s/소스패턴/결과패턴/
      - [텍스트라인-범위]s/소스패턴/결과패턴
    - g global
      - 명령어 처리 스크립트의 모든 소스패턴 결과 패턴으로 변경
      - 명령어처리\_스크립트/g

  - 정규표현식

    - 텍스트의 패턴 특수문자 등 사용 표현한 것

  - awk

    - F필드구분자 (읽어들이는 문자열에 구분자줘서 편하게 추출가능)
      - tab, : 이나 특정 문자열

    ```
    07:02:19 up 2 days, 23:12,  2 users,  load average: 0.21, 0.05, 0.02

    $ uptime | awk -Faverage: '{print $2}'
    0.21, 0.05, 0.02

    ```

    - f 파일이름

    ```
     df
    Filesystem          1K-blocks    Used Available Use% Mounted on
    devtmpfs               910340       0    910340   0% /dev
    tmpfs                  930468       0    930468   0% /dev/shm
    tmpfs                  930468    8688    921780   1% /run

    {
        # %를 공백으로
        gsub(/%/,"")
        # 변수선언하고
        PER=0; MNT=""
        if ( NF == 6 ) PER=$5
        if ( PER > 20 ) MNT=$6
        printf "%d%\t%s\n",PER,MNT
    }



    ```

    - 변수=번수값
