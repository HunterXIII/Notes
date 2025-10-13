# Указатели и ссылки
## Указатели
> Переменная, хранящая адрес другой переменной, требует разыменования (`*p`), можно присвоить `null`

### const
> Значение не должно изменяться
#### Тонкости
- `const int* p` - указатель `p` изменить можно, но `*p` - нельзя
- `int* const p` - указатель `p` изменить нельзя, `*p` - можно
- `const int* const p` - нельзя ничего изменить
## Ссылки
> Псевдоним для уже существующей переменной
- `тип& имя_ссылки = имя_перменной`
- Нельзя перенаправить на другую переменную
# STL
## Введение
**Standart Template Library (STL)** - стандартная библиотека шаблонов  
> STL представляет готовые решения для хранения, обработки данных и связи между ними
  
**Три основных компонента:**
- **Контейнеры** - Объекты, предназначенные для хранения других объектов (массивы, списки, множества и т.д.). 
- **Алгоритмы** - Функции для обработки элементов контейнеров (сортировка, поиск, преобразование и т.д.). 
- **Итераторы** - Объекты, которые позволяют последовательно обращаться к элементам контейнера. Мост между контейнерами и алгоритмами

## Последовательные контейнеры
> Элементы хранятся в определённом порядке (в соответствии порядки вставки)

### Vector (Динамический массив)
- Элементы хранятся в непрерывном блоке памяти
- Быстрый произвольный доступ по индексу (`vec[i]`, `vec.at(i)`)
- Быстрое добавление/удаление в конец (`vec.push_back()`, `vec.pop_back()`)
- Дорогая вставка в середину из-за перераспределения памяти (`vec.insert(pos, value)`)
- Автоматически управляет размером памяти  
  
**Пример кода:**
```cpp
#include <vector>
#include <iostream>

int main() {
    std::vector<int> vec = {1, 2, 3};
    for (int i = 0; i < vec.size(); i++) {
        std::cout << vec[i] << " ";
    }
    
    std::vector<int> vec2;
    vec2.push_back(4);
    vec2.push_back(5);
    for (auto& elem : vec2) {
        std::cout << elem << " ";
    }
}
```

#### Методы
- **`size()`** — возвращает текущее количество элементов в векторе.
- **`empty()`** — возвращает `true`, если вектор пуст (нет элементов).
- **`capacity()`** — показывает, сколько элементов может хранить вектор без перераспределения памяти.
- **`reserve(n)`** — заранее выделяет память под `n` элементов, не изменяя `size()`.
- **`resize(n)`** — изменяет размер вектора до `n` элементов.  
- **`clear()`** — удаляет все элементы, но не освобождает зарезервированную память (`capacity()` не меняется).
- **`begin()`** — возвращает итератор на первый элемент.
- **`end()`** — возвращает итератор на элемент **за последним**.

### Array (Статический массив)
- ==Размер фиксирован и известен на этапе компиляции==
- Быстрый произвольный доступ
- Нет расходов на управление памятью, по сравнению с `vector`
- Может быть передан по значению  
```cpp
#include <array>
#include <iostream>

int main() {
    std::array<int, 5> arr = {1, 2, 3, 4, 5};
}
```
### Deque (Двусторонняя очередь)
- Позволяет эффективно добавлять/удалять в начало и конец
- Произвольный доступ медленнее, чем у `vector`
#### Методы:
- `push_front/pop_front` - добавление/удаление в начале
- `push_back/pop_back` - добавление/удаление к конце

### List (двусвязный список)
- ==Элементы представлены в виде узлов, связанных между собой указателями ==
- В каждом узле: данные, указатель на следующий элемент и на предыдущий
- Нет произвольного доступа
- Быстрая вставка и удаление на месте итератора
- Не использует непрерывную память
```cpp
#include <list>
#include <iostream>

int main() {
    std::list<int> ls = {1, 2, 3, 4, 5};
}
```
## Ассоциативные контейнеры
> Элементы хранятся не по позициям, а по ключу

