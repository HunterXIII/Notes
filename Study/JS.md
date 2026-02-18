# Лекция 1
- Глобальное окружение
- Функциональное 
- Блочное (в `{}` только для `let` и `const`, `var` выйдет за пределы)  
  
**Всплытие** - механизм, при котором объявления переменных и функций перемещаются в начало своей области видимости на этапе компиляции, до выполнения кода  

> function declaration (`function f() {}`) всплывает вместе с телом, то есть можно вызвать до объявления, но с function expression (`let a = () => {}`) так не работает

## Типы данных
- **Примитивы** - простые значения (числа, строки, булевы..) - в стеке
    ```js
    let i = 10
    ```
- **Объекты** - сложные структуры (массивы, функции, объекты) - адрес в куче 
    ```js
    let user = {
        name = "User1"
    }
    ```
  
**Стек** - область памяти с фикс размером  
**Куча** - область памяти динамического размера   
  
## Передача по значению
```js
let a = 100;
let b = a; // КОПИЯ

let b = 200;

console.log(a); // 100
console.log(b); // 200
```

```js
const user = {
    name: "Ivan",
    age: 25
}; // user (ссылка) в стеке, массив в куче

const nums = [1, 2, 3]; // тоже в куче

const profile = {
    id: 1,
    settings: {
        theme: "dark",
        notif: true
    }
}; // оба в куче
```


callback - макроочередь  
promise - микроочередь  
  
# Практика 1
```js
var 
// --
let
const
```
- `var` - глобальное, во всей области видимости
- `let` - TDZ (компилятор следит, где объявлена переменная, не даёт к ней обратиться до объявления)
- `const` - константа, неизменяемая
```js
// ПРИМЕЧАНИЕ

const obj = {name: "Ivan"}
obj.age = 30; // БУДЕТ РАБОТАТЬ
// НО
obj = {} // УЖЕ НЕЛЬЗЯ

const obj1 = {
    name: "Test",
    obj2: {
        name: "Test2"
    }
};

obj1.obj2 = {} // МОЖНО
```


# Практика 2
# Лекция 3. Что такое this? 
...
Метод объекта ()
```js
const user = {
    name: "Ivan",
    sayHi() {
        console.log("Привет, я " + this.name);
    }
} 
```
Потеря контекста
```js
const user = {
    name: "Ivan",
    sayHi() {
        setTimeout(function() {
            console.log("Привет, я " + this.name); //underfined
        }, 1000)
    }
};
user.sayHi() // тут потеря this 
```
> В setTimeout уже не будет видно объект, эта анонимная функция уйдёт в глобальную область 

Решение:
```js
const user = {
    name: "Ivan",
    sayHi() {
        setTimeout(() => {
            console.log("Привет, я " + this.name); //user
        }, 1000)
    }
};
user.sayHi() // тут уже всё хорошо
```

- bind - жёсткая привязка 

> Нельзя методы объявлять через стрелочные функции(они становятся глобальными, this в них не указывает на объект)

<mark style="background: #FF5582A6;">... (дописать)</mark>

Стрелки не могут быть конструкторами

## Замыкание

```js
function outer() {
    let message = "Привет из замыкания";
    
    function inner() {
        console.log(message); // функция запомнила окружение
    }
    
    return inner;
}

const myFunction = outer();
myFunction();
```

```js
function createCounter() {
    let count = 0;
    
    return function() {
        count++;
        console.log("Current: ", count);
        return count;
    }
}

const counter1 = createCounter();
const counter2 = createCounter();
counter1(); // 1
counter1(); // 2
counter1(); // 3

counter2(); // 1
counter2(); // 2
```

### Частичное применение (каррирование)
Раскладываем, упрощаем функцию

## Callback
**Callback** - это функция, которая передаётся в другую функцию в качестве аргумента
```js

```