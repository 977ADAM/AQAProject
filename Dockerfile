FROM python:3.11-alpine3.18
    
RUN apk update && \
    apk add --no-cache \
    chromium \
    chromium-chromedriver \
    tzdata \
    openjdk11-jre \
    curl \
    tar \
    bash

ENV ALLURE_VERSION=2.35.1
RUN curl -f -o allure-${ALLURE_VERSION}.tgz -Ls \
    https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/${ALLURE_VERSION}/allure-commandline-${ALLURE_VERSION}.tgz && \
    tar -zxvf allure-${ALLURE_VERSION}.tgz -C /opt/ && \
    ln -s /opt/allure-${ALLURE_VERSION}/bin/allure /usr/bin/allure && \
    rm allure-${ALLURE_VERSION}.tgz

WORKDIR /usr/workspace

COPY requirements.txt .

RUN pip install -r requirements.txt