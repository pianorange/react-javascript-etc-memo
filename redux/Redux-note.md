1.  store 작성 파라메터로 reducer먹임  
    ->이때 store는 전역변수로 선언해서 어디서든 사용가능하도록 함  
    ->reducer 작성  
    기존의 state값, action 을 파라메터로 받아 store의 state를 수정하는 역할

```
  function reducer (state, action) {

            //state가 선언되있지 않으니까 초기화 단계
            if(state === undefined){
                return {color:'yellow'}
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
dispatch가 호출되면 reducer 호출되도록 약속되있고 reducer는 state 변경  
이때 파라메터는 액션이 되는 객체 하나 생성해서 보내는데 이때 type 반드시 있어야 함  
->이렇게 보내면 이전의 내부에서 자동으로 state값과 액션을 파라메터로 보낸다.

```
<input type="button" value="fire" onclick="
                   store.dispatch({type:'CHANGE_COLOR', color:'red'});
                ">
```
