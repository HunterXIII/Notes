Есть **продюсеры**(записывают сообщения) и **консьюмеры**(читает и обрабатывает)  
  
Шаблонный код:
```python
from pika import ConnectionParameters, BlockingConnection

connection_params = ConnectionParameters(
    host="localhost",
    port=5672
)

def main():
    with BlockingConnection(connection_params) as conn:
        with conn.channel() as ch:
            ch.queue_declare(queue="messages")

            

            print("Message sent")

if __name__ == "__main__":
    main()
```

# Отправка сообщений
```python 
ch.basic_publish(
    exchange="",
    routing_key="messages", # очередь
    body="Hello" # само сообщение
)
```
# Обработка
```python
ch.basic_consume(
    queue="messages", # из какой очереди прочитать
    on_message_callback=proccess_mesage, # какой функцией обработать
)
...
ch.start_consuming()
```
и какая-то функция-обработчик
```python
def proccess_mesage(ch, method, property, body):
    print(f"Получено сообщение: {body.decode()}")
```
## Помечаем сообщение как обработанное
```python
ch.basic_consume(
    queue="messages"
    on_message_callback=proccess_mesage
    auto_ack=True # 
)

```
> В данном методе мы сразу говорим, что сообщение получено и только потом идём его обрабатывать (поэтому это решение не очень хорошее)  
  
Второй способ в функции обработчике:
```python
def proccess_mesage(ch, method, property, body):
    print(f"Получено сообщение: {body.decode()}")
    
    ch.basic_ack(delivery_tag=method.delivery_tag)
```
> Теперь если до `ch.basic_ack` функция упадёт с ошибкой, то сообщение не будет помечено как обработанное  
  
