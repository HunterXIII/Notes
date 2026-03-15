# Лекция 1 
_19.11.25_
## Введение

# Практика 1
_20.11.25_  
## Переменные
```go
var a int = 42
var b = 42 // будет int
c := 42 // короткое объявление, будет int
```

Объявления через `var` - создаёт **глобальную** переменную, через `:=` - **локальную** в рамках функции

```go
var numFloat float32 = 3.14
var numComlex complex64 = 1 + 2i

var str1 string = "Hello" 
fmt.Printf("str1: %T = %s\n", str1, str1)

var rune1 rune = 1071 // Юникод символ 'Я'
```
# Лекция 2
_20.11.25_
## Основная информация
**Go** - компилируемый язык

## Инициализация модуля
`go mod init example.com/mymodule` - 

## Форматирование 
`go fmt` - форматирование к стандарту

## Функции
```go
func div(a, b) (int, error) {
    if b == 0 {
        return 0, fmt.Error("divide by zero")
    }
    
    return a / b, nil
}
```
Обработка ошибка в коде:
```go
q, err = div(4, 2)
if err != nil {
    os.Exit(1)
}
```

# Лекция 3
## Строки
Строка - неизменяемая последовательность байтов
- ***Индекс и len*** - в байтах, а не по символам
- ***rune*** - символ Юникод
- range по строке выдаёт индекс в байтах

### Пакет strings
- Contains/HasPrefix/HasSufix/Index/LastIndex
- Split/Join/Repeat/Replace
- ToLower/ToUpper
### Пакет strconv
- Atoi/ParseInt/ParseFloat

## Итерация по рунам
```go
s := "Привет, Go"
for i, r := range s {
    fmt.Printf("byte=%d rune=%q code=%U\n", i, r, r)
}
```

```go
s := "набор"
fmt.Println("bytes:", len(s))
fmt.Println("runes:", len([]rune(s)))
```
## Срезы
Срез - окно на массив; содержит len, cap
- len - видимая длина, cap - ёмкость
- append - может переместить данные (реаллоцировать(выделить память типа))
  
### Создание массивов
- Литерал: `[]int{1,2,3}`
- `make([]T, len)` / `make([]T, len, cap)`
- `copy(drs, scr)` - копирование

### Итерация 
- range по индексам и значением


## map
- `map[K]V` - хэш-таблица; чтение O(1)
- Чтение/запись: `v := m[k]; m[k] = v`
- Проверка наличия: `v, ok := m[k]`  
  
## map как множество (set)
- `map[T]struct{}` - экономический set

## Срез и append/cap
```go
s := []int{1,2,3}
fmt.Println(len(s), cap(s)) // 3,3
s = append(s, 4)
fmt.Println(len(s), cap(s)) // 3,4
```

## Пример map
```go
freq := map[string]int{}
for _, w := range words {
    freq[w]++
}
```

## Советы
- не полагайтесь на порядок range по map
- заранее выделять cap

## Структуры - агрегирование данных
- Структура - набор полей с именами и типами
- Нулевые значения полей полезны для простых конструкторов
- Экспорт полей - с заглавной буквы

![[Pasted image 20251127170601.png]]
![[Pasted image 20251127170636.png]]
- `*` - ссылка на объект, можем изменять объект  
- `&` - распаковка
![[Pasted image 20251127170751.png]]
### Встраивание
```go
type Logger {
    /* ... */
}

type Service struct {
    Logger // встраивание
    Repo Repository
}
```
## Интерфейсы
- Структурная типизация
- Интерфейс принадлежит потребителю
- Малые интерфейсы лучше больших 
## Дженерики
- Уменьшить дублирование кода при одинаковой логике 
- Сохранить статическую типизацию без пустого interface
- Повысить выразительность утилитных структур/функций
```go
func Map[T any](in []T, f func(T) T) []T
```
- Тип-параметры в `[]` после имени функции/типа
### Обобщённый `Set[T]`
`type Set[T comparable] map[T]struct{}`

