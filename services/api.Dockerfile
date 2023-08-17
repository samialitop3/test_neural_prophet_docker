FROM ubuntu:20.04

ENV TZ=Etc/UTC
ENV PYTHONUNBUFFERED 1
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /TNP

RUN apt-get update && apt-get install -y  software-properties-common && add-apt-repository ppa:deadsnakes/ppa

RUN apt-get update && apt-get install -y python3.11 python3-pip

RUN pip install --upgrade pip

# required to run pg
RUN apt-get install -y libpq-dev

# Dev utilities
RUN apt-get install -y curl wget jq nano

# Libraries needed to run the API server
COPY ./requirements.txt /tmp/requirements.txt

RUN pip install -r /tmp/requirements.txt

COPY ./test_neural/ /TNP

COPY ./entrypoint_api.sh /usr/bin/entrypoint.sh

ENTRYPOINT /usr/bin/entrypoint.sh
#CMD python3 manage.py makemigrations --settings=core.settings.dev && python3 manage.py migrate --settings=core.settings.dev && python3 manage.py runserver 0.0.0.0:8000 --settings=core.settings.dev

#CMD python3 manage.py makemigrations --settings=core.settings.dev && python3 manage.py migrate --settings=core.settings.dev && python3 manage.py runserver 0.0.0.0:8000 --settings=core.settings.dev --noreload
