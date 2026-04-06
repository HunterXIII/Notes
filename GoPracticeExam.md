### Decode JSON + запрет неизвестных полей

Прочитайте JSON `{"id":1,"name":"buy milk"}` в структуру в handler и запретите неизвестные поля.

```go
type Task struct {

	ID   int    `json:"id"`
	Name string `json:"name"`

}

func myHandler(w http.ResponseWriter, r *http.Request) {

	var task Task
	dec := json.NewDecoder(r.Body)
	dec.DisallowUnknownFields()
	err := dec.Decode(&task)

	if err != nil {
		http.Error(w, "bad json: "+err.Error(), http.StatusBadRequest)
		return
	}
}
```

### Encode JSON response
Верните JSON `{"ok":true}` со статусом 200 и `Content-Type: application/json`.

```go
func okHandler(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json")
    w.WriteHeader(http.StatusOK)
    json.NewEncoder(w).Encode(map[string]bool{"ok": true})
}
```

### Path param (Go 1.22+): прочитать {id}

В handler для `GET /notes/{id}` получите id, распарсьте в int64, при ошибке верните 400.

```go
func getNote(w http.ResponseWriter, r *http.Request) {
    idstr := r.PathValue("id")
	id, err := strconv.ParseInt(idStr, 10, 64)
	if err != nil {
    	http.Error(w, "Неверный id", 400)
    	return
	}
}
```

### Query params: limit/offset с дефолтами
Достаньте limit и offset из query, дефолты: limit=20, offset=0. limit ограничьте 1..100.

```go
func list(w http.ResponseWriter, r *http.Request) {
    q := r.URL.Query()
    limit, _ := strconv.Atoi(q.Get("limit"))
    offset, _ := strconv.Atoi(q.Get("offset"))
    
    if limit == 0 {
        limit = 20
    }
    if limit < 1 {
        limit = 1
    }
    if limit > 100 {
        limit = 100
    }
    
    if offset < 0 {
        offset = 0
    }
}
```

### Единый формат ошибки (JSON envelope)
Реализуйте `writeError(w, status, code, msg, requestID)` который пишет:

```json
    {"error":{"code":"...","message":"..."},"request_id":"..."}
```

```go
func writeError(w http.ResponseWriter, status int, code, msg, requestID string) {
    w.Header().Set("Content-Type", "application/json") 
    w.WriteHeader(status)
    
    resp := map[string]any{ 
            "error": map[string]string{ 
                    "code": code, 
                    "message": msg, 
                }, 
            "request_id": requestID, 
    } 
    json.NewEncoder(w).Encode(resp)
}

```

### Middleware: request id (HTTP)
Напишите middleware: берёт X-Request-Id из запроса или генерирует новый (16 байт random hex), кладёт в context, и выставляет в response header.

```go
type ctxKeyReqID struct{}

func RequestID(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        rid := r.Header.Get("X-Request-Id")
        if rid == "" {
            b := make([]byte, 16)
            _, _ = rand.Read(b)
            rid = hex.EncodeToString(b)
        }
		ctx := ctx.WithValue(r.Context(), ctxKeyReqID{}, rid)
		w.Header.Set("X-Request-Id", rid)
		next.ServeHTTP(w, r.WithContext(ctx))
    }
}
```

### Middleware: recover panic -> 500
Напишите middleware, который ловит panic и возвращает 500.

```go
func Recover(next http.Handler) http.Handler {
    return http.HandleFunc(func (w http.ResponseWriter, r *http.Request) {
    	defer func() {
            if rec := recover(); rec != nil {
                w.WriteHeader(http.StatusInternalServerError)
            }
        }()
    	next.ServeHTTP(w, r)
	})
}
```

### ResponseWriter wrapper: логировать status code
Реализуйте statusWriter, который запоминает status code.

```go
type statusWriter struct {
    http.ResponseWriter
    status int
}

func (sw *statusWriter) WriteHeader(code int) {
    sw.status = code
    sw.ResponseWriter.WriteHeader(code)
}
```

### Валидация: required + max len
Напишите Validate(). Правила: email required, name max 50 (trim spaces). Возвращайте map[string]string.

```go
type CreateUserRequest struct {
    Email string json:"email"
    Name  string json:"name"
}

func (r CreateUserRequest) Validate() map[string]string {
	errs := make(map[string]string)
	if r.Email == "" {
    	errs["email"] = "required"
	} 
	
	if len(strings.TrimSpace(r.Name)) > 50 {
    	errs["name"] = "max 50"
	}

    return errs
}
```

