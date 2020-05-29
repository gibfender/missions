FROM python:3.6-alpine

RUN adduser -D missions

WORKDIR /home/missions

# install psycopg2 dependencies
RUN apk update
RUN apk add postgresql-dev gcc python3-dev musl-dev

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install -r requirements.txt
RUN venv/bin/pip install gunicorn pymysql

COPY app app
COPY migrations migrations
COPY missions.py config.py boot.sh ./
RUN chmod +x boot.sh

ENV FLASK_APP missions.py

RUN chown -R missions:missions ./
USER missions

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]