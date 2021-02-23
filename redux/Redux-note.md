1.  store 작성 파라메터로 reducer먹임  
    ->이때 store는 전역변수로 선언해서 어디서든 사용가능하도록 함  
    ->reducer 작성  
    기존의 state값, action 을 파라메터로 받아 store의 state를 수정하는 역할
    ->이때 state는 immutable, 기존 state 복재한 객체를 수정해서 return하면 store의 state에 반영된다

```
  function reducer (state, action) {

            //state가 선언되있지 않으니까 초기화 단계
            if(state === undefined){
                return {color:'yellow'}
            }

          if(action.type === 'CHANGE_COLOR'){
          //immutable 때문에 새state는 원본 복사해서 수정뒤 건내는방식사용
          newState = Object.assign({}, state, {color: 'red'});
          }
        }

  var store = Redux.createStore(reducer);

```

2.store의 값은 getState()로 취득

```
  var state = store.getState();
```

3.취득한 state 다음과 같이 활용  
${ }사용

```
 <div class="container" id="component_red" style="background-color:${state.color}">
```

4.client의 액션으로 인해 state 변경할시  
dispatch호출  
-> 이때 파라메터= 액션이 되는 객체 하나 생성, 이때 type 반드시 있어야 함  
 {type:'CHANGE_COLOR', color:'red'}  
dispatch가 호출되면 reducer 호출되도록 약속되있고 reducer는 state 변경  
->이렇게 보내면 이전의 내부에서 자동으로 state값과 액션을 파라메터로 보낸다.

```
<input type="button" value="fire" onclick="
                   store.dispatch({type:'CHANGE_COLOR', color:'red'});
                ">
```

5.Subscribe  
state 바뀌었으면 새로 getState뒤 <b>Render</b>호출해서 화면 새로그려야지  
->subscribe에 dispatch 액션 실행하는 함수 등록해 놓으면 state 바뀔때마다 자동으로 render호출

    store.subscribe(red);

## Redux DEV Tools 사용

브라우저 플러그인 설치 및 코드 셋팅방법 git url
https://github.com/zalmoxisus/redux-devtools-extension

                  //createStore 선언시 reducer와 함께 아래의 옵션 추가
                    var store = Redux.createStore(
                    reducer,
                    window.__REDUX_DEVTOOLS_EXTENSION__ &&
                    window.__REDUX_DEVTOOLS_EXTENSION__()
                );

리덕스의 장점은 store 를 통한 상태관리, 어플리케이션의 복잡성관리(state로 인한 코드간 의존성(커플링, 결합도)낮축수있다)

리덕스 devTools이용하면 리덕스의 상태변화를 시간별로 redo undo 하며 확인 가능.  
-> state의 imuttable 한 특성으로 가능  
-> 각각의 타이밍별 state는 독립되있으므로(복제해서 새로 전달하니까) redo undo 또한 가능
