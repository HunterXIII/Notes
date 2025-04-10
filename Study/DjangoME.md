
`django-admin startproject <name> <dir>`
`python manage.py runserver` - запуск сервера
`python manage.py createsuperuser` - создание администратора
# Model
Все модели наследуются от `model` из `django.db`.  
Поля таблицы обозначаются как **свойства класса**  
Пример модели:
```Python
from django.db import models

# Create your models here.
class Questions(models.Model):
    question_text = models.CharField(max_length=100)
    pub_date = models.DateTimeField("date published")

class Choice(models.Model):
    question = models.ForeignKey(Questions, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)
```
`CharField`, `IntegerField` и `DateTimeField` - соответствующие типы столбцов в БД 

## Внесение изменений в модель: 
- Измените свои модели (в `models.py`).
- Запустите `python manage.py makemigrations`, чтобы создать миграции для этих изменений
- Запустите `python manage.py migrate`, чтобы применить эти изменения к базе данных.
# INSTALLED APPS
Для подключения приложения к проекту в файле `setting.py`, указывает наше приложение в формате класса, который лежит в `name_app.apps.NameAppConfig`

# URL patterns
```python
 # /polls/
    path("", views.index, name="index"),
    # /polls/<int>
    path("<int:question_id>/", views.detail, name="detail"),
    # /polls/<int>/results
    path("<int:question_id>/results/", views.results, name="results"),
    # /polls/<int>/vote
    path("<int:question_id>/vote/", views.vote, name="vote")
```

# Представление с использованием шаблона
```python
from django.shortcuts import render 


from .models import Question

def index(request):
    latest_question_list = Question.objects.order_by("-pub_date")[:5]
    context = {
        "latest_question_list": latest_question_list 
    }
    return render(request, "polls/index.html", context)
```
# Начало
```sh
django-admin startproject <name>
```  
После выполнения появится папка с названием проекта
## Основные файлы
- `settings.py` -  настройки проекта
- `urls.py` - основные URL пути 
- `mange.py` - утилита для управления проектом
- `wsgi.py` - для деплоя
## Ключевые настройки `settings.py`
- `DEBUG = True` - режим отладки (в продакшене ставить `False`)
- `INSTALLED_APPS` - список установленных приложений
- `DATABASE` - настройка базы данных (по умолчанию `SQLite`, но можно и другие, например, `PostgreSQL`)
- `STATIC_URL` - путь к статическим файлам (CSS, JS)
## Запуск сервера
```sh
python manage.py runserver
```
# Приложения (Apps)
Весь **проект** Django делится на **приложения**.  
> Одна задача - одно приложение

## Создание приложений
```sh
python manage.py startapp <name>
```
## Структура
```
myapp/
    migrations/
    templates/
    __init__.py
    admin.py
    apps.py
    models.py
    tests.py
    urls.py
    views.py
```
- `migrations/` - Миграции БД
- `templates/` - HTML-шаблоны
- `admin.py` - настройки интерфейса администратора
- `apps.py` - класс, который фактически является ссылкой на наше приложение. Путь до этого класса указывается в `INSTALLED_APPS`
- `models.py` - таблицы БД
- `urls.py` - URL-адреса и шаблоны приложения 
- `views.py` - обработка запросов

# Миграции
**Миграции** — это способ автоматического обновления структуры базы данных в соответствии с изменениями в моделях Django.  
1. Создание миграций
После изменения моделей выполните:
```sh
python manage.py makemigrations
```
Django анализирует модели и генерирует файлы миграций (в папке migrations/ приложения).  
Файлы миграций содержат инструкции для БД (создание/изменение таблиц, полей).

2. Применение миграций
```sh
python manage.py migrate
```
Django применяет все непримененные миграции к базе данных.
