
//다음과 같이 constructor 만들었을때 new 써서 객체화가능
//이때 속성에 function 함수도 포함되면 모든 객체생성시마다
//똑같은 기능을하는 함수까지 메모리에 올라가는 문제발생
function Person1(name, first, second, third) {
    this.name = name;
    this.first = first;
    this.second = second;
    sum = function () {
        return this.first + this.second + this.third;
    }
}

//아래와 같이 똑같은 기능을 하는 함수는 분리시켜주고 
//원형(prototype)으로 변수선언해주면 모든 오브젝트가 공유
//->즉 메모리 할당도 한번 됨 
function Person2(name, first, second, third) {
    this.name = name;
    this.first = first;
    this.second = second;
}

Person2.prototype.sum = function () {
    return 'prototype : ' + (this.first + this.second);
}

var kim = new Person2('kim', 10, 20);
//prototype있어도 오브젝트 인스턴스별로 재할당 사용 가능 
kim.sum = function () {
    return 'this : ' + (this.first + this.second);
}
var lee = new Person2('lee', 10, 10);

//this.sum()이 우선되므로 kim은 재할당된 함수 실행됨 
//lee는 sum()재선언 하지 않았으므로 오브젝트 인스턴스
//자체에는 sum()없음. -> prototype의 sum 참조
console.log("kim.sum()", kim.sum());
console.log("lee.sum()", lee.sum());