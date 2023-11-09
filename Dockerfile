FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# Python 3
RUN apt-get update; apt-get -y install python3; apt-get install -y python3-pip;

# Java
RUN apt-get -y install default-jdk

# JupyterLab
RUN python3 -m pip install jupyterlab;

# Scala Almond
RUN apt-get install -y curl; curl -Lo coursier https://git.io/coursier-cli; chmod +x coursier; ./coursier launch --fork almond -- --install; rm -f coursier;

EXPOSE 8888

WORKDIR /home

# Overview of scalapy
COPY ./scalapy-intro.ipynb /home/scalapy-intro.ipynb

# Python module installation
COPY requirements.txt /home/requirements.txt
RUN pip install -r /home/requirements.txt
CMD ["python3", "-m", "jupyter", "lab", "--allow-root", "--ip", "0.0.0.0"]