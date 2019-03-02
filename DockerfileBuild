FROM python:3.7-alpine3.9
MAINTAINER Henning Jacobs <henning@jacobs1.de>

WORKDIR /app

COPY Pipfile /app

RUN pip install pipenv
RUN pipenv install --dev
