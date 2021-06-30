# user Agent란

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