### Set (множество)
- ==Хранит уникальные значения==
- Быстрый поиск (`find`), вставка(`insert`), удаление (`erase`)
```cpp
#include <set>
#include <iostream>

int main() {
    std::set<int> s = {3, 1, 4, 1, 5}; // Будет хранить {1, 3, 4, 5}
    s.insert(2);
    s.insert(3); // Дубликат, не будет добавлен
    if (s.find(3) != s.end()) std::cout << "3 found\n";
    for(const auto& elem : s) std::cout << elem << " "; // Выводится в отсортированном порядке
    std::cout << "\n";
}
```
- `std::set` - уникальные отсортированные элементы
- `std::unordered_set` - не отсортированные
### Map (словарь)
- ==Хранит пары ключ-значение== 
- Быстрый поиск, вставка, удаление по ключу
- Ключи уникальны и отсортированы
- Доступ к значению по ключу `map[key]` 
```cpp
#include <map> 
#include <string> 
#include <iostream>

int main() {
    std::map<std::string, int> grades; 
    grades["Alice"] = 95; 
    grades["Bob"] = 87; 
    grades.insert({"Charlie", 92}); // Другой способ вставки 
    grades["Alice"] = 98; // Обновление значения // 
    grades["David"]; // Если ключа нет, он создаётся со значением по умолчанию (0 для int) 
    if (grades.find("Eve") == grades.end()) std::cout << "Eve not found\n";
    for(const auto& pair : grades) { 
        std::cout << pair.first << ": " << pair.second << "\n"; // pair.first - ключ, pair.second - значение 
    }
}
```
- `std::map` - отсортированные ключи
- `std::unordered_map` - не отсортированные

## Что выбрать?
1. Нужен произвольный доступ по индексу? 
> `vector, array`. 
2. Часто вставляем/удаляем в начало или конец? 
> `vector (в конец), deque (в начало/конец), list (в любое место, если есть итератор)`. 
3. Нужны уникальные элементы?
> `set, unordered_set` 
4. Нужна связь "ключ-значение"? 
> `map, unordered_map` 
5. Нужны дубликаты ключей? 
> `multiset, multimap` 
6. Важна скорость поиска? 
> `O(1) -> unordered_set/map; O(log N) -> set/map` 
7. Важен отсортированный порядок? 
> `set, map`

## Итераторы
> Объект, который представляет доступ к элементам контейнера и позволяет перемещаться по ним

### Основные операции итераторов: 
- it++, it--: перемещение к следующему/предыдущему элементу. 
- \*it: разыменование - доступ к элементу, на который указывает итератор. 
- it1 == it2, it1 != it2: сравнение итераторов. 
- 
### Методы контейнеров, возвращающие итераторы:
- begin(): итератор на первый элемент. 
- end(): итератор после последнего элемента (важно!). 
- cbegin(), cend(): константные версии. 
- rbegin(), rend(): реверсивные итераторы (с конца к началу).  
  
Пример (vector):
```cpp
#include <vector> 
#include <iostream> 

std::vector<int> v = {10, 20, 30}; 
auto it = v.begin(); // it указывает на 10
std::cout << *it << "\n"; // Вывод: 10 
++it; // it указывает на 20 
std::cout << *it << "\n"; // Вывод: 20
```

## Алгоритмы
> Для использования `#include <algorithm>`, работают с итераторами

### Примеры алгоритмов
#### `std::find(v.begin(), v.end(), value)`
> Ищет элемент, возвращает итератор, указывающий на найденный элемент (индекс)

```cpp
#include <vector> 
#include <algorithm> 
#include <iostream> 

std::vector<int> v = {1, 2, 3, 4, 5}; 
auto it = std::find(v.begin(), v.end(), 3); // Ищем 3 
if (it != v.end()) { 
    std::cout << "Found 3 at index: " << std::distance(v.begin(), it) << "\n"; // distance - вспомогательная функция 
} else { 
    std::cout << "3 not found\n"; 
}
```

#### `std::sort(v.begin(), v.end())`
> Сортирует элементы

#### std::count(v.begin(), v.end(), value)
> Подсчитывает количество элементов, равных заданному

#### std::transform(in.begin(). in.end(), out.begin(), фукция)
> Преобразует элементы одного диапазона, сохраняя в другом (или том же)

```cpp
#include <vector>
#include <algorithm>
#include <iostream>
std::vector<int> input = {1, 2, 3, 4};
std::vector<int> output(input.size()); // Вектор для результата
std::transform(input.begin(), input.end(), output.begin(), [](int x) { return x * x; }); // Возведение в квадрат
for (const auto& e : output) std::cout << e << " "; // Вывод: 1 4 9 16
std::cout << "\n";
```
#### std::for_each(v.begin(), v.end(), функция)
> Применяет заданную функцию к каждому элементу диапазона

