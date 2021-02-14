## emet

원래 plugin이었으나 지금은 많은 IDE나 text editor에서 내장지원  
html 셀렉터로 상속관계와 값 자동생성 가능  
ex  
아래와같이 입력하고 tab  
$는 반복횟수만큼 숫자 자동생성한다는 뜻  
{}는 태그가 가질 값

    div.container>div.item.item${$}*10
    div item클래스, item+자동연번숫자 {}안에는 들어갈 값을   10번반복하겠다
    실행결과는 다음과 같다.

    <div class="container">
        <div class="item item1">1</div>
        <div class="item item2">2</div>
        <div class="item item3">3</div>
        <div class="item item4">4</div>
        <div class="item item5">5</div>
        <div class="item item6">6</div>
        <div class="item item7">7</div>
        <div class="item item8">8</div>
        <div class="item item9">9</div>
        <div class="item item10">10</div>
    </div>

    vh 는 뷰하이트
    height: 100%
    라고 입력하면 뒤에 부모의 높이에 100%적용하겠다는뜻
    vh쓰면 부모에 상관없이 보이는 뷰의 하이트를쓰겠다 하면 vh로지정
    height: 100vh

## flex-flow

화면 레이아웃 짜게 도와주는 CSS 속성  
column 을 축으로두냐 row를 축으로두냐 정한 뒤  
축을기준으로 레이아웃을 배치한다.  
https://flexboxfroggy.com/#ko 여기가서 연습가능

## 블록에 들어가는 felx-flow속성

    //1. 사용선언
    display: flex;
    //2. 중심축 column으로 설정
    flex-direction: column;
    //3. wrap속성은 화면이 꽉차면 요소들이 줄바꿈되서 표시
    //nowrap주면 개행안함
    flex-wrap: wrap;
    //4. 중심축의 컨탠츠들 어떻게 정렬할지
    // center, space-around, flex-end, space-evenly (똑같은 간격 주기)
    justify-content: flex-end
    //5. 중심축말고 남은 축은 반대축이됨
    //반대축을 기준으로 컨탠츠 어떻게 정렬할지 정하는속성
    //center는 컨탠츠 한가운데 오게함
    align-items: center
    //align-contents 로 줄사이간격 지정가능
    align-content: flex-start space-between

    align-content는 여러 줄들 사이의 간격을 지정하며,
    align-items는 컨테이너 안에서 어떻게 모든 요소들이 정렬하는지를 지정합니다.
    한 줄만 있는 경우, align-content는 효과를 보이지 않습니다.

## 아이템에 들어가는 flex-flow속성
