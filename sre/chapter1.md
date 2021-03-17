
SRE  
---

SRE팀은 기본적으로 기존의 운영팀이 수행하던 업무 수행  
->기존과의 차이는 소프트웨어 전문성 지닌 엔지니어들이 인간의 노동력을 대체할 자동화된 소프트웨어 설계 구현한다는 점  
->끊임없이 엔지니어링 추가하지 않으면 업무부담이 증가하고 더 많은 인력 필요해짐  여기서 중요한건 엔지니어링 중심이 되도록 유도해야 함.  
-> 티켓, 전화 응대, 수작업 등 운영업무 최대 50% 만 할애.  
-> 시간이 흐르면서 SRE 운영부담 최소한의 수준으로 줄어들고 대부분 개발작업에 투입되게 하는걸 목표로 함  
->기본적으로 서비스가 문제없이 동작하고 스스로 복구가 가능한 수준까지 해야함.



>SRE의 신조

- 팀마다 업무의 흐름이 다르므로 SRE들은 각자 맡은 서비스들에 대한 기본적인 책임을   
나누어 부담하고 같은 주요 신조를 공유.  

가용성(availability), 응답시간(latency),성능(performence), 효율성(efficiency),변화관리(change management), 모니터링(monitoring),위기대응(emergency response), 수용량 계획(capacity planning)

google에서는 SRE팀이 주변환경과 교류하는 데 필요한 규범과 원리 문서화.  
이런 규칙과 실무사례를 통해 운영업무 보다 엔지니어링 업무에 더욱 집중할 수 있게함.  
-> 주변환경: 제품개발팀, 테스트팀, 유저 모두 포함  

>지속적으로 엔지니어링에 집중  

SRE 운영업무 투입 시간 최대 50% + 나머지 엔지니어링 투자.  
만약 너무 바쁘다면 다른 인원 투입해서라도 SRE의 시간 확보  
SRE는 하루 최대 2건의 업무만 담당  
->포스트 모텀(post(~후에)morterm(사망)) 이라는 회고 문화로 대소 상관없이 관계자를 모두 모아 회의.  
->특정인 비난X, 발생한 현상, 원인, 개선하기 위해 취한 행동, 대응방안 도출  
->특정인 비난 보다 실수를 공유 자신의 단점 피하거나 숨기지 않고 헤쳐나갈 수 있도록 유도  


>서비스의 안정성 유지하며 변화를 최대한 수용한다

제품개발팀 과 SRE팀 각자 목표 달성 과정 발생 구조적 충돌 해소해 나가며, 생산적 관계 유지 가능.  
`구조적 충돌`: 혁신의 속도와 제품의 안정성 사이에서 발생.  
SRE팀은 이런 충돌을 표현으로 드러내고 해결 위해 에러예산(error budget) 개념 사용.  
`에러예산`: 전체에서 목표가용성을 뺀 값.  
신뢰성 목표 100% 는 잘못된 설정 이라는 전재에서 나온 개념.  
통상 소프트웨어, 서비스, 시스템의 신뢰성 목표 100%될 수 없음.  
특정 레이어 신뢰성 100% 라도 네트워크, 사용자의 컴퓨터, 전력 공급선 등 영향받을  
곳이 너무 많고 특정할 수 없음.  
이는 100%과 99.99%의 차이를 설명할 수 없게 만든다.  

ex) 서비스 목표 가용성 99.99% -> 에러예산 0.01%  

SRE 는 새로운 기능 빠른 출시위해 감수할 위험 처리하는데 에러예산 사용.  
ex) 새로운 기능의 단계적 출시와 1%의 사용자 대상으로 한 시험 기능 출시와 같은 전략 차용 가능  

SRE의 동기(incentives)에서 발생하는 구조적 충돌 역시 해소 가능.  
에러 에산 도입되면 SRE들은 더이상 `'무정지 시스템' 같은 목표 세우지 않는다.`  
대신 `SRE팀과 제품개발 팀 기능의 출시 속도 그대화 하기 위해 에러예산 활용`  
->이는 만약 시스템이 정지하더라도 예측가능한 감수할 수 있는 상황으로 받아들이게 하고,  
 올바른 대응 유도

 >모니터링
 
 