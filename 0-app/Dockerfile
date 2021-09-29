FROM python:3.7

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY ./0-app/requirements.txt ./
RUN pip install -r requirements.txt
#RUN pip install -r ./Pipfile
COPY ./0-app/ .
RUN ["/bin/bash", "-c", "chmod 755 ./start.sh"]
EXPOSE 8000
CMD ["./start.sh"]
