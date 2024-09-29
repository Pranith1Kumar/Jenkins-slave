FROM jenkins/slave:latest
USER root
RUN apt-get update && apt-get install -y \
    git \
    openjdk-11-jdk \
    && rm -rf /var/lib/apt/lists/*
USER jenkins