### Функторы
> **Проблема:** Алгоритмы часто требуют условия или операции. Например, sort может нуждаться в пользовательском порядке сортировки, find_if нуждается в пользовательском условии поиска.
  
> **Решение:** Функторы. Это объекты класса, который перегружает оператор operator(), делая его "вызываемым" как функцию.

**Пример:**
```cpp
#include <vector>
#include <algorithm>
#include <iostream>

struct IsEven { // Функтор
    bool operator()(int n) const { // Определяем оператор вызова
        return n % 2 == 0;
    }
};

int main() {
    std::vector<int> v = {1, 2, 3, 4, 5, 6};
    // find_if ищет первый элемент, для которого функтор возвращает true
    auto it = std::find_if(v.begin(), v.end(), IsEven()); // Передаём объект функтора
    if (it != v.end()) {
        std::cout << "First even number: " << *it << "\n"; // Вывод: 2
    }
    return 0;
}
```

**Преимущества функторов:** Могут хранить состояние (например, пороговое значение), более гибкие, чем простые функции.

### Лямбда-выражения
> Способ создания анонимной функции в месте её использования
  
Синтаксис: `[capture_list](parameters) -> return_type { function_body }`  
- capture_list: Как лямбда получает доступ к переменным из окружающей области видимости  
    - `[=]` - захват по значению, 
    - `[&]` - захват по ссылке, 
    - `[var]` - захват конкретной переменной var.  
- parameters: Параметры функции (как у обычной функции).  
- `-> return_type`: (опционально) Явное указание типа возврата. Компилятор часто может вывести его сам.  
- function_body: Тело функции.

_Пример sort с лямбдой (убывающий порядок)_:  
```cpp
#include <vector>  
#include <algorithm>  
#include <iostream>  
std::vector<int> v = {5, 2, 8, 1, 9};  
std::sort(v.begin(), v.end(), [](int a, int b) { return a > b; }); // Лямбда определяет порядок  
for (const auto& e : v) std::cout << e << " "; // Вывод: 9 8 5 2 1  
std::cout << "\n";
```

_Пример find_if с лямбдой (поиск числа больше 3)_:  
```cpp
#include <vector>  
#include <algorithm>  
#include <iostream>  
std::vector<int> v = {1, 2, 3, 4, 5};  
auto it = std::find_if(v.begin(), v.end(), [](int n) { return n > 3; });  
if (it != v.end()) {  
    std::cout << "First number > 3: " << *it << "\n"; // Вывод: 4  
}
```
_Пример лямбды с захватом переменной_:  

```cpp
#include <vector>  
#include <algorithm>  
#include <iostream>  
int threshold = 3;  
std::vector<int> v = {1, 2, 3, 4, 5};  
// [&threshold] - захватываем threshold по ссылке  
auto it = std::find_if(v.begin(), v.end(), [&threshold](int n) { return n > threshold; });  
if (it != v.end()) {  
    std::cout << "First number > " << threshold << ": " << *it << "\n"; // Вывод: 4  
}  
std::function (Кратко): Тип, который может хранить любую "вызываемую сущность" (функция, функтор, лямбда). std::function<bool(int)> func = [](int x) { return x > 0; };
```

# Управление ресурсами
## ### **RAII (Resource Acquisition Is Initialization)**

**Что такое RAII?** Это фундаментальный принцип C++. Инициализация ресурса происходит в конструкторе объекта, а освобождение ресурса — в деструкторе.  
  
**Как это работает?**

1. Объект, управляющий ресурсом (например, память, файл, мьютекс), создается.
2. В конструкторе этого объекта происходит захват ресурса (например, `new`, `fopen`).
3. Когда объект выходит из области видимости (в нормальной ситуации или при исключении), его деструктор вызывается автоматически.
4. В деструкторе ресурс освобождается (например, `delete`, `fclose`).  

**Преимущества:**
- **Автоматичность:** Не нужно помнить, где вызвать `free` или `fclose`. Компилятор гарантирует вызов деструктора.
- **Безопасность исключений:** Даже если возникает исключение, деструкторы локальных объектов всё равно вызываются (stack unwinding).
- **Надежность:** Уменьшает количество утечек ресурсов и других ошибок.  
## Умные указатели
Для работы с ними `#include <memory>`
### `std::unique_ptr<T>`
> Исключительное владение объектом, нельзя копировать, можно перемещать владение с помощью `std::move()`

