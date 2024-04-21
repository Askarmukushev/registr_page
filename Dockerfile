# Используем официальный образ Python как базовый образ
FROM python:3.11-slim

# Установим рабочую директорию в контейнере
WORKDIR /app

# Добавим текущую директорию в контейнер
ADD . /app

USER root
# Установим необходимые пакеты
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17

# зависимости проекта
RUN python3.11 -m pip install --no-cache-dir -r requirements.txt

# порт, который будет слушать приложение
EXPOSE 8000

# Укажем команду для запуска приложения
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