### Enum validation
Проверьте, что role ∈ {"user","admin"}.

```go
func validateRole(role string) error {
    switch role {
    case "user", "admin":
        return nil
    default:
        return errors.New("Неверная роль")
    }
}
```

### ETag: сформировать из версии
Напишите функцию `etagFromVersion(v int64) string`, которая возвращает строку в формате "v<число>".
```go
func etagFromVersion(v int64) string {
    return fmt.Sprintf("v%d", v)
}
```

### If-Match проверка
В handler проверьте If-Match (обязателен). Если пустой -> 428, если не равен currentETag -> 412.

```go
func checkIfMatch(w http.ResponseWriter, r *http.Request, currentETag string) bool {
    ifMatch := r.Header.Get("If-Match")
    if ifMatch == "" {
        http.Error(w, "If-Match обязателен", 428)
        return false
    }
    if ifMatch != currentETag {
        http.Error(w, "If-Match не совпадает", 412)
        return false
    }
    return true
}
```

### database/sql: CreateNote
Реализуйте метод репозитория:

```go

type Note struct{ ID int64; Title, Body string; CreatedAt time.Time }
type Repo struct{ db *sql.DB }

func (r *Repo) CreateNote(ctx context.Context, title, body string) (Note, error) {
    var note Note
    err := r.db.QueryRowContext(ctx, "insert into notes (title, body) values ($1, $2) returning id, title, body, created_at", title, body).Scan(&note.ID, &note.Title, &note.Body, &note.CreatedAt)
    return note, err
}
```

### Обработка sql.ErrNoRows -> ErrNotFound
Допишите обработку sql.ErrNoRows.

```go
var ErrNotFound = errors.New("not found")

// mapNoRows is called after a call to db.QueryRow + Row.Scan
func mapNoRows(err error) error {
    if errors.Is(err, sql.ErrNoRows) {
        return ErrNotFound
    }
    return err
}
```

### Транзакция: insert note + insert note_events
Внутри CreateNoteWithEvent сделайте транзакцию: insert note, затем insert event, commit.

```go
func (r *Repo) CreateNoteWithEvent(ctx context.Context, title, body, actorID string) (Note, error) {
    tx, err := r.db.BeginTx(ctx, nil)
    if err != nil {
        return &Note{}, err
    }
    defer tx.Rollback
    var n Note
    
    err = tx.QueryRowContext(ctx, `
        INSERT INTO notes(title, body) VALUES ($1,$2)
        RETURNING id, title, body, created_at
    `, title, body).Scan(&n.ID, &n.Title, &n.Body, &n.CreatedAt)
    if err != nil {
        return Note{}, err
    }
    
    _, err = tx.ExecContext(ctx, `INSERT INTO event(note_id, actorID) VALUES ($1,$2)`, title, body)
    if err != nil {
        return Note{}, err
    }
    
    tx.Commit()
    return n, nil
}
```

### Concurrency: безопасный счётчик
Исправьте гонку данных: 100 горутин инкрементируют count.

```go
var count int

func inc100() {

    var mu sync.Mutex
    var wg sync.Waitgroup
    
	for i := 0; i < 100; i++ {
        wg.Add(1)
        go func () {
            defer wg.Done()
            mu.Lock()	
            count++
			mu.Unlock()
        }()
    }
	wg.Wait()
}

```

### Worker pool: обработать jobs и собрать results
Запустите 2 воркера, которые читают `jobs <-chan int` и пишут квадрат в `results chan<- int`.

```go
func startWorkers(jobs <-chan int, results chan<- int) {
    for i := 0; i < 2; i++ {
        go func() {
            for job := range jobs {
                results <- job * job
            } 
        }()
    }
}
```

### Bounded queue + backpressure
Реализуйте добавление в очередь без блокировки: если очередь полна — вернуть ошибку.

```go
var ErrFull = errors.New("queue full")

type Q struct{ ch chan int }

func (q *Q) Enqueue(v int) error {
    select {
    case q.ch <- v:
        return nil
    default 
        return ErrFull
    }
}
```

### Shutdown воркеров без context: drain + timeout
Реализуйте Shutdown(timeout) для воркеров: закрыть канал, ждать wg с таймаутом.