```cpp
// Создание unique_ptr
std::unique_ptr<int> ptr1 = std::make_unique<int>(42); // Предпочтительный способ

std::cout << "Value: " << *ptr1 << std::endl; // Разыменование как обычный указатель

// unique_ptr<int> ptr2 = ptr1; // ОШИБКА! Копирование запрещено
std::unique_ptr<int> ptr2 = std::move(ptr1); // OK! Владение передаётся от ptr1 к ptr2
```
### `std::shared_ptr<T>`
> Совместное владение объектом, имеет метод `use_count()`, возвращающий количество владельцев

```cpp
std::shared_ptr<int> sp1 = std::make_shared<int>(100); // Создаём, счётчик = 1

{
    std::shared_ptr<int> sp2 = sp1; // Копируем, sp2 указывает на то же, счётчик = 2
    std::cout << "Inside block: sp1.use_count() = " << sp1.use_count() << std::endl; // Выведет 2
    std::cout << "Value: " << *sp2 << std::endl; // Выведет 100
} // sp2 выходит из области видимости, счётчик = 1

std::cout << "Outside block: sp1.use_count() = " << sp1.use_count() << std::endl; // Выведет 1
```

### `std::weak_ptr<T>`
> Не влияет на счётчик ссылок `std::shared_ptr<T>`

```cpp
#include <memory>
#include <iostream>

int main() {
    std::shared_ptr<int> sp = std::make_shared<int>(200);
    std::weak_ptr<int> wp = sp; // Не увеличивает счётчик
    if (auto locked_sp = wp.lock()) { // Пытаемся получить shared_ptr
        std::cout << "Value via weak_ptr: " << *locked_sp << std::endl; // Выведет 200
    } else {
        std::cout << "Object is gone\n";
    }
    sp.reset(); // Уменьшаем счётчик до 0, объект удаляется
    if (wp.expired()) { // Проверяем, удалён ли объект
        std::cout << "Object has been deleted\n"; // Выведет это
    }
    return 0;
}
```

## **Move Semantics (`std::move`, `&&`)**
> Move semantics позволяет _перемещать_ ресурсы из одного объекта в другой, вместо копирования. Это делает код эффективнее.

- **`T&&` (Rvalue Reference):** Новый тип ссылки, введённый в C++11. Указывает на _временные_ объекты (rvalue).
- **`std::move`:** Функция, которая "помечает" объект как готовый к перемещению (он больше не нужен в текущем состоянии).

```cpp
#include <iostream>
#include <vector>
#include <utility> // для std::move

std::vector<int> createVector() {
    std::vector<int> temp = {1, 2, 3, 4, 5}; // Создаём вектор
    return temp; // В старом C++ это было бы копирование!
    // В современном C++ вызывается move-конструктор!
    // Содержимое temp "перемещается" в возвращаемый вектор, temp становится пустым.
}

int main() {
    std::vector<int> v = createVector(); // v получает содержимое без копирования
    std::cout << "Size of v: " << v.size() << std::endl; // Выведет 5
    std::vector<int> v1 = {10, 20};
    std::vector<int> v2 = {30, 40};
    // std::move позволяет "отдать" владение содержимым v2 в v1
    v1 = std::move(v2); // v1.operator=(std::vector<int>&&) вызывается (move assignment)
    // Теперь v2 пустой, v1 содержит {30, 40}
    std::cout << "v1 size: " << v1.size() << ", v2 size: " << v2.size() << std::endl; // 2, 0
    return 0;
}
```

## auto 
> Позволяет компилятору вывести тип переменной из её инициализирующего выражение, то есть компилятор сам определит, какой тип необходимо назначить переменной


## nullptr
> Специальное значение, представляющее нулевой указатель, безопаснее `NULL`

# Шаблоны
Способ написания кода, который параметризован типами. Компилятор генерирует конкретный код для каждого используемого типа

