## 배열 요소 추가

push: 배열의 끝에 원소를 추가

```
  var li = ['a', 'b', 'c', 'd', 'e'];
  li.push('f');
  alert(li);
```

concat: 복수의 원소를 배열에 추가

    var li = ['a', 'b', 'c', 'd', 'e'];
    li = li.concat(['f', 'g']);
    alert(li);

unshift: 배열의 시작점에 원소를 추가하는 방법이다. 배열 li는 z, a, b, c, d, e가 됐다.  
인자로 전달한 값을 배열의 첫번째 원소로 추가하고 배열의 기존 값들의 색인을 1씩 증가시킨다.

    var li = ['a', 'b', 'c', 'd', 'e'];
    li.unshift('z');
    alert(li);

splice: 특정 인덱스 뒤에 대문자 B를 넣고 싶다면

    var li = ['a', 'b', 'c', 'd', 'e'];
    li.splice(2, 0, 'B');
    alert(li);

## 배열 원소 제거

shift: 첫번째 원소를 제거하는 방법이다.

    var li = ['a', 'b', 'c', 'd', 'e'];
    li.shift();
    alert(li);

pop: 배열 끝점의 원소를 배열 li에서 제거

    var li = ['a', 'b', 'c', 'd', 'e'];
    li.pop();
    alert(li);

## 배열정렬

sort:

    var li = ['c', 'e', 'a', 'b', 'd'];
    li.sort();
    alert(li);

reverse: 역순정렬

    var li = ['c', 'e', 'a', 'b', 'd'];
    li.reverse();
    alert(li);

## 객체

객체(Object) vs 배열  
객체(Object): 값을 특정문자로 불러옴  
배열: 인덱스로 불러옴

    //방식1
    var grades = {'egoing': 10, 'k8805': 6, 'sorialgi': 80};
    //방식2
    var grades = {};
    //방식3
    var grades = new Object();
    grades['egoing'] = 10;
    grades['k8805'] = 6;
    grades['sorialgi'] = 80;

객체의 loop
for in 문 써서 변수 추론해서 loop 가능

    for(key in grades) {
        document.write("key : "+key+" value : "+grades[key]+"<br />");
    }