# Лекция 4
## Тестирование 
### Простой тест
```go
package mathx
import "testing"

func Sum(a, b int) int {return a + b}

func TestSum(t *testing.T) {
    got := Sum(2,3)
    want := 5
    if got  != want {
        t.Fatalf("Sum(2,3)=%d want %d", got, want)
    }
}
```
### Табличные тесты
```go
func Inc(x int) int {return x+1}

func TestInc(t *testing.T) {
    cases := []struct {
        name string
        in, want int
    }{
        {"zero", 0, 1},
        {"neg", -3, -2},
        {"big", 41, 42},
    }
    
    for _, tc := range cases {
        t.Run(tc.name, func(t *testing.T) {
            if got := Inc(tc.in); got != want {
                t.Fatalf("Inc(%d)=%d want %d", tc.in, got, want)
            }   
        })
    }
}
```
## Бенчмарки
- Оценить влияние изменений на производительность
- Сравнивать варианты реализации
- Найти лишние аллокации и узкие места  

# Семестр 2
# Лекция 1


# Практика 1

# Практика 2
`any` - любое значение
- Для декодирования с `json` используется `json.NewDecoder(r io.Reader) *Decoder` а затем используем метод `Decode`:
- Для ответа, то есть для кодирования в json - `json.NewEncoder(w io.Writer) *Encoder` и метод `Encode`
```go
mux.HandleFunc("POST /echo", func(w http.ResponseWriter, r *http.Request) {
		var payload map[string]any
		dec := json.NewDecoder(r.Body)
		err := dec.Decode(&payload)
		if err != nil {
			w.Header().Set("Content-Type", "application/json")
			err = json.NewEncoder(w).Encode(map[string]string{
				"error": err.Error(),
			})
			if err != nil {
				w.WriteHeader(http.StatusInternalServerError)
				fmt.Printf("failed to send JSON response ti client: %s\n", err)
			}

		}
	})
```

также можно не через `map`, а через `struct` (**важно сделать именованные поля и экспортируемые**)
```go
err = json.NewEncoder(w).Encode(struct {
    Err string
}{
    Err: err.Error(),
})
```

Проверить тип ошибки:
```go

```

# Лекция 3. Database
```go
func main {
    db, err := sql.Open("бд", "полльзователь:пароль@сеть(адрес:порт)/название_бд)
    if err != nil {
        fmt.Printf("Failed to connect: %s\n", err)
        return
    }
    defer db.Close() // Откладываем закрытие БД, когда завершится функция main
    
    if err = db.Ping(); err != nil {
        fmt.Printf("Failed to ping: %s\n", err)
        return
    }
    
    fmt.Printf("Succesfuly connected to database")
    
    ...
    mux.Handle("GET /users/{id}", getUserHandler(db))
    ...
}
```
## Первый способ передачи db в handler func
```go
func getUserHandler(db *sql.DB) http.Handler {
    return http.HandlerFunc(w http.ResponseWriter, *r http.Request) {
        fmt.Printf("db is %v", db)
    }
}
```
## Получение одной строки из БД
```go
db.QueryRow("SELECT id, name, email FROM users WHERE id = ?", id).Scan(&user.Id, &user.Name, &user.Email)
```
- `QueryRow` - запрос к БД, чтобы получить одну строку
- `Scan` - позиционно записываем полученные столбцы  
## Получение нескольких записей из БД
```go
rows, err := db.Query("SELECT id, name, email FROM users")
if err != nil {
    ...
}
defer rows.Close() // обязательно

```
- `Query` - запрос для получение нескольких записей
- `rows.Close()` - обязательно, потому что читает постепенно, как поток
```go
var users []User

for rows.next() {
    var user User
    if err := rows.(&user.Id, &user.Name, &user.Email) {
        ...
    }
    users = append(users, user)
}
```
## Запись и обновление данных
Для это существует `Exec`, один из возвращаемых аргументов - это `Result`.  
У `Result` есть два метода: `LastInsertId()` - возвращает id последней записи, `RowsAffected()` - количество вставленных или изменённых строк, но не все драйвера это могут возвращать и т.д.
## NULL
Через указатель можно и `json:"name,omitempty"`
## Prepare
Безопасная и эффективная подготовка запроса
```go
stmt, err := db.Prepare("SELECT id, name, email FROM users where id = ?")
defer stmt.Close()
...
stmt.QueryRow(id).Scan(...)
```
## Транзакции 
```go
tx, err := db.BeginTx()
tx.ExecContext()
tx.ExecContext()
tx.Commit() 
tx.Rollback()
```