## Шаблоны функций
```cpp
template<typename T> 
возвращаемый тип имя_функции(T переменная) {
    // тело функции
}
```
```cpp
template<typename T> // или typename T
T max(T a, T b) {
    return (a > b) ? a : b; // Предполагаем, что для T определён оператор >
}

template<typename T, typename U>
void printPair(T first, U second) {
    std::cout << first << ", " << second << std::endl;
}
```
## Шаблоны классов
```cpp
template<typename T> // или template<class T>
class ClassName {
    // тело класса, использующее T
};
```
```cpp
#include <iostream>
template<typename T> 
class SimpleSmartPointer
}
    // Оператор доступа к члену
    T* operator->() const {
        return ptr;
    }
    // Оператор получения указателя
    T* get() const {
        return ptr;
    }
    
    // Оператор присваивания (упрощённо, не учитываем самоприсваивание и move)
    SimpleSmartPointer& operator=(SimpleSmartPointer other) {
        std::swap(ptr, other.ptr);
        return *this;
    }
    
    // Запрет копирования (для уникальности, как unique_ptr)
    SimpleSmartPointer(const SimpleSmartPointer&) = delete;
    SimpleSmartPointer& operator=(const SimpleSmartPointer&) = delete;
    // Move-конструктор (упрощённо)
    SimpleSmartPointer(SimpleSmartPointer&& other) noexcept : ptr(other.ptr) {
        other.ptr = nullptr;
    }
    // Move-оператор присваивания (упрощённо)
    SimpleSmartPointer& operator=(SimpleSmartPointer&& other) noexcept {
    if (this != &other) {
        delete ptr;
        ptr = other.ptr;
        other.ptr = nullptr;
    }
        return *this;
    }
};
int main() {
{
    SimpleSmartPointer<int> smartInt(new int(42));
    std::cout << "Value: " << *smartInt << std::endl; // Используем operator*
    SimpleSmartPointer<double> smartDouble(new double(3.14159));
    std::cout << "Value: " << *smartDouble << std::endl;
} // Объекты уничтожаются, вызывается деструктор, память освобождается
return 0;

}
```

# Многопоточность
**Процесс** - отдельно запущенная программа, имеет собственное виртуальное адресное пространство  
**Поток** - "легковесный" процесс внутри основного процесса. Потоки разделяют память внутри одного процесса, но у каждого есть свой стек и регистры.
## `std::thread`
```cpp
#include <iostream>
#include <thread>

void hello() {
    std::cout << "Hello from thread" << std::this_thread::get_id() << std::endl;
}

int main() {
    std::thread t1(hello); // Создаём поток, который будет выполнять функцию hello
    std::thread t2(hello); // Создаём второй поток, выполняющий ту же функцию
    std::cout << "Hello from main thread " << std::this_thread::get_id() << std::endl;
    t1.join(); // Ожидаем завершения потока t1
    t2.join(); // Ожидаем завершения потока t2
    // Теперь main может завершиться, зная, что все потоки закончили работу
    return 0;
}
```

## `join()` vs `detach()`
- `join()`: поток, вызывающий `join` (например, `main`), _ждет_, пока поток, на котором вызывается `join`, не завершится.
- `detach()`: поток "отсоединяется". Он продолжает работать независимо, и его ресурсы автоматически освобождаются при завершении. Главный поток не обязан ждать его.
- **Важно:** Любой `std::thread` должен быть либо `join()`-нут, либо `detach()`-нут перед тем, как его деструктор вызовется (иначе программа аварийно завершится).
## **`std::this_thread::sleep_for()`** 
Приостановка выполнения потока на заданное время
```cpp
#include <chrono>

void sleepy_hello() {
    std::cout << "Sleepy thread " << std::this_thread::get_id() << " starts.\n";
    std::this_thread::sleep_for(std::chrono::milliseconds(1000)); // Спит 1 секунду
    std::cout << "Sleepy thread " << std::this_thread::get_id() << " wakes up.\n";
}
```
## `std::mutex()`
Объект синхронизации, используемый для защиты общих данных от одновременного доступа несколькими потоками
```cpp
#include <iostream>
#include <thread>
#include <mutex>

int shared_counter = 0; // Общий ресурс
std::mutex counter_mutex; // Мьютекс для защиты counter
void increment() {
    for (int i = 0; i < 1000; ++i) {
        counter_mutex.lock(); // Блокируем доступ
        ++shared_counter; // Изменяем общий ресурс
        counter_mutex.unlock(); // Разблокируем доступ
        // Лучше использовать lock_guard (RAII для мьютексов):
        // std::lock_guard<std::mutex> lock(counter_mutex);
        // ++shared_counter; // lock_guard автоматически разблокирует в деструкторе
    }
}
int main() {
    std::thread t1(increment);
    std::thread t2(increment);
    t1.join();
    t2.join();
    std::cout << "Final counter value: " << shared_counter << std::endl; // Должно быть 2000
    return 0;
}
```hello world 123 hello test 456 123 hello