# Используем официальный образ Python
FROM python:3.10-slim

# Устанавливаем системные зависимости для Odoo и psycopg2
RUN apt-get update && apt-get install -y \
    git \
    gcc \
    g++ \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    libldap2-dev \
    libsasl2-dev \
    python3-dev \
    libffi-dev \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Создаём рабочую директорию
WORKDIR /odoo

# Копируем все файлы в контейнер
COPY . .

# Устанавливаем зависимости Python
RUN pip3 install --upgrade pip setuptools wheel
RUN pip3 install psycopg2-binary
RUN pip3 install -r requirements.txt || true

# Добавляем права на выполнение entrypoint.sh
RUN chmod +x /odoo/entrypoint.sh

# Указываем порт
EXPOSE 8069

# Точка входа
ENTRYPOINT ["/odoo/entrypoint.sh"]
