# Используем официальный образ Odoo 18
FROM odoo:18.0

# Устанавливаем зависимости (по желанию)
USER root
RUN pip3 install psycopg2-binary

# Копируем entrypoint (если у тебя будет свой)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Переход на пользователя odoo
USER odoo
EXPOSE 8069
CMD ["odoo", "-d", "odoo", "--db_host", "db", "--db_user", "odoo", "--db_password", "odoo"]

