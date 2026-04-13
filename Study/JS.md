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

## Цепочка вызовов
Всегда возвращаем `this`
```js

```
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
```js
function multiply(a) {
    return function(b) {
        return a * b;
    }
}


```
## Callback
**Callback** - это функция, которая передаётся в другую функцию в качестве аргумента
```js

```

# Лекция 3. Объектная модель данных
**Объекты:**
- Динамические - можно добавлять/удалять свойства
- Ссылочные - передаются по ссылке (сравнение по ссылке)
- Прототипы - наследование через цепочку прототипов
- Аксессоры - геттеры и сеттеры для вычисления данных
- Дескрипторы - Тонкая настройка поведения свойств
- Метапрограммирование
- Сериализуемость  
  
> Два объекта считаются равными только в том случае, если они ссылаются на одну память

## Поверхностное копирование - Object.assign()
Копирует все свойства из одного объекта (или несколько) в другой
> Копирует только ссылки на вложенные объекты, а не сами объекты. Вложенные структуры остаются общими

## Глубокое копирование через JSON
Самый простой способ - сериализация объекта в JSON структуру с последующим парсингом обратно в новый объект
> JSON.stringify не может сериализовать циклические ссылки (когда объект ссылается сам на себя)

## Современный способ копирования - structuredClone()

...

## Прототип
**Прототип** - это объект, который используется как резервный источник свойств для другого объекта. Если свойство не найдено в самом объекте, JavaScript ищет его в прототипе
```js
const animal = {
    eats: true,
    walk() {
        console.log("walk..")
    }
}

const rabbit = {
    jumps: true
}

// устанавливаем прототип: rabbit наследует от animal
Object.setPrototypeOf(rabbit, animal);
```
Возможна цепочка прототипов
## Object.defineProperties()
```js
const user = {}

Object.defineProperties(user, {
    // Свойство данных
    id: {
        value: 12345,
        writable: false,
        enumerable: true
    },
    
    // Свойство с геттером/сеттером
    fullName: {
        get() {
            return `${this.firstName} ${this.lastName}`;
        },
        set(name) {
            [this.firstName, this.lastName] = name.split(" ");
        }
    },
    
    // Скрытое служебное свойство
    _internal: {
        ...
    }  
});
```

### enumerable - видимость в циклах
`enumerable: false` - не будет показываться в циклах

# Лекция 4
AbortController - встроенный объект в JS, который позволяет отменять асинхронные операции (особенно fetch-запросы) до их завершения
```js
const controller = new AbortController();
const signal = controller.signal;

signal.addEventListener('abort', () => {
    console.log("Signal stopped");
    console.log ("Reason: ", signal.reason) // underfined по умолчанию
}); 

signal.abort()
// OR
signal.abort(new Error("Test"))
```

## JSON
- json.stringfy - из объекта в json
- json.parse - из json в объект
- json.toJSON - свои правила для stringfy

## Promise
**Promise** - объект, представляющий результат асинхронной операции, которая ещё не завершена, но будет завершена в будущем. "Промис" - контейнер для будущего значения
- pending - ожидание
- fulfield - завершилась?
- rejected - произошла ошибка  
  
### then, catch, finally
- `.then` - принимает и возвращает promise, операции над ним
- `.catch` - обработка ошибок

### Статические методы Promise
`Promise.all()` - параллельное выполнение промисов (если хоть одна ошибка из них, то вылетаем в catch), возвращает массив результатов  
  
`Promise.race()` - гонка промисов, какой запрос придёт первый, тот и будет использоваться, если ошибка быстрее, то её и обрабатываем  
  
`Promise.any()` - вернёт первый положительный ответ  
  
## Fetch API
Fetch API - современный интерфейс для выполнения HTTP-запросов, у него есть response:
- response.status - код статусы
- .ok - true, если успешные статусы
- .headers - заголовки
- .url - путь
- .json - в формате json
- .text - как текст
- .blob - как бинарные данные  
  
> Видеть, например, прогресс можно только через старый вариант запросов

## async/await
`async function` - объявление асинхронной функции, которая всегда возвращает промис  
  
`await` - оператор, который приостанавливает выполнение асинхронной функции до разрешения промиса  
  
# Лекция 5. DOM
DOM (Document Object Model) - объектная модель документа
Документ содержит коллекции
## Методы поиска элементов
- `document.getElementById` - элемент с переданными id
- `document.getElementByTagName` - коллекция тегов
- `document.getElementByClassName` - коллекция с таким классом
- `document.getElementByName` - коллекция с таким именем
## Навигация
- parentNode - родительский элемент
- childNodes/children - коллекция дочерних узлов
## querySelector
- поиск элемента его по принадлежности к CSS-стилям
> querySelectorAll - статический

## Живые и статические коллекции
- **Живые** - автоматически обновляются при изменении DOM (`getElementByTagName`, `getElementByClassName`, `children`, ...)
- **Статические** - не меняются, даже если изменился DOM (`querySelectorAll`)

## Создание и вставка узлов
- `document.CreateElement(tagName)` - создаёт новый элемент
- `document.TextNode(text)` - создаёт новый текстовый узел
- `document.CreateDocumentFragment()`
## Вставка в DOM
- `parent.appendChild(child)` - добавляет дочерний элемент в конец
- `parent.insertBefore(newNode, referenceNode)` - вставляет перед опорным(reference) узлом
- `parent.replaceChild(newNode, oldNode)` - заменяет узел
- `parent.removeChild(child)` - удаляет дочерний узел
## addEventListener
Метод, который позволяет назначить функцию (обработчик) на событие элемента
```js
элемент.addEventListener('событие', функция-обработчик)
```
- элемент - DOM-узел (например, `document`, `button`, `div`)
- событие - строка, например, `click`,`mouseover`, `keydown`
```html
<button id="myBtn">Click!</button>
```
```js
const btn = document.getElementById('myBtn');

btn.addEventListener('click', function() {
    alert('Кнопка нажата');
})
```

### Объект события event
```js
btn.addEventListener('click', (event) => {
    console.log(event.type); // 'click'
    console.log(event.target); // элемент, на который кликнули
    console.log(event.currentTarget); // элемент, на котором висит обработчик
});
```

## textContent / innerHTML
Свойство textContent - способ получить или установить текстовое содержимое элемента, игнорируя все html-теги
innerHTML с учётом тегов
## getAttribute, setAttribute
- **Атрибуты** - исходные значения, заданные в HTML коде, к ним обращаются через `getAttribute`, `setAttribute`..., всегда строка
- **Свойство** - поля DOM-объекта, могут быть любого типа, доступ через точечную нотацию: `element.id`

# Лекция какая-то
JS имеет прототипное наследование, объекты в JS могут наследовать свойства и методы других объектов, это даёт невероятную гибкость  
  
## Функции конструкторы
```js
function User(name) {
    this.name = name;
}
User.prototype.sayHi = function() {
    console.log(`Hi, I'm ${this.name}`);
}
```

## Конструктор класс
```js
class Animal {
    constructor(name) { this.name = name; }
}

class Dog extends Animal {
    constructor(name, breed) {
        super(name);
        this.breed = breed;
    }
}
```

## Вычисляемые имена методов
```js
const methodName = "sayHello";
const prefix = "get";
class Greeter {
    [methodName]() {
        console.log("Hello!");
    }
    [prefix + "Name"]() {
        ...
    }
}
```

## Защищённые свойства
Просто через `_` (например, `_balance`), только через геттер и сеттер