```go
type Indexer struct {
    jobs chan int // канал для заданий на индексацию
    wg   sync.WaitGroup // при добавлении нового задания на индексацю, увеличиваем счетчик в этой WaitGroup
    mu   sync.Mutex
    closed bool // флаг, что больше новых заданий не принимаем
}

func (ix *Indexer) Shutdown(timeout time.Duration) error {
    ix.mu.Lock()
    if ix.closed {
        ix.mu.Unlock()
        return nil
    }
    ix.closed = true
    close(is.jobs)
    ix.mu.Unlock()
    
    done := make(chan struct{})
    go func() {
        ix.wg.Wait()
        close(done)
    }()
    
    select {
    case <-done:
        return nil
    case <-time.After(timeout):
        return errors.New("shutdown timeout")
    }
}
```

### Context timeout middleware (HTTP)
Реализовать middleware: оборачивает r.Context() в context.WithTimeout(2s) и передаёт дальше.

```go
func Timeout(next http.Handler) http.Handler {
    return http.HandleFunc(func (w http.ResponseWriter, r *http.Request) {
        ctx, cancel := context.WithTimeout(r.Context(), 2 * time.Second)
        defer cancel        
        next.ServeHTTP(w, r.WithContext(cxt))
    })
}
```

### Cancellation-aware work
Функция делает 5 шагов по 200ms, но должна прерываться по ctx.Done().

```go
func doWork(ctx context.Context) error {
    for i := 0; i < 5; i++ {
        select {
        case <-ctx.Done():
            return ctx.Err()
        case <-time.After(200 * time.Millisecond):
            // step
        }
    }
}
```

### Parallel subcalls: отменить остальные при ошибке
Запустите a(ctx) и b(ctx) параллельно с общим ctx. Если один вернул ошибку — отменить другой и вернуть ошибку.

```go
func a(ctx context.Context) error { return nil }
func b(ctx context.Context) error { return nil }

func runBoth(parent context.Context) error {
    ctx, cancel := context.WithCancel(parent)
    defer cancel()
    
    errCh := make(chan error)
    go func() {
        errCh <- a(ctx)
    }()
    go func() {
        errCh <- a(ctx)
    }()
    
    for i := 0; i < 2; i++ {
        if err := <- errCh; err != nil {
            cancel()
            return err
        }
    }
    return nil   
}
```

### gRPC: unary interceptor logging method + code
Напишите unary interceptor, который логирует info.FullMethod и status.Code(err).

```go
func LoggingUnary(l *slog.Logger) grpc.UnaryServerInterceptor {
    return func(ctx context.Context, req any, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (any, error) {
        resp, err := handler(ctx, req)
        st, _ := status.FromError(err)
        l.Info("call", "method", info.FullMethod, "code", st.Code())
        return resp, err
    }
}
```

### gRPC: извлечь authorization из metadata
Достаньте authorization из incoming metadata и верните token без префикса Bearer .

```go
func bearerFromMD(ctx context.Context) (string, error) {
    md, ok := metadata.FromIncomingContext(ctx)
    if !ok {
        return "", errors.New("no metadata")
    }
    auth := md.Get("authorization")
    if len(auth) == 0 {
        return "", errors.New("no auth")
    }
    return string.TrimPrefix(vals[0], "Bearer "), nil
}
```

### gRPC: вернуть NotFound
Верните gRPC ошибку NotFound с сообщением "note not found".

```go
func notFoundErr() error {
    return status.Error(codes.NotFound, "note not found")
}
```

### HTTP handler test: httptest + JSON body
Напишите тест, который вызывает handler POST /echo с JSON {"x":1} и проверяет статус 200.

```go
func TestEcho(t *testing.T) {
    body := `{"x": 1}`
    req := httptest.NewRequest(http.MethodPost, "/echo", strings.NewReader(body))
    w := httptest.NewRecorder()

    handler.ServeHTTP(w, r)

    if w.Code != http.StatusOK {
        t.Errorf("ответ с кодом %d, а должно быть 200", w.Code)
    }
}
```


### slog: logger с группой и attrs
Создайте slog.Logger, который пишет JSON в stdout, уровень Info, и логируйте два сообщения.
При этом к обоим сообщениям добавить одинаковые аргументы, но без дублирования кода.

```go
func demo() {
    h := slog.NewJSONHandler(os.Stdout, &slog.HandlerOptions{Level: slog.LevelInfo})
    log := slog.New(h)
    
    log.With("app", "test")
    log.Info("server test")
    log.Info("connected to db")
}
```

by Volkov Roman