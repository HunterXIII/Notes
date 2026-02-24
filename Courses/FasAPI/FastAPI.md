# Установка 
```sh
pip install fastapi
```
# Минимальная программа и запуск
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def root():
    return "Hello World"
```
Для запуска есть несколько вариантов:
- `fastapi dev main.py`
- `uvicorn main:app --reload` - через uvicor
> `--reload` - автоматический перезапуск после изменений
- `python main.py` - основной способ для деплоя, но для этого в `main.py`
```python
import uvicorn

...

if __name__ == "__main__":
    uvicorn.run("main:app", reload=True) # тут также можно указать port, host, ...
```
# Про ручки(endpoints)
```python
@app.get("/", summary="Главная", tags=["Основные страницы"])
```
То есть просто декоратор с указание метода запроса и пути. Дополнительно можно указать:
- `summary` - название эндпоинта
- `tags` - тэги для разделения эндпоинтов  
  
> FastAPI многое делает автоматически, как раз генерация OpenAPI(Swagger), открыть можно по адресу `/docs`

# Пример простейшего приложения (CRUD)
```python
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

books = [
    {
        "id": 1,
        "title": "Something",
        "author": "Unknown"
    },
    {
        "id": 2,
        "title": "Something 2",
        "author": "Who"
    }
]

@app.get("/books", summary="Получить все книги", tags=["Книги"])
def read_books():
    return books

@app.get("/books/{book_id}", summary="Получить конкретную книгу", tags=["Книги"])
def get_book(book_id: int):
    for book in books:
        if book["id"] == book_id:
            return book

    raise HTTPException(status_code=404)

# из библиотеки pydantic
class NewBook(BaseModel):
    title: str
    author: str

@app.post("/books", summary="Создать книгу", tags=["Книги"])
def create_book(new_book: NewBook):
    
    book = {
        "id": len(books) + 1,
        "title": new_book.title,
        "author": new_book.author
    }
    
    books.append(book)

    #return book
    return {"succes": True, "messages": "Книга создана"}
```
- Для принятия данных используется библиотека [Pydantic](./Pydantic)
- FastAPI автоматически переводит объекты Python(списки, словари, классы...) в JSON-формат