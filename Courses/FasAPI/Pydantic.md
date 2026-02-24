Все модели наследуются от `BaseModel`
```python
from pydantic import BaseModel

# Имитация входных данных
data = {
    "email": "abc@mail.ru",
    "bio": None,
    "age": 12
}

class UserModel(BaseModel):
    email: str
    bio: str | None
    age: int
```

Для более сильной валидации можно использовать `Field` или даже специальные типы полей (например, `EmailStr`):
```python
from pydantic import BaseModel, Field, EmailStr

class UserModel(BaseModel):
    email: EmailStr
    bio: str | None = Field(max_length=1000)
    age: int = Field(ge=0, le=130) # ge - больше или равно, ...
```

 > `repr(UserModel(**data))` - для понятного отображения
 
# Наследование
Наследование работает точно также как и в обычном python, то есть мы можем создавать модели, которые наследуют уже от других моделй

# Строгое ограничение на входные данные
```python
from pydantic import BaseModel, Field, EmailStr, ConfigDict

class UserModel(BaseModel):
    email: EmailStr
    bio: str | None = Field(max_length=1000)
    age: int = Field(ge=0, le=130) 
    
    model_config = ConfigDict(extra="forbid") 
```
  
`extra='forbid'` - не разрешает больше ключей во входных данных, чем в модели  

