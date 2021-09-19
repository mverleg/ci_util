
FROM python:3.9.7-slim

WORKDIR /code

RUN apt-get update &&\
     apt-get install -y git &&\
     apt-get clean

RUN pip install 'black' 'isort' 'autopep8' 'flake8'

COPY ./python_clean.sh /python_clean.sh

ENTRYPOINT [ "bash", "/python_clean.sh" ]