# Лекция 4. Авторизация
## Claims
- `sub` - id пользователя
- `iat` - момент, в который был выдан токен
- `exp` - время жизни токена
```go
claims := jwt.MapClaims{
    "sub": strconv.FormatInt(user.Id, 10),
    "exp": expiresAt.Unix()
}

token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
tokenString, err := token.SignedString(h.jwtSecret)


```

# Лекция 5. 
- Параллельность - просто делаем параллельную работу
- Конкурентность - ресурсы отдаются тому кому необходимы, и забираются, у кого простаиваются  
  
- **mutex (muteally exclusive)** - блокировка памяти пока занята другим процессом 

## Конкурентность в Go
`go l.Sort()` - `go` означает, что выполнение этой функции будет выполняться отдельно от основного потока, в отдельном воркере 
### Каналы
Отдельный тип данных, определяются двумя словами: `chan <type>`, где `type` - тип данных, которые будут передаваться по каналу. В канал может быть записано одно значение, следующее будет записано, только после того, когда первое прочитают. Буферизованный канал увеличивает количество значений, которые могут лежать в канале.
```go
ci := make(chan int)
cj := make(chan int, 100) // Буфер
```

```go
func (l list) Sort() {

}

func DoSomething() {

}

func main() {
    c := make(chan int) // создание канала
    
    go func() {
        l.Sort()
        c <- 1 // Отправить сигнал в канал, value не имеет значение 
    }
    
    DoSomething()

    <- c // Ожидание конца сортировки, 
}

```

`close(c)` - закрывает канал, тогда циклы по каналам перестанут быть бесконечными
### Пример семафора
```go
const MaxRunningProcessing = 3

type Request struct {}

var sem = make(chan int, MaxRunningProcessing)

func Serve(queue chan *Request) {
    for r := range queue {
        sem <- 1
        go func() {
            process(r)
            <- sem
        }()
    } 
}

func process(r *Request) {}

func main() {
    queue := make(chan *Request)
    
    Serve(queue)
    
    queue <- &Request{}
    queue <- &Request{}
    queue <- &Request{}
    queue <- &Request{}
    queue <- &Request{}
    queue <- &Request{}
}
```

### Worker Pool
```go
const MaxOutstanding = 3

func handle(queue chan *Request) {
    for r := range queue {
        process(r)
    }
}

func Serve(clientRequests chan *Request, quit chan bool) {
    for i := 0; i < MaxOutstanding; i++ {
        go handle(clientRequests)
    }
    <- quit
}

func process(r *Request) {}

func main() {
    queue := make(chan *Request)
    stop := make(chan bool)
    
    go Serve(queue, stop)
    
    queue <- &Request{}
    queue <- &Request{}
    queue <- &Request{}
    queue <- &Request{}
    queue <- &Request{}
    queue <- &Request{}
}
```
> Из канала может читать только один в момент времени

## Параллельность
Можно организовать, но +-

## Race Condition
```go
func main() {
    sum := 0
    
    for i := 0; i < 1000; i ++ {
        go func() {
            sum += i // Сразу несколько потоков записывают туда 
        }()
    }
    
    fmt.Println(sum) // каждый раз разное значение будет
}
```
### mutex
```go
import "sync"

func main() {
    
    m := sync.Mutex{}
    sum := 0
    
    for i := 0; i < 1000; i ++ {
        go func() {
            m.Lock()
            sum += i 
            m.Unlock()
        }()
    }
    
    fmt.Println(sum) 
}
```

