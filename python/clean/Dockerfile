
FROM 3.9.7-alpine3.14

WORKDIR /code

RUN pip install black isort flake8

COPY ./python_clean.py /python_clean.py

ENTRYPOINT ['/python_clean.sh']

